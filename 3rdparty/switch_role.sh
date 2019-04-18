#!/bin/bash

# Coherent defaults
# AWS account
assume_role_arn="arn:aws:iam::242906888793:role/AWS_Sandbox"
assume_role_session_name="AWS_Sandbox"
# your '~/.aws/' defaults
default_aws_profile="sandbox"
default_aws_region="us-east-1"

# binary deps
declare -a binary_dependencies=("aws" "jq")

for binary in "${binary_dependencies[@]}"; do
 type ${binary} >/dev/null 2>&1 || { echo >&2 "ERROR: ${binary} is not installed! Cannot continue."; exit 1; }
done

function usage {
  echo "INFO: usage: root@localhost\$ source $0 [--ap=*|--aws-profile=*] [--ar=*|--aws-region=*] [--h|--help]"
}

# apply overrides if any
for i in "$@"
do
case $i in
    --ap=*|--aws-profile=*)
    default_aws_profile="${i#*=}"
    echo "INFO: Override in effect, current aws profile: ${default_aws_profile}"
    shift
    ;;
    --ar=*|--aws-region=*)
    default_aws_region="${i#*=}"
    echo "INFO: Override in effect, current aws region: ${default_aws_region}"
    shift
    ;;
    --h|--help)
    usage
    exit 1
    ;;
    *)
    echo "ERROR: unknown override option: \"${i}\". Aborted!"
    # invoke usage function and exit
    usage
    exit 1
    ;;
esac
done

# cleanup
unset AWS_ACCESS_KEY_ID
unset AWS_SESSION_TOKEN
unset AWS_SECRET_ACCESS_KEY
unset AWS_PROFILE
unset AWS_DEFAULT_REGION

unset temporary_sts_credentials

echo "INFO: Getting AWS STS credentials..."

# initial credentials for sts call
export AWS_PROFILE=${default_aws_profile}
export AWS_DEFAULT_REGION=${default_aws_region}

temporary_sts_credentials=$(aws sts assume-role --role-arn "${assume_role_arn}" --role-session-name "${assume_role_session_name}" --output json)

export AWS_ACCESS_KEY_ID=$(echo ${temporary_sts_credentials} | jq -r '.Credentials.AccessKeyId')
export AWS_SESSION_TOKEN=$(echo ${temporary_sts_credentials} | jq -r '.Credentials.SessionToken')
export AWS_SECRET_ACCESS_KEY=$(echo ${temporary_sts_credentials} | jq -r '.Credentials.SecretAccessKey')

echo "INFO: verifying exports:" && export | grep "AWS_"

# cleanup
unset temporary_sts_credentials

# unset PROFILE to avoid credentials conflict
unset AWS_PROFILE

echo "INFO: If everything seems sane, you are good to go."
