

#!/usr/bin/env bash
set -euo pipefail

# ---- Config (optional) ----
PROFILE="${AWS_PROFILE:-default}"
REGION="${AWS_REGION:-${AWS_DEFAULT_REGION:-eu-north-1}}"

echo "Using profile: $PROFILE"
echo "Using region : $REGION"
echo

# Small helper to print a section and handle empty outputs
section () { printf "\n==== %s ====\n" "$1"; }

# Who am I?
section "STS: caller identity"
aws --profile "$PROFILE" --region "$REGION" sts get-caller-identity

# EC2
section "EC2: instances (InstanceId,State,Name)"
aws --profile "$PROFILE" --region "$REGION" ec2 describe-instances \
  --query 'Reservations[].Instances[].{Id:InstanceId,State:State.Name,Name:Tags[?Key==`Name`]|[0].Value}' \
  --output table || echo "No instances or access denied."

section "EC2: security groups"
aws --profile "$PROFILE" --region "$REGION" ec2 describe-security-groups \
  --query 'SecurityGroups[].{Id:GroupId,Name:GroupName,Vpc:VpcId}' \
  --output table || echo "No security groups or access denied."

section "EC2: VPCs"
aws --profile "$PROFILE" --region "$REGION" ec2 describe-vpcs \
  --query 'Vpcs[].{VpcId:VpcId,Cidr:CidrBlock,State:State}' \
  --output table || echo "No VPCs or access denied."

# S3 (global to account; region flag okay)
section "S3: buckets"
aws --profile "$PROFILE" --region "$REGION" s3 ls || echo "No buckets or access denied."

# Lambda
section "Lambda: functions"
aws --profile "$PROFILE" --region "$REGION" lambda list-functions \
  --query 'Functions[].{Name:FunctionName,Runtime:Runtime,LastModified:LastModified}' \
  --output table || echo "No functions or access denied."

# IAM (read-only listing)
section "IAM: users"
aws --profile "$PROFILE" iam list-users \
  --query 'Users[].{UserName:UserName,CreateDate:CreateDate,Arn:Arn}' \
  --output table || echo "No users or access denied."

section "IAM: roles"
aws --profile "$PROFILE" iam list-roles \
  --query 'Roles[].{RoleName:RoleName,CreateDate:CreateDate,Arn:Arn}' \
  --output table || echo "No roles or access denied."

echo
echo "Done."
#!/usr/bin/env bash
set -euo pipefail

# ---- Config (optional) ----
PROFILE="${AWS_PROFILE:-default}"
REGION="${AWS_REGION:-${AWS_DEFAULT_REGION:-eu-north-1}}"

echo "Using profile: $PROFILE"
echo "Using region : $REGION"
echo

# Small helper to print a section and handle empty outputs
section () { printf "\n==== %s ====\n" "$1"; }

# Who am I?
section "STS: caller identity"
aws --profile "$PROFILE" --region "$REGION" sts get-caller-identity

# EC2
section "EC2: instances (InstanceId,State,Name)"
aws --profile "$PROFILE" --region "$REGION" ec2 describe-instances \
  --query 'Reservations[].Instances[].{Id:InstanceId,State:State.Name,Name:Tags[?Key==`Name`]|[0].Value}' \
  --output table || echo "No instances or access denied."

section "EC2: security groups"
aws --profile "$PROFILE" --region "$REGION" ec2 describe-security-groups \
  --query 'SecurityGroups[].{Id:GroupId,Name:GroupName,Vpc:VpcId}' \
  --output table || echo "No security groups or access denied."

section "EC2: VPCs"
aws --profile "$PROFILE" --region "$REGION" ec2 describe-vpcs \
  --query 'Vpcs[].{VpcId:VpcId,Cidr:CidrBlock,State:State}' \
  --output table || echo "No VPCs or access denied."

# S3 (global to account; region flag okay)
section "S3: buckets"
aws --profile "$PROFILE" --region "$REGION" s3 ls || echo "No buckets or access denied."

# Lambda
section "Lambda: functions"
aws --profile "$PROFILE" --region "$REGION" lambda list-functions \
  --query 'Functions[].{Name:FunctionName,Runtime:Runtime,LastModified:LastModified}' \
  --output table || echo "No functions or access denied."

# IAM (read-only listing)
section "IAM: users"
aws --profile "$PROFILE" iam list-users \
  --query 'Users[].{UserName:UserName,CreateDate:CreateDate,Arn:Arn}' \
  --output table || echo "No users or access denied."

section "IAM: roles"
aws --profile "$PROFILE" iam list-roles \
  --query 'Roles[].{RoleName:RoleName,CreateDate:CreateDate,Arn:Arn}' \
  --output table || echo "No roles or access denied."

echo
echo "Done."



