import json
import boto3
import requests
from datetime import datetime
from dateutil.parser import parse
import time

def lambda_handler(event, context):
    client_id = '782c2ec102171410894fbf5baab5f7b9'
    client_secret = "q)&L09fV6T"
    RO_user = 'bt_purple_integration_user_dev'
    RO_password = '8S;t+6]@A1,c)b'
    token_url = "https://btkanodev.service-now.com/oauth_token.do"
    test_api_url = "https://btkanodev.service-now.com/api/x_bttm_bt_tmf642_e/tmf642_eventmgmt/stacks"
    # Print the Event Details
    print(json.dumps(event))
    
    # Parsing and extracting Event Data
    message = json.loads(event['Records'][0]['Sns']['Message'])
    subject = event['Records'][0]['Sns']['Subject']
    alarm = message['AlarmName']
    awsid = message['AWSAccountId']
    alarm_arn = message['AlarmArn']
    messageid = event['Records'][0]['Sns']['MessageId']
    topic_arn = event['Records'][0]['Sns']['TopicArn']
    
    state = message['NewStateValue']
    threshold = message['Trigger']['Threshold']
    metric_namespace = message['Trigger']['Namespace']
    instance_name = message['Trigger']['Dimensions'][0]['name']
    
    #instance_did = message['Trigger']['Dimensions'][1]['value']
    if(instance_name != 'InstanceId'):
        instance_id = message['Trigger']['Dimensions'][1]['value']
    if (instance_name == 'InstanceId'):
        instance_id = message['Trigger']['Dimensions'][0]['value']
    
    timestamp = message['StateChangeTime']
    dt = parse(timestamp)
    time = str(dt)
    #print(threshold)
    if(state == "ALARM"):
        alarm_state = "has breached its "
        cause_state = "Threshold crossed "
    else:
        alarm_state = "is in normal state"
    cause = message['NewStateReason']
    metric_name = message['Trigger']['MetricName']
    alarm_des = message['AlarmDescription']
    
    
    # Getting Intsnace details
    ec2_client = boto3.client('ec2')
    instance_info = ec2_client.describe_instances(InstanceIds=[instance_id])
    instance = instance_info['Reservations'][0]['Instances'][0]
    #print (instance)
		
    # Extract name tag
    name_tags = [t['Value'] for t in instance['Tags'] if t['Key']=='Name']
    name = name_tags[0] if name_tags is not None else ''
    
    # Rewriting Service now event in temporary 
    
    with open('alarm.json','r') as input_file:
        data = json.load(input_file)
        if data['event']['alarm']['id'] in ["Alarm_id"]:
            data['event']['alarm']['id'] = alarm_arn
        if data['event']['alarm']['alarmType'] in ["Alarm_type"]:
            data['event']['alarm']['alarmType'] = metric_name
        if data['event']['alarm']['probableCause'] in ["Cause"]:
            #data['event']['alarm']['probableCause'] = alarm_state
            data['event']['alarm']['probableCause'] = cause_state + ' ' + str(threshold) + ' % - ' + alarm
            #data['event']['alarm']['probableCause'] = metric_name + '  ' + cause_state + ' - ' + alarm
        if data['event']['alarm']['alarmDetails'] in ["Alarm_Description"]:
            data['event']['alarm']['alarmDetails'] = alarm_des + ',' + '  \n AWS_ACCOUNT_ID: ' + awsid + '\n Instance_name: ' +name + '\n Instance_Id: ' +instance_id
            #data['event']['alarm']['alarmDetails'] = 'AWS_ACCOUNT_ID: ' + awsid ', ' + alarm_des +  + '\n Instance_name: ' +name + ' \n Instance_Id: ' +instance_id
        if data['event']['alarm']['alarmRaisedTime'] in ["Timestamp"]:
            data['event']['alarm']['alarmRaisedTime'] = time
        if data['event']['alarm']['alarmState'] in ["State"]:
            if (state == "ALARM"):
                data['event']['alarm']['alarmState'] = "ALARM"
            elif (state == "OK"):
                data['event']['alarm']['alarmState'] = "OK"
        if data['event']['alarm']['perceivedSeverity'] in [""]:
            if (threshold == 60):
                data['event']['alarm']['perceivedSeverity'] = "MEDIUM"
            elif (threshold == 75):
                data['event']['alarm']['perceivedSeverity'] = "HIGH"
            elif (threshold == 85):
                data['event']['alarm']['perceivedSeverity'] = "CRITICAL"
    
    # Dumping Extracted data into alarm.json file     
    with open('/tmp/alarm.json','w') as input_file:
        json.dump(data, input_file, indent=2)
        output_file = open('/tmp/alarm.json',)
    payload = {
        'grant_type': 'password',
        'client_id': client_id,
        'client_secret': client_secret,
        'username': RO_user,
        'password': RO_password
    }
    #re = requests.get('{}?response_type=code&client_id={}&redirect_uri={}'.format(AUTHORIZE_URL, CLIENT_ID, REDIRECT_URI))
    access_token_response = requests.post("https://btkanodev.service-now.com/oauth_token.do", 
                            headers={"Content-Type":"application/x-www-form-urlencoded"},
                            data=payload)
 
    print (access_token_response.content)
    print (access_token_response.headers)
    print (access_token_response.text)
    
    tokens = json.loads(access_token_response.text)
    print ("access token:" + tokens['access_token'])
    
    api_call_headers = {'Authorization': 'Bearer ' + tokens['access_token'], 'Content-Type': 'application/json'}
    print (api_call_headers)
    api_call_response = requests.post(test_api_url, headers=api_call_headers, data=output_file)
    print (api_call_response.text)
    
   # Sending Email Notification through SNS
    MY_SNS_TOPIC_ARN= "arn:aws:sns:eu-west-2:942944832559:App15529_Ciena-Service-Order-Fulfilment_EC2-Dev_DevOps_Lambda_Log_Topic"
    sns_client = boto3.client('sns')
    if(metric_namespace == "CienaApplicationLogs"):
        sns_client.publish(
        TopicArn = MY_SNS_TOPIC_ARN,
        Subject = str(subject),
        Message =  ' The Application ' + metric_name.upper() +' has triggerd '+ alarm_state + '. because it has crossed the threshold Value !!' +'\n' +
                  '\n Alarm Name: ' +str(alarm) +'\n'+
				  'Message_ID: ' +str(messageid) +'\n'+
				  'Topic_Arn: ' +str(topic_arn) +'\n'+
				  'AWS_ACCOUNT_ID: ' +str(awsid) +'\n'+
				  'Metric_Name: ' +str(metric_name) +'\n'
				  'State: ' +str(state) +'\n'+
				  'Cause: ' +str(cause) +'\n'+
				  'Alarm Description: ' +str(alarm_des)
		)
    else:
        sns_client.publish(
        TopicArn = MY_SNS_TOPIC_ARN,
        Subject = str(subject),
        Message = 'The ' + name.upper() + ' ' +alarm_state+ ' ' +metric_name.upper() + ' Threshold Value !!' +'\n'+
                  'Alarm Name: ' +str(alarm) +'\n'+
				  'Message_ID: ' +str(messageid) +'\n'+
				  'Topic_Arn: ' +str(topic_arn) +'\n'+
				  'AWS_ACCOUNT_ID: ' +str(awsid) +'\n'+
				  'Metric_Name: ' +str(metric_name) +'\n'+
				  'Instance_Id: ' +str(instance_id) +'\n'+
				  'State: ' +str(state) +'\n'+
				  'Cause: ' +str(cause) +'\n'+
				  'Alarm Description: ' +str(alarm_des)             
        )