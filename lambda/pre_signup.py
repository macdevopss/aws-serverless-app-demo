def lambda_handler(event, context):
    try:
        print("PreSignUp event received:", event)

        # Automatically confirm the user
        event['response']['autoConfirmUser'] = True

        # Automatically verify the email address
        event['response']['autoVerifyEmail'] = True

        print("User will be auto-confirmed and email auto-verified.")

    except Exception as e:
        print("Error in pre-signup trigger:", str(e))

    return event
