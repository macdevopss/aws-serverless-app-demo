import json
import boto3
import os

client = boto3.client('cognito-idp')
USER_POOL_ID = os.environ['USER_POOL_ID']

def lambda_handler(event, context):
    print("PostConfirmation event:", event)
    email = event['userName']
    group = "customer"  # İstersen event['request']['userAttributes']'e göre grup ata
    try:
        response = client.admin_add_user_to_group(
            UserPoolId=USER_POOL_ID,
            Username=email,
            GroupName=group
        )
        print("User added to group:", response)
    except Exception as e:
        print("Error:", e)
    return event
