import json

def lambda_handler(event, context):
    print("PreSignUp event:", event)
    # Otomatik olarak email'i doğrulanmış gibi işaretle
    event['response']['autoConfirmUser'] = True
    event['response']['autoVerifyEmail'] = True
    return event
