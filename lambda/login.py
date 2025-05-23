import boto3
import os
import json

client = boto3.client('cognito-idp')

USER_POOL_ID = os.environ.get('USER_POOL_ID')
CLIENT_ID = os.environ.get('CLIENT_ID')

def lambda_handler(event, context):
    body = json.loads(event['body'])

    try:
        response = client.initiate_auth(
            AuthFlow='USER_PASSWORD_AUTH',
            AuthParameters={
                'USERNAME': body['email'],
                'PASSWORD': body['password']
            },
            ClientId=CLIENT_ID
        )

        return {
            'statusCode': 200,
            'body': json.dumps({
                'access_token': response['AuthenticationResult']['AccessToken'],
                'refresh_token': response['AuthenticationResult']['RefreshToken'],
                'id_token': response['AuthenticationResult']['IdToken'],
            })
        }

    except client.exceptions.NotAuthorizedException:
        return {
            'statusCode': 401,
            'body': json.dumps({'message': 'Incorrect username or password'})
        }

    except client.exceptions.UserNotConfirmedException:
        return {
            'statusCode': 403,
            'body': json.dumps({'message': 'User not confirmed'})
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'message': str(e)})
        }
