import json
import boto3
import os

client = boto3.client('cognito-idp')
CLIENT_ID = os.environ.get('CLIENT_ID')

def lambda_handler(event, context):
    print("DEBUG: Incoming event:", event)

    if not CLIENT_ID:
        return error_response("CLIENT_ID environment variable not set", 500)

    try:
        body = get_json_body(event)
        email = body.get('email')
        password = body.get('password')
        role = body.get('role', 'customer')

        if not email or not password:
            return error_response("Email and password are required", 400)

        response = client.sign_up(
            ClientId=CLIENT_ID,
            Username=email,
            Password=password,
            UserAttributes=[
                {'Name': 'email', 'Value': email},
                {'Name': 'custom:role', 'Value': role}
            ]
        )

        print("DEBUG: Signup successful:", response)
        return success_response({
            "message": "Signup successful",
            "userSub": response.get("UserSub")
        })

    except client.exceptions.UsernameExistsException:
        return error_response("User already exists", 400)
    except client.exceptions.InvalidPasswordException:
        return error_response("Password does not meet the required complexity", 400)
    except client.exceptions.InvalidParameterException as e:
        return error_response(f"Invalid parameters: {str(e)}", 400)
    except Exception as e:
        print("DEBUG: Exception occurred:", str(e))
        return error_response("Internal server error", 500)

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
