import json
import boto3
import requests
from datetime import datetime
from dateutil.parser import parse
import time


#cause_state = 0

def lambda_handler(event, context):
    
    # Service Now Enpoint Details 

    client_id = '782c2ec102171410894fbf5baab5f7b9'
    client_secret = "q)&L09fV6T"
    RO_user = 'bt_purple_integration_user_test'
    RO_password = '3S8~kv6<gP+\=['
    token_url = "https://btkanotest.service-now.com/oauth_token.do"
    test_api_url = "https://btkanotest.service-now.com/api/x_bttm_bt_tmf642_e/tmf642_eventmgmt/stacks"
    
    
    # Print the Event Details 
    
    print(json.dumps(event))
    message = json.loads(event['Records'][0]['Sns']['Message'])
    subject = event['Records'][0]['Sns']['Subject']
    alarm = message['AlarmName']
    awsid = message['AWSAccountId']
    messageid = event['Records'][0]['Sns']['MessageId']
    topic_arn = event['Records'][0]['Sns']['TopicArn']
    alarm_arn = message['AlarmArn']
    
    state = message['NewStateValue']
    cause = message['NewStateReason']
    metric_name = message['Trigger']['MetricName']
    alarm_des = message['AlarmDescription']
    threshold = message['Trigger']['Threshold']
    
    service_name = message['Trigger']['Dimensions'][0]['value']
    service_type =  message['Trigger']['Dimensions'][0]['name']
    if(service_type == "Resource"):
        print(service_name)
    print(service_type)
    metric_namespace = message['Trigger']['Namespace']
    print(metric_namespace)
    
    if (threshold == 60):
        severity  = "MEDIUM"
    elif (threshold == 75):
        severity  = "HIGH"
    elif (threshold == 85): 
        severity  = "CRITICAL"
    elif (threshold == 3): 
        severity  = "CRITICAL"
    elif (threshold == 1): 
        severity  = "CRITICAL"
    elif (threshold == 10000): 
        severity  = "CRITICAL"
    
    
    timestamp = message['StateChangeTime']
    dt = parse(timestamp)
    time = str(dt)
    
    if(state == "ALARM"):
        alarm_state = " breached it's "
        cause_state = " has spiked to "
        event_subject =  metric_name + ' has spiked to ' + str(threshold) + ' and breached its ' +str(severity) + ' threshold value '
    else:
        alarm_state = "is in normal state"
        event_subject =  metric_name + ' is in normal state  now ' 
        # Rewriting Service now event in temporary 
    #event_subject = metric_name + alarm_state + str(threshold) + '  and breached its ' + str(severity) + ' threshold value!! ' 
    print(event_subject)
    
    # Read the TMF642 Alarm Template 
    with open('alarm.json','r') as input_file:
        data = json.load(input_file)
        if data['eventType'] in [""]:
            if (state == "ALARM"):
                data['eventType'] = "ALARM"
            elif (state == "OK"):
                data['eventType'] = "CLEAR"
        if data['event']['alarm']['id'] in ["Alarm_id"]:
            data['event']['alarm']['id'] = alarm_arn
        if data['event']['alarm']['alarmType'] in ["Alarm_type"]:
            data['event']['alarm']['alarmType'] = metric_name
        if data['event']['alarm']['specificProblem'] in [""]:
            data['event']['alarm']['specificProblem'] = event_subject
        if data['event']['alarm']['probableCause'] in ["Cause"]:
            data['event']['alarm']['probableCause'] = metric_name + cause_state + '-' + str(threshold) + ' - ' + alarm
            #else:
                #data['event']['alarm']['probableCause'] = cause_state + ' ' + str(threshold) + ' % - ' + alarm
            #data['event']['alarm']['probableCause'] = metric_name + '  ' + cause_state + ' - ' + alarm
        if data['event']['alarm']['comments'][0]['comment'] in [""]:
            data['event']['alarm']['comments'][0]['comment'] = alarm_des  + '  \n AWS_ACCOUNT_ID: ' + awsid 
            #data['event']['alarm']['alarmDetails'] = 'AWS_ACCOUNT_ID: ' + awsid ', ' + alarm_des +  + '\n Instance_name: ' +name + ' \n Instance_Id: ' +instance_id
        if data['event']['alarm']['alarmRaisedTime'] in ["Timestamp"]:
            data['event']['alarm']['alarmRaisedTime'] = time
        if data['event']['alarm']['alarmState'] in ["State"]:
            if (state == "ALARM"):
                data['event']['alarm']['alarmState'] = "ALARM"
            elif (state == "OK"):
                data['event']['alarm']['alarmState'] = "OK"
        if data['event']['alarm']['perceivedSeverity'] in [""]:
            data['event']['alarm']['perceivedSeverity'] = severity
        if data['event']['alarm']['alarmedObject']['id'] in [""]:
            data['event']['alarm']['alarmedObject']['id'] = metric_namespace
        
             
    
    # Dumping Extracted data into TMF642 Alarm template(alarm.json file )   
    
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
    access_token_response = requests.post("https://btkanotest.service-now.com/oauth_token.do", 
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
    
    
    
    
    # ************* SNS Notification on EMail * *******************************************
    
    MY_SNS_TOPIC_ARN = 'arn:aws:sns:eu-west-2:898900948160:App15549_Simplify-Core-Services_ECS-Test_DevOps_Notification_Topic'
    sns_client = boto3.client('sns')
    if(service_type == "QueueName"):
        sns_client.publish(
        TopicArn = MY_SNS_TOPIC_ARN,
        Subject = str(subject),
        Message =  ' The Number of Messages visible in the '+ service_name.upper() + ' queue ' + alarm_state +' '+ str(metric_name)+ ' Threshold Value !!' +'\n' +
                  
                  'Please find the below details of Sqs queue Metric:'
                  '\n Alarm Name: ' +str(alarm) +'\n'+
				  'Message_ID: ' +str(messageid) +'\n'+
				  'Topic_Arn: ' +str(topic_arn) +'\n'+
				  'AWS_ACCOUNT_ID: ' +str(awsid) +'\n'+
				  'Metric_Name: ' +str(metric_name) +'\n'+
				  'Queue_Name: ' +str(service_name) +'\n'+
				  'State: ' +str(state) +'\n'+
				  'Cause: ' +str(cause) +'\n'+
				  'Alarm Description: ' +str(alarm_des)
				  
		)
    elif(service_type == "ApiName"):
        sns_client.publish(
        TopicArn = MY_SNS_TOPIC_ARN,
        Subject = str(subject),
        Message =  ' The Api Gateway  ' + service_name.upper() +' Service '+ alarm_state +' '+ str(metric_name)+ ' Threshold Value !!' +'\n' +
                  '\n Alarm Name: ' +str(alarm) +'\n'+
				  'Message_ID: ' +str(messageid) +'\n'+
				  'Topic_Arn: ' +str(topic_arn) +'\n'+
				  'AWS_ACCOUNT_ID: ' +str(awsid) +'\n'+
				  'Metric_Name: ' +str(metric_name) +'\n'+
				  'Api_Name: ' +str(service_name) +'\n'+
				  'State: ' +str(state) +'\n'+
				  'Cause: ' +str(cause) +'\n'+
				  'Alarm Description: ' +str(alarm_des)
		)
    elif(metric_namespace == "Core-Integration-Services"):
        sns_client.publish(
        TopicArn = MY_SNS_TOPIC_ARN,
        Subject = str(subject),
        Message =  ' The Application ' + metric_name.upper() +' has triggerd '+ state + '. because it has crossed the threshold Value !!' +'\n' +
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
        Message = ' The ECS Fargate  '  + service_name.upper() +' Service '+ alarm_state +' '+ metric_name + ' Threshold Value !!' + '\n'+
               'Alarm Name: ' + alarm + '\n' +
			   'Message_ID: ' + messageid + '\n' +
			   'Topic_Arn: ' +str(topic_arn) +'\n'+
			   'AWS_ACCOUNT_ID: ' +str(awsid) +'\n'+
			   'Metric_Name: ' +str(metric_name) +'\n'+
			   'Service_Name: ' +str(service_name) +'\n'+
			   'State: ' +str(state) +'\n'+
			   'Cause: ' +str(cause) +'\n'+
			   'Alarm Description: ' +str(alarm_des)
		)
   