# aws-sol-arch-2023
> guide to studying for the AWS sols arch exam in 2023

## AWS CLI
- https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html
- `aws sts get-caller-identity`
- AWS IAM Identity Center (successor to AWS Single Sign-On) – The IAM Identity Center credentials are stored in the config file
- the credentials are updated when you run the `aws configure sso` command. 
- The config file is located at `~/.aws/config` on Linux or macOS, or at `C:\Users\USERNAME\.aws\config` on Windows.
- The **credentials** and **config** file are updated when you run the command `aws configure`. 
- The credentials file is located at `~/.aws/credentials`` on Linux or macOS, or at `C:\Users\USERNAME\.aws\credentials` on Windows.
- configuration file
  + The files are divided into **profiles**
  + By default, the AWS CLI uses the settings found in the profile named `default``
  + To use alternate settings, you can create and reference additional profiles
- Precedence of options
  + If you specify an option by using one of the environment variables described in this topic, it overrides any value loaded from a profile in the configuration file
  + If you specify an option by using a parameter on the AWS CLI command line, it overrides any value from either the corresponding environment variable or a profile in the configuration file
- setting environment variables:
  + `export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE`
  + `export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY`
  + `export AWS_DEFAULT_REGION=us-west-2`
  + `export AWS_PAGER=""` (use this in shell config file to improve CLI experience)
### multiple account profiles
- you can use profiles to manage multiple AWS accounts using the AWS CLI.
- Each profile will use a set of credentials and settings, which includes things like the AWS Access Key, Secret Access Key, session token, and default region
- Run `aws configure --profile profile-name`, replacing "profile-name" with a name for the new profile 
- Once you've set up the profiles, you can switch between them by using the `--profile` flag with your AWS CLI commands
### other forms of authentication
- **AWS Security Token Service (STS):** This service lets you request temporary, limited-privilege credentials for AWS Identity and Access Management (IAM) users or for users that you authenticate (federated users)
- **IAM Roles:** 
  + Instead of sharing long-term credentials, you can delegate access to your AWS resources to trusted entities (like AWS services or users in another AWS account) by creating roles
  + An IAM role is similar to a user, in that it's an identity with permission policies that determine what the identity can and can't do in AWS
- **Web Identity Federation:**
  + This mechanism lets you create AWS-powered mobile apps where users can sign in using a well-known third party identity provider (like Login with Amazon, Facebook, or Google), then exchange the token they receive from these providers for temporary security credentials in AWS which map to an IAM role with permissions to use the resources in your AWS account
- **Cognito Identity Pools:**
  + Amazon Cognito provides authentication, authorization, and user management for your web and mobile apps
  + Users can sign in directly with a user name and password, or through a third party such as Facebook, Amazon, Google or Apple
- **AWS Single Sign-On (SSO):**
  + This service makes it easy to centrally manage access to multiple AWS accounts and business applications and provide users with single sign-on access to all their assigned accounts and applications from one place.
- **Instance Profiles:**
  +  An instance profile is a way to grant additional permissions to an EC2 instance, beyond what's allowed by the security group. 
  + The instance profile effectively acts as an IAM role for the EC2 instance

Remember to always follow the principle of least privilege (POLP), giving the minimum permissions required to perform a task when setting up these authentication mechanisms.

## Core AWS Services

### Introduction to Cloud Computing and AWS
- pricing calculator: https://calculator.aws/#
- aws service endpoints: https://docs.aws.amazon.com/general/latest/gr/rande.html
- To connect programmatically to an AWS service, you use an endpoint
- An endpoint is the URL of the entry point for an AWS web service
#### regional endpoints
- protocol://service-code.region-code.amazonaws.com
- For example, https://dynamodb.us-west-2.amazonaws.com is the endpoint for the Amazon DynamoDB service in the US West (Oregon) Region
#### global endpoints
- Amazon CloudFront
- AWS Global Accelerator
- AWS Identity and Access Management (IAM)
- AWS Network Manager
- AWS Organizations
- Amazon Route 53
- AWS Shield Advanced
- AWS WAF Classic
#### AWS services by region: 
- https://aws.amazon.com/about-aws/global-infrastructure/regional-product-services/
#### AWS compliance programs:
- https://aws.amazon.com/compliance/programs/
#### developer tools:
- https://aws.amazon.com/developer/tools/
#### support resources:
- http://repost.aws
- http://docs.aws.amazon.com 
- http://aws.amazon.com/architecture/well-architected
#### well-architected
- operational excellence pillar
- security pillar
- reliabiltiy pillar
- performance efficiency pillar
- cost optimization
- sustainabilty pillar
### Compute Services
- instance types: https://aws.amazon.com/ec2/instance-types/
#### ex2.1
- `chmod 400 sa2023.pem`
- `ssh -i "sa2023.pem" ec2-user@ec2-52-24-255-152.us-west-2.compute.amazonaws.com`
- `cat /etc/os-release`
- `aws ec2 describe-instances --region us-west-2 --query 'Reservations[*].Instances[*].[InstanceId, InstanceType]' --output text`
#### ex2.2
- `ssh -i "sa2023.pem" ec2-user@ec2-54-184-88-73.us-west-2.compute.amazonaws.com`
- `aws ec2 describe-instances --region us-west-2 --query 'Reservations[*].Instances[*].[InstanceId, InstanceType]' --output text`
#### Session Manager
- plugin installation: https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html
- `cd ~/downloads`
- `curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/mac_arm64/sessionmanager-bundle.zip" -o "sessionmanager-bundle.zip"`
- `cp ~/Downloads/sessionmanager-bundle.zip ~/aws`
- `cd ~/aws`
- `unzip sessionmanager-bundle.zip`
- `sudo ./sessionmanager-bundle/install -i /usr/local/sessionmanagerplugin -b /usr/local/bin/session-manager-plugin`
  + The installer installs the Session Manager plugin at /usr/local/sessionmanagerplugin and creates the symlink session-manager-plugin in the /usr/local/bin directory. 
  + This eliminates the need to specify the install directory in the user's $PATH variable.
  + `session-manager-plugin`
  + `aws ssm start-session --target i-04a6ca4731154af44`
- session manager warning: ![session manager warning](IMG/aws-session-manager-warning.png)
- get the instance ID of the instance you want to work with: `aws ec2 describe-instances --instance-ids i-04a6ca4731154af44 --region us-west-2 --query 'Reservations[*].Instances[*].IamInstanceProfile.Arn' --output text`
- `aws iam list-attached-role-policies --role-name role-name --query 'AttachedPolicies[*].PolicyName' --output text`
- **session manager checkout commands**
  + `aws iam get-instance-profile --instance-profile-name AmazonSSMRoleForInstancesQuickSetup --query 'InstanceProfile.Roles[*].RoleName' --output text`
  + `aws iam list-attached-role-policies --role-name AmazonSSMRoleForInstancesQuickSetup --query 'AttachedPolicies[*].PolicyName' --output text`
  + if all looks good, connect: `aws ssm start-session --target i-04a6ca4731154af44  --region us-west-2`
- service limits: https://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html
- EC2 meta data:
```
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` \
&& curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/
```

#### ex2.3 pricing model
#### ex2.4 launch image based on existing storage volume
- `aws ec2 create-image --instance-id i-04a6ca4731154af44 --name "sa2023-ci" --description "ex2.4" --region us-west-2`
- `aws ec2 run-instances --image-id ami-0ec29a6c0bc62b92a --count 1 --instance-type t2.micro --key-name sa2023 --security-group-ids sg-04aad9097353bcab8 --subnet-id subnet-4dd12635 --region us-west-2 `
#### ex2.5 create Launch Template and launch instance
#### ex2.6 aws cli ec2 example
- list AMIs in a given region: `aws ec2 describe-images --owners 137112412989 --filters "Name=name,Values=amzn2-ami-hvm-2.0*" --region us-west-2 --query 'Images[*].[ImageId,CreationDate]' --output table | sort -k2 -r`
- get AMI from console: ami-0ea832bf7873542df
```
aws ec2 run-instances --image-id ami-0ea832bf7873542df --count 1 \
--instance-type t2.micro --key-name sa2023 \
--security-group-ids sg-095a9921c6557a262 --subnet-id subnet-4dd12635 \
--user-data file://SHEll/0-user-data.sh \
--tag-specifications \
'ResourceType=instance, Tags[{Key=webserver, Value=sa2023-demo}]' \
'ResourceType=volume, Tags=[{Key=cost-center, Value=ca2023}]'
```



### AWS Storage
### AWS VPC
- VPC NAT gateway: ![session manager warning](IMG/aws-nat-gtwy.png)
### Database Services
### Authentication and Authorization (AWS IAM)
### CloudTrail, CloudWatch, and AWS Config
- `aws cloudtrail update-trail --name management-events-test --no-include-global-service-events`
### The Domain Name System and Network Routing: AWS R53 and Amazon CloudFront
### Data Ingestion, Transformation an d Analytics
cat /etc/os-release
## Architecting for Requirements
### Resilient Architectures
### High-Performance Architectures
### Secure Architectures
### Cost-Optimized Architectures
