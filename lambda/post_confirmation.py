import boto3
import os

client = boto3.client('cognito-idp')
USER_POOL_ID = os.environ.get('USER_POOL_ID')

def lambda_handler(event, context):
    print("PostConfirmation event received.")

    if not USER_POOL_ID:
        print("USER_POOL_ID not found in environment variables.")
        return event

    email = event.get('userName')
    group = event.get('request', {}).get('userAttributes', {}).get('custom:role', 'customer')

    if not email:
        print("No userName found in event.")
        return event

    try:
        response = client.admin_add_user_to_group(
            UserPoolId=USER_POOL_ID,
            Username=email,
            GroupName=group
        )
        print(f"User '{email}' added to group '{group}' successfully.")
    except client.exceptions.ResourceNotFoundException:
        print(f"Group '{group}' not found in user pool.")
    except client.exceptions.InvalidParameterException as e:
        print(f"Invalid parameter: {e}")
    except Exception as e:
        print(f"Unexpected error adding user to group: {e}")

    return event
