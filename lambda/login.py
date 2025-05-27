import json
import boto3
import os

client = boto3.client('cognito-idp')
CLIENT_ID = os.environ.get('CLIENT_ID')

def lambda_handler(event, context):
    try:
        if not CLIENT_ID:
            raise ValueError("CLIENT_ID is not set in environment variables")

        body = get_json_body(event)
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

        return success_response({
            "message": "Login successful",
            "tokens": response["AuthenticationResult"]
        })

    except client.exceptions.NotAuthorizedException:
        return error_response("Incorrect username or password", 401)
    except client.exceptions.UserNotConfirmedException:
        return error_response("User account is not confirmed", 403)
    except client.exceptions.UserNotFoundException:
        return error_response("User not found", 404)
    except client.exceptions.PasswordResetRequiredException:
        return error_response("Password reset required for this user", 428)
    except Exception as e:
        return error_response(str(e), 500)

def get_json_body(event):
    body = event.get('body')
    if not body:
        raise ValueError("Missing request body")

    if isinstance(body, str):
        return json.loads(body)
    elif isinstance(body, dict):
        return body
    else:
        raise ValueError("Unsupported body format")

def success_response(body):
    return {
        "statusCode": 200,
        "headers": cors_headers(),
        "body": json.dumps(body)
    }

def error_response(message, status_code):
    return {
        "statusCode": status_code,
        "headers": cors_headers(),
        "body": json.dumps({"error": message})
    }

def cors_headers():
    return {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "*",
        "Access-Control-Allow-Methods": "*"
    }
