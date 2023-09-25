# template based on Anton Putra tutorial
## infrastructure-live-v1
### set region to us-west-2
- `echo $AWS_REGION`
- `export AWS_REGION=us-west-2`
### stage the code
- `cd eks`
- `mkdir -p dev staging`
- `cd dev`
### desgin
```
❯ tree
.
├── README.md
├── demo
├── dev
│   └── vpc
│       ├── 0-provider.tf
│       ├── 1-vpc.tf
│       ├── 2-igw.tf
│       ├── 3-subnets.tf
│       ├── 4-nat.tf
│       ├── 5-routes.tf
│       └── 6-outputs.tf
└── staging
```

### deployment
- `cd dev/vpc`
- `t init`
### VPC diagram
- ![infra-live-v1-vpc](./IMG/infra-live-v1.png)

## infrastructure-live-v2
- modularize the code
- observe that the "region" setting is not in any of the base .tf files
- "provider" and "backend" will be managed in the "infrastructure-live-v2" directory
- if there is no more descriptive name available or if the resource only creates 1 instance fo this type, it is a Terraform convention to call the resource "this"
### design
```
├── infrastructure-live-v2
│   ├── dev
│   │   └── vpc
│   │       ├── main.tf
│   │       └── outputs.tf
│   └── staging
├── infrastructure-live-v3
├── infrastructure-live-v4
└── infrastructure-modules
    └── vpc
        ├── 0-versions.tf
        ├── 1-vpc.tf
        ├── 2-igw.tf
        ├── 3-subnets.tf
        ├── 4-nat.tf
        ├── 5-routes.tf
        ├── 6-outputs.tf
        └── 7-variables.tf
```

### deployment
- `cd infrastructure-live-v2/dev/vpc`
- `t init`
- `t plan`
- `t apply`
- `t destroy`


## infrastructure-live-v3
- use terragrunt for orchestration
- terragrunt uses an inputs block to pass variables to a module
```
inputs = {
  env             = "dev"

}
```

### design
```
├── infrastructure-live-v3
│   ├── dev
│   │   └── vpc
│   │       └── terragrunt.hcl
│   ├── staging
│   │   └── vpc
│   └── terragrunt.hcl
├── infrastructure-live-v4
└── infrastructure-modules
    └── vpc
        ├── 0-versions.tf
        ├── 1-vpc.tf
        ├── 2-igw.tf
        ├── 3-subnets.tf
        ├── 4-nat.tf
        ├── 5-routes.tf
        ├── 6-outputs.tf
        └── 7-variables.tf
```
- top-level orchestration
- `terragrunt run-all destroy` from root folder
```
❯ tree
.
├── backend.tf
├── dev
│   ├── plans
│   │   └── plan01.cfg
│   └── vpc
│       └── terragrunt.hcl
├── provider.tf
├── staging
│   └── vpc
│       └── terragrunt.hcl
└── terragrunt.hcl
```
### deployment
- `cd infrastructure-live-v3/dev/vpc`
- `terragrunt init`
- `t plan`
- `t apply`
- `t destroy`
## infrastructure-live-v4
### eks cluster
- node type: `aws ec2 describe-instance-types --region us-west-2 --query 'InstanceTypes[*].InstanceType' --output table`
- **t2.micro**
- eks requires subnets in at least two availability zones
- before we can setup the EKS control plane, we need to create an IAM role with EKS principal
- attach the AWS EKS cluster policy to the role
  + allows EKS to create EC2 instances and load balancers
- attach the IAM role to the cluster
- cluster scale
  + all node groups must be attached to the EKS cluster
  + the same IAM role can be shared among all node groups
  + to grant additional access for applications in your cluster that want to access the AWS API, we will use an OpenID Connect provider.
  + `to enable true autoscaling, we must enable cluster autoscaler or use Karpenter`
- irsa:  for openID connect we must retrieve the TLS certificate for the cluster 
  + to deploy the cluster autoscaler, we will need to use the *OpenID provider ARN* to establish trust between the AWS IAM and the Kubernetes service account
### terragrunt
- the top-level terragrunt.hcl file *defines shared objects between environments and modules*
- the `dev` directory has an `env.hcl` (terragrunt) file for common variables onlly for this development environment


### design
```
── infrastructure-live-v4
│   ├── dev
│   │   ├── eks
│   │   │   └── terragrunt.hcl
│   │   ├── env.hcl
│   │   └── vpc
│   │       └── terragrunt.hcl
│   ├── staging
│   └── terragrunt.hcl
└── infrastructure-modules
    ├── eks
    │   ├── 0-versions.tf
    │   ├── 1-eks.tf
    │   ├── 2-nodes-iam.tf
    │   ├── 3-nodes.tf
    │   ├── 4-irsa.tf
    │   ├── 5-outputs.tf
    │   └── 6-variables.tf
    └── vpc
        ├── 0-versions.tf
        ├── 1-vpc.tf
        ├── 2-igw.tf
        ├── 3-subnets.tf
        ├── 4-nat.tf
        ├── 5-routes.tf
        ├── 6-outputs.tf
        └── 7-variables.tf
```

### deployment
- `cd infrastructure-live-v4/dev`
- `terragrunt run-all init`
- `terragrunt run-all apply`


## 2023-09-24 21:01:13
- video: 40:55
- have not applied to us-west-2
- commit msg:  "plan-base-eks-us-west-2"