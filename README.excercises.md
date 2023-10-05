> guide to hands-on excercises

## 1.1
# aws-sol-arch-2023

### AWS CLI
- https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html
- `aws sts get-caller-identity`
- `aws sts get-caller-identity --query Account --output text`

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
#### multiple account profiles
- you can use profiles to manage multiple AWS accounts using the AWS CLI.
- Each profile will use a set of credentials and settings, which includes things like the AWS Access Key, Secret Access Key, session token, and default region
- Run `aws configure --profile profile-name`, replacing "profile-name" with a name for the new profile 
- Once you've set up the profiles, you can switch between them by using the `--profile` flag with your AWS CLI commands
#### region
- `echo $AWS_DEFAULT_REGION`
- `echo $AWS_REGION`
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

## 2.1
## 2.2
## 2.3
## 2.4
## 2.5
## 2.6
## 2.7
## 3.1
## 3.2
## 3.3
## 3.4
## 3.5
## 4.1
## 4.2
## 4.3
## 4.4
## 4.5
## 4.6
## 4.7
## 4.8
## 4.9
## 5.1
## 5.2
## 5.3
## 5.4
## 6.1
## 6.2
## 6.3
## 6.4
## 7.1
## 7.2
## 7.3
## 8.1
## 8.2
## 8.3
## 8.4
## 10.1
## 11.1
## 11.2
## 11.3
## 11.4
## 11.5
## 11.6
## 12.1
## 12.2
## 12.3
## 12.4
## 13.1
## 13.2
## 13.3



if I have the following ~/aws/config file:
❯ cat ~/.aws/config
[default]
region = us-east-2
cli_binary_format=raw-in-base64-out
[profile use2]
region = us-east-2
[profile usw2]
region = us-west-2
[profile platform-engineer-0]
region = us-east-2
role_arn = arn:aws:iam::240195868935:role/terraform
source_profile = platform-engineer-0
role_session_name = leson-160

can I use the  `--profile usw2` flag on my `aws cli` commands to force those commands to run in region us-west-2, even though my environment has this?:

❯ echo $AWS_REGION
us-east-2