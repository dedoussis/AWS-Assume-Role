#!/usr/bin/env bash

if [ -z $role_arn ]
  then
    echo "Please supply ARN role arguement."
    echo "Usage: role_arn={role} source aws_assume_role.sh"
    return
fi

unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN

echo "Please enter your MFA token code:"
read token_code

caller_id=(`aws sts get-caller-identity --output text`)
user=(`echo $caller_id | cut -d '/' -f 2`)
username=$user[1]
account_id=$caller_id[1]

aws_credentials=(`aws sts assume-role --role-arn $role_arn --role-session-name test --serial-number arn:aws:iam::$account_id:mfa/$username --token-code $token_code --output text`)
access_key_id_index=5
secret_access_key_index=7
session_token_index=8

ITER=1
for word in $aws_credentials 
do
    case $ITER in
    $access_key_id_index)
        export AWS_ACCESS_KEY_ID=$word
        echo "Exported AWS_ACCESS_KEY_ID"
        ;;
    $secret_access_key_index)
        export AWS_SECRET_ACCESS_KEY=$word
        echo "Exported AWS_SECRET_ACCESS_KEY"
        ;;
    $session_token_index)
        export AWS_SESSION_TOKEN=$word
        echo "Exported AWS_SESSION_TOKEN"
        ;;
    esac
    ((ITER++))
done