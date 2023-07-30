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
- `chmod 400 sa2023.pem`
- `ssh -i "sa2023.pem" ec2-user@ec2-52-24-255-152.us-west-2.compute.amazonaws.com`
- `cat /etc/os-release`
- 
### AWS Storage
### AWS VPC
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
