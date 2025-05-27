import json
import boto3
import os

client = boto3.client('cognito-idp')
CLIENT_ID = os.environ.get('CLIENT_ID')

def lambda_handler(event, context):
    try:
        body = get_json_body(event)
        email = body['email']
        code = body['code']

        response = client.confirm_sign_up(
            ClientId=CLIENT_ID,
            Username=email,
            ConfirmationCode=code
        )

        return success_response({"message": "User confirmed successfully"})
    except client.exceptions.UserNotFoundException:
        return error_response("User not found", 404)
    except client.exceptions.CodeMismatchException:
        return error_response("Invalid confirmation code", 400)
    except client.exceptions.ExpiredCodeException:
        return error_response("Confirmation code expired", 410)
    except Exception as e:
        return error_response(str(e), 500)

def get_json_body(event):
    body = event.get('body')
    if body is None:
        raise ValueError("Request body is missing")

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
