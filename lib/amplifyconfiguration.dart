const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "apicbb410f6": {
                    "endpointType": "REST",
                    "endpoint": "https://3d0zjl4cce.execute-api.us-east-1.amazonaws.com/dev",
                    "region": "us-east-1",
                    "authorizationType": "AWS_IAM"
                },
                "ashlife": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://jqmtztnh3nct7bt4thgwrafrmy.appsync-api.us-east-1.amazonaws.com/graphql",
                    "region": "us-east-1",
                    "authorizationType": "AMAZON_COGNITO_USER_POOLS",
                    "apiKey": "da2-6be6mwqef5ezzb5ikanyqb7ksi"
                }
            }
        }
    },
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "AppSync": {
                    "Default": {
                        "ApiUrl": "https://jqmtztnh3nct7bt4thgwrafrmy.appsync-api.us-east-1.amazonaws.com/graphql",
                        "Region": "us-east-1",
                        "AuthMode": "AMAZON_COGNITO_USER_POOLS",
                        "ClientDatabasePrefix": "ashlife_AMAZON_COGNITO_USER_POOLS"
                    },
                    "ashlife_API_KEY": {
                        "ApiUrl": "https://jqmtztnh3nct7bt4thgwrafrmy.appsync-api.us-east-1.amazonaws.com/graphql",
                        "Region": "us-east-1",
                        "AuthMode": "API_KEY",
                        "ApiKey": "da2-6be6mwqef5ezzb5ikanyqb7ksi",
                        "ClientDatabasePrefix": "ashlife_API_KEY"
                    }
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "us-east-1:fb569397-6570-403e-beaf-ebec15f8951d",
                            "Region": "us-east-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "us-east-1_GWBKNV889",
                        "AppClientId": "1k2ejk3hri2e2c11cikglc1br",
                        "Region": "us-east-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "mfaConfiguration": "OFF",
                        "mfaTypes": [
                            "SMS"
                        ],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": []
                        },
                        "signupAttributes": [
                            "EMAIL",
                            "NAME"
                        ],
                        "socialProviders": [],
                        "usernameAttributes": [
                            "PHONE_NUMBER"
                        ],
                        "verificationMechanisms": [
                            "PHONE_NUMBER"
                        ]
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "ashlife66e9be3fe921440baf6f8fc9e9d181f9111426-dev",
                        "Region": "us-east-1"
                    }
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "ashlife66e9be3fe921440baf6f8fc9e9d181f9111426-dev",
                "region": "us-east-1",
                "defaultAccessLevel": "guest"
            }
        }
    }
}''';