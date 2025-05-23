import boto3
import os
import json

client = boto3.client('cognito-idp')

USER_POOL_ID = os.environ.get('USER_POOL_ID')
CLIENT_ID = os.environ.get('CLIENT_ID')

def lambda_handler(event, context):
    body = json.loads(event['body'])

    try:
        response = client.sign_up(
            ClientId=CLIENT_ID,
            Username=body['email'],
            Password=body['password'],
            UserAttributes=[
                {
                    'Name': 'email',
                    'Value': body['email']
                }
            ]
        )

        return {
            'statusCode': 200,
            'body': json.dumps({'message': 'User created. Confirm email.'})
        }

    except client.exceptions.UsernameExistsException:
        return {
            'statusCode': 400,
            'body': json.dumps({'message': 'User already exists'})
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'message': str(e)})
        }
