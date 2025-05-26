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

        response = client.confirm_sign_up(
            ClientId=CLIENT_ID,
            Username=body['email'],
            ConfirmationCode=body['code']
        )

        print("Confirmation response:", response)

        return {
            'statusCode': 200,
            'body': json.dumps({'message': 'User confirmed successfully'})
        }

    except client.exceptions.CodeMismatchException:
        return {
            'statusCode': 400,
            'body': json.dumps({'message': 'Invalid confirmation code'})
        }
    except client.exceptions.ExpiredCodeException:
        return {
            'statusCode': 400,
            'body': json.dumps({'message': 'Confirmation code expired'})
        }
    except Exception as e:
        print("Error occurred:", str(e))
        return {
            'statusCode': 500,
            'body': json.dumps({'message': str(e)})
        }
