# Assume IAM role script for AWS

As a user of an AWS account, use this zsh script to assume any given IAM role within the account.  
Includes step of MFA authentication.

## Usage 

``` bash
# Replace {role} with the ARN of the target IAM role. 
# Then run:
role_arn={role} source aws_assume_role.sh
```
Script will export `AWS_ACCESS_KEY`, `AWS_SECRET_ACCESS_KEY` and `AWS_SESSION_TOKEN` in the current shell.

## Background

Further info on temporary security credentials can be found [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_use-resources.html).
