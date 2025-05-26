import boto3
import os
import json

client = boto3.client('cognito-idp')

CLIENT_ID = os.environ.get('CLIENT_ID')

def lambda_handler(event, context):
    print("Event received:", event)

    try:
        body = json.loads(event['body'])
        email = body['email']
        password = body['password']

        response = client.initiate_auth(
            AuthFlow='USER_PASSWORD_AUTH',
            AuthParameters={
                'USERNAME': email,
                'PASSWORD': password
            },
            ClientId=CLIENT_ID
        )

        print("Login successful:", response)

        return {
            'statusCode': 200,
            'body': json.dumps({
                'message': 'Login successful',
                'id_token': response['AuthenticationResult']['IdToken'],
                'access_token': response['AuthenticationResult']['AccessToken'],
                'refresh_token': response['AuthenticationResult']['RefreshToken']
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
            'body': json.dumps({'message': 'User not confirmed. Please verify your email.'})
        }

    except Exception as e:
        print("Error:", str(e))
        return {
            'statusCode': 500,
            'body': json.dumps({'message': str(e)})
        }
