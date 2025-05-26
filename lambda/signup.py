import boto3
import os
import json

client = boto3.client('cognito-idp')

USER_POOL_ID = os.environ.get('USER_POOL_ID')
CLIENT_ID = os.environ.get('CLIENT_ID')

def lambda_handler(event, context):
    print("Event received:", event)

    try:
        body = json.loads(event['body'])
        print("Parsed body:", body)

        # Signup işlemi
        response = client.sign_up(
            ClientId=CLIENT_ID,
            Username=body['email'],
            Password=body['password'],
            UserAttributes=[
                {'Name': 'email', 'Value': body['email']}
            ]
        )

        # Admin olarak kullanıcıyı onaylama
        client.admin_confirm_sign_up(
            UserPoolId=USER_POOL_ID,
            Username=body['email']
        )

        print("Signup response:", response)

        return {
            'statusCode': 200,
            'body': json.dumps({'message': 'User created and confirmed.'})
        }

    except client.exceptions.UsernameExistsException:
        return {
            'statusCode': 400,
            'body': json.dumps({'message': 'User already exists'})
        }

    except Exception as e:
        print("Error occurred:", str(e))
        return {
            'statusCode': 500,
            'body': json.dumps({'message': str(e)})
        }
