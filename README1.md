# 2023-09-04 09:13:00
## aws skills builder exam prep
### exam domains
#### Domain1: Secure Architecutres
#### Domain2: Design Resilient Architectures
#### Domain3: Design high-performing Architectures
#### Domain4: Design cost-optimizied Architecutres

### practice test
1. An application runs on two Amazon EC2 instances behind a Network Load Balancer. The EC2 instances are in a single Availability Zone.
  - What should a solutions architect do to make this architecture more highly available?
  - **answer:** place the EC2 instances in an Auto-Scaling group that extends across multiple Availability Zones.

- **Incorrect:** VPC peering will provide connectivity to the other Availability Zone. However, VPC peering does not ensure high availability because the EC2 instances are still in one Availability Zone.

- **Incorrect:** The replacement of the Network Load Balancer with an Application Load Balancer provides no additional availability. Both load balancers are inherently highly available. However, the EC2 instances would be highly available only if they extended across two Availability Zones.

- **Incorrect:** Failover routing requires a primary destination and a secondary (failover) destination. No failover destination is specified in this solution. In addition, this approach does not ensure high availability because the EC2 instances are still in one Availability Zone.

- links:
  + VPC peering: https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html
  + elastic load balancing: https://docs.aws.amazon.com/elasticloadbalancing/latest/userguide/how-elastic-load-balancing-works.html
  + DNS failover: https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-configuring.html

2. A company has an on-premises application that exports log files about users of a website. These log files range from 20 GB to 30 GB in size. A solutions architect has created an Amazon S3 bucket to store these files. The files will be uploaded directly from the application. The network connection experiences intermittent failures, and the upload sometimes fails.

- A solutions architect must design a solution that resolves this problem. The solution must minimize operational overhead.
- **answer:** use multi-part upload to Amazon S3
- With a single PUT operation, you can upload a single object that is up to 5 GB in size. 
- You can use a multipart upload to upload larger files, such as the files in this scenario.
- **Incorrect:** S3 Transfer Acceleration facilitates quicker uploads by using edge locations to copy data into Amazon S3. S3 Transfer Acceleration does not solve the problem of the file size limitation (5 GB) for a single PUT operation.
- **Incorrect:** This solution does not solve the problem of the file size limitation (5 GB) for a single PUT operation. S3 Lifecycle policies cannot transfer files from EC2 block storage to Amazon S3. This solution also adds unnecessary services and operational overhead to the environment.
- **Incorrect:** This solution does not solve the problem of the file size limitation (5 GB) for a single PUT operation. Each destination Region would have the same problem as a single Region. This solution also adds operational overhead.

- links:
  + S3 transfer acceleration: https://aws.amazon.com/s3/transfer-acceleration/
  + EC2: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html
  + multi-link upload: https://docs.aws.amazon.com/AmazonS3/latest/userguide/mpuoverview.html
  + S3 bucket replication: https://docs.aws.amazon.com/AmazonS3/latest/userguide/replication-walkthrough1.html

3. A company needs to look up configuration details about how a Linux-based Amazon EC2 instance was launched.
- Which command should a solutions architect run on the EC2 instance to gather the system metadata?
- **answer:** curl http://169.254.169.254/latest/meta-data
- links:
  + instance metadata: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-data-retrieval.html

4. A media company is designing a new solution for graphic rendering. The application requires up to 400 GB of storage for temporary data that is discarded after the frames are rendered. The application requires approximately 40,000 random IOPS to perform the rendering.
- What is the MOST cost-effective storage option for this rendering application?
- **answer:**  a storage optimized Amazon EC2 instance with instance store storage
- SSD-Backed Storage Optimized (i2) instances provide more than 365,000 random IOPS. The instance store has no additional cost, compared with the regular hourly cost of the instance.
- **Incorrect:** Provisioned IOPS SSD (io1 or io2) EBS volumes can deliver more than the 40,000 IOPS that are required in the scenario. However, this solution is not as cost-effective as an instance store because Amazon EBS adds cost to the hourly instance rate. This solution provides persistence of data beyond the lifecycle of the instance, but persistence is not required in this use case.

**Incorrect:** Throughput Optimized HDD (st1) EBS volumes are engineered to maximize the throughput of data that can be sent to and from a volume, not the random IOPS. Consequently, this solution does not meet the IOPS requirement. In addition, Amazon EBS adds cost to the hourly instance rate. This solution provides persistence of data beyond the lifecycle of the instance, but persistence is not required in this use case.

**Incorrect:** The rapidly changing data that is required for the scratch volume space makes Amazon S3 (object storage) the wrong storage. Block storage is appropriate for the read/write functionality to work smoothly.


- links:
  + instance store pricing: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes
  + EC2 pricing: https://aws.amazon.com/ec2/pricing/
  + Provisioned IOPS SSD: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html#EBSVolumeTypes_piops
  + EBS pricing: https://aws.amazon.com/ebs/pricing/
  + thru-put optimized HDD volumes: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html#EBSVolumeTypes_st1
  + performance design patterns for S3: https://docs.aws.amazon.com/AmazonS3/latest/userguide/optimizing-performance-design-patterns.html

5. A company is transitioning its Amazon EC2 based MariaDB database to Amazon RDS. The company has already identified a database instance type that will meet the company's CPU and memory requirements. The database must provide at least 40 GiB of storage capacity and 1,000 IOPS.
- Which storage configuration for the Amazon RDS for MariaDB instance is MOST cost-effective?
- **answer:** provision 334 GiB of Gen Purpose SSD storage for the RDS instance
- Baseline I/O performance for General Purpose SSD storage is 3 IOPS for each GiB. For 334 GiB of storage, the baseline performance would be 1,002 IOPS. Additionally, General Purpose SSD storage is more cost-effective than Provisioned IOPS storage.
- **Incorrect:** Magnetic storage does not support IOPS as a configurable parameter.
- **Incorrect:** Baseline I/O performance for General Purpose SSD storage is 3 IOPS for each GiB, with a minimum of 100 IOPS. For 50 GiB of storage, the baseline performance would be 150 IOPS.
- **Incorrect:** 50 GiB of Provisioned IOPS storage with 1,000 IOPS would be more expensive than 334 GiB of General Purpose SSD storage.
- links:
  + RDS storage types: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html#Concepts.Storage
  + gen purpose ssd storage: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html#Concepts.Storage.GeneralSSD
  + RDS pricing for MariaDB: https://aws.amazon.com/rds/mariadb/pricing/

6. A company is deploying a new database on a new Amazon EC2 instance. The workload of this database requires a single Amazon Elastic Block Store (Amazon EBS) volume that can support up to 20,000 IOPS.
- Which type of EBS volume meets this requirement?
- **answer:** a Provisioned IOPS SSD EBS volume will provide up to 64k IOPS for each volume
- **Incorrect:** A Throughput Optimized HDD EBS volume is an HDD-backed storage device that is limited to 500 IOPS for each volume.
- **Incorrect:** A General Purpose SSD EBS volume is limited to 16,000 IOPS for each volume.
- **Incorrect:** A Cold HDD volume provides low-cost magnetic storage that defines performance in terms of throughput rather than IOPS. Cold HDD volumes are a good fit for large, sequential cold-data workloads.
- links:
  + hard disk drives: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html#hard-disk-drives
  + solid state drives: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html#solid-state-drives
  + EBS Cold HDD volumes: https://aws.amazon.com/ebs/cold-hdd/

7. A company is investigating services to manage vulnerability scans in Amazon EC2 instances and container images that the company stores in Amazon Elastic Container Registry (Amazon ECR). The service should identify potential software vulnerabilities and categorize the severity of the vulnerabilities.
- Which AWS service will meet these requirements?
- **answer:** Amazon Inspector
- Amazon Inspector removes the operational overhead that is necessary to configure a vulnerability management solution. Amazon Inspector works with both EC2 instances and container images in Amazon ECR to identify potential software vulnerabilities and to categorize the severity of the vulnerabilities.
- **Incorrect:** Amazon GuardDuty is a threat detection service that continuously monitors for malicious activity and anomalous behavior. It does not scan for vulnerabilities.
- **Incorrect:** You can use Patch Manager to apply patches for operating systems and applications. This does not satisfy the requirement to scan EC2 instances and containers for vulnerabilities.
- **Incorrect:** AWS Config is a service that gives you the ability to assess, audit, and evaluate the configurations of your AWS resources. It does not scan for vulnerabilities or network exposures.
- links:
  + Amazon GuardDuty Features: https://aws.amazon.com/guardduty/features/
  + Patch Manager: https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-patch.html
  + Amazon Inspector Features: https://aws.amazon.com/inspector/features
  + AWS Config: https://aws.amazon.com/config/

8. A company runs its website on Amazon EC2 instances behind an Application Load Balancer that is configured as the origin for an Amazon CloudFront distribution. The company wants to protect against cross-site scripting and SQL injection attacks.
- Which approach should a solutions architect recommend to meet these requirements?
- AWS WAF can detect the presence of SQL code that is likely to be malicious (known as SQL injection). AWS WAF also can detect the presence of a script that is likely to be malicious (known as cross-site scripting).
- **Incorrect:** Shield Advanced protects against DDoS attacks. Shield Advanced does not protect against cross-site scripting or SQL injection.
- **Incorrect:** With Firewall Manager, you can manage AWS WAF, Shield Advanced, and other AWS services. Shield Advanced protects against DDoS attacks. Shield Advanced does not protect against cross-site scripting or SQL injection.
- links:
  + AWS Shield: https://docs.aws.amazon.com/waf/latest/developerguide/shield-chapter.html
  + AWS WAF, Shield, Firewall Manager: https://docs.aws.amazon.com/waf/latest/developerguide/what-is-aws-waf.html
  + Firewall manager: https://docs.aws.amazon.com/waf/latest/developerguide/fms-chapter.html
  + WAF: https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html

9. A company that processes satellite images has an application that runs on AWS. The company stores the images in an Amazon S3 bucket. For compliance reasons, the company must replicate all data once a month to an on-premises location. The average amount of data that the company needs to transfer is 60 TB.
- What is the MOST cost-effective way to transfer this data?
- **answer:** Export the data monthly from the existing S3 bucket into an AWS Snowball Edge Storage Optimized device. Ship the device to the on-prem location. Transfer the data. Return the device a week later.
- The base price covers the device and 10 days of usage at the on-premises location. If the company returns the device within a week, the company pays the base price and the price for data transfer out of AWS.
- **Incorrect:** There is no cost advantage if the company copies all the data to another S3 bucket that uses S3 Standard-IA storage. The company could transfer the data directly from the original S3 bucket. This solution is not the most cost-effective option because the additional replication increases the cost.
- **Incorrect:** There is no cost advantage if the company copies all the data to another S3 bucket that uses S3 Standard-IA storage. The company could transfer the data directly from the original S3 bucket. This solution is not the most cost-effective option because the additional replication increases the cost.
- **Incorrect:** Data transfer to CloudFront is free of cost, but data transfer of 60 TB from CloudFront to an on-premises location incurs a cost. This option would cost approximately twice as much as the option to use the AWS Snowball Edge Storage Optimized device.
- links:
  + Snowball pricing: https://aws.amazon.com/snowball/pricing/
  + Storage Gateway pricing: https://aws.amazon.com/storagegateway/pricing/?nc=sn&loc=3
  + S3 pricing: https://aws.amazon.com/s3/pricing
  + CloudFront pricing: https://aws.amazon.com/cloudfront/pricing/

  10. A reporting application runs on Amazon EC2 instances behind an Application Load Balancer. The instances run in an Amazon EC2 Auto Scaling group across multiple Availability Zones. For complex reports, the application can take up to 15 minutes to respond to a request. A solutions architect is concerned that users will receive HTTP 5xx errors if a report request is in process during a scale-in event.
- What should the solutions architect do to ensure that user requests will be completed before instances are terminated?
- **answer:** increase the `deregistration delay` timeout for the target group of the instances to greater than 900 seconds
- By default, Elastic Load Balancing waits 300 seconds before the completion of the deregistration process, which can help in-flight requests to the target become complete. To change the amount of time that Elastic Load Balancing waits, update the deregistration delay value.
- **Incorrect:** If an EC2 instance were removed from the target group during a scale-in process, the EC2 instance would fail (or would be unhealthy if it were checked). An Application Load Balancer would stop routing requests to that target and would choose a new healthy target.
- **Incorrect:** An increase of the instance size likely would increase the speed of processing. However, this solution does not directly ensure that instances that process a request are unaffected by scale-in actions.
- **Incorrect:** Amazon EC2 Auto Scaling cooldown periods help you prevent Auto Scaling groups from launching or terminating additional instances before the effects of previous activities are apparent.
- links:
  + ALB sticky sessions: https://docs.aws.amazon.com/elasticloadbalancing/latest/application/sticky-sessions.html
  + deregistration delay: https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-target-groups.html#deregistration-delay
  + cooldowns in Amazon EC2 auto-scaling: https://docs.aws.amazon.com/autoscaling/ec2/userguide/Cooldown.html

11. A company is developing a chat application that will be deployed on AWS. The application stores the messages by using a key-value data model. Groups of users typically read the messages multiple times. A solutions architect must select a database solution that will scale for a high rate of reads and will deliver messages with microsecond latency.
- Which database solution will meet these requirements?
- **answer:** Amazon DynamoDB with DynamoDB Accelerator (DAX)
- DynamoDB is a NoSQL database that supports key-value records. DAX delivers response times in microseconds.
- **Incorrect:** Aurora is a relational database (not a key-value database). Aurora is not likely to achieve microsecond latency consistently.
- **Incorrect:** Aurora is a relational database (not a key-value database). Aurora is not likely to achieve microsecond latency consistently, even with ElastiCache.
- **Incorrect:** Neptune is a graph database that is optimized for working with highly connected data. Neptune is not optimized for simple key-value data.
- links:
  + Amazon Aurora: https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html
  + Amazon DynamoDB: https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Introduction.html
  + DAX: https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DAX.html
  + Elasticache for Memcached: https://docs.aws.amazon.com/AmazonElastiCache/latest/mem-ug/WhatIs.html
  + Amazon Neptune: https://docs.aws.amazon.com/neptune/latest/userguide/intro.html

12. A company uses one AWS account to run production workloads. The company has a separate AWS account for its security team. During periodic audits, the security team needs to view specific account settings and resource configurations in the AWS account that runs production workloads. A solutions architect must provide the required access to the security team by designing a solution that follows AWS security best practices.
- Which solution will meet these requirements?
- **answer:** create an IAM role in the production account. attach a permissions policy that provides the permissions required by the security team. add the security team account to the trust policy
- This solution follows security best practices by using a role to delegate permissions that consist of least privilege access.
- links:
  + using roles to delegate permissions: https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#delegate-using-roles
  + grant least privilege: https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#grant-least-privilege

13. A company needs to maintain data records for a minimum of 5 years. The data is rarely accessed after it is stored. The data must be accessible within 2 hours.
- Which solution will meet these requirements MOST cost-effectively?
- **answer:** store the data in an Amazon S3 bucket. Use the S3 Lifecycle policy to move the data to S3 Glacier Instant Retrieval
- The storage of the data in an S3 bucket provides a cost-effective initial location for the data. S3 Glacier Instant Retrieval is the most cost-effective archival storage solution that meets the requirement of a 2-hour retrieval time.
- links:
  + Amazon EFS with Direct Connect and AWS Managed VPN: https://docs.aws.amazon.com/efs/latest/ug/how-it-works.html#how-it-works-direct-connect
  + Amazon EBS snapshots: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSSnapshots.html
  + S3 storage classes: https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-class-intro.html
  + managing your storage lifecycle: https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lifecycle-mgmt.html


14. A company asks a solutions architect to implement a pilot light disaster recovery (DR) strategy for an existing on-premises application. The application is self contained and does not need to access any databases.
- Which solution will implement a pilot light DR strategy?
- **answer:** recreate the application hosting environment on AWS by using Amazon EC2 instances and stop the EC2 instances.  When the on-prem application fails, start the stopped EC2 instances and direct 100% of the application traffic to the EC2 instances in the AWS cloud.
- This is a pilot light DR strategy. This solution recreates an existing application hosting environment in an AWS Region. This solution turns off most (or all) resources and uses the resources only during tests or when DR failover is necessary. RPO and RTO are usually 10s of minutes.
- A pilot light strategy simplifies recovery at the time of a disaster because the core infrastructure requirements are all in place. A pilot light strategy also minimizes the ongoing cost of DR by minimizing the active resources.
- **Incorrect:** This is a backup and restore DR strategy. Backup and restore DR strategies typically have the lowest cost but highest recovery time. A solution that manually rebuilds the hosting infrastructure on AWS could take hours.
- **Incorrect:** This is a warm standby DR strategy. This solution recreates an existing application hosting environment in an AWS Region. This solution serves a portion of live traffic. With this DR strategy, RPO and RTO are usually a few minutes. However, costs are higher because this solutions runs resources continuously.
- **Incorrect:** This is a backup and restore DR strategy. Backup and restore DR strategies typically have the lowest cost but highest recovery time. A solution that manually rebuilds the hosting infrastructure on premises and downloads the data that a company has backed up could take hours or days.

15. A company has strict data protection requirements. A solutions architect must configure security for a VPC to ensure that backend Amazon RDS DB instances cannot be accessed from the internet. The solutions architect must ensure that the DB instances are accessible from the application tier over a specified port only.
- Which actions should the solutions architect take to meet these requirements? (Select TWO.)
  + **answer:** specify a DB subnet group that contains only private subnets for the DB instances
  + **answer:** add an inbound rule to the DB Security Group that allows requests from the security group of the application tier over the database port. Remove other inbound rules
- **Incorrect:** An elastic network interface is a logical networking component in a VPC that represents a virtual network card. The use of an elastic network interface would not meet the requirements in the scenario.
- **Incorrect:** Shield provides protection against DDoS attacks. Shield cannot be a target of routes in a route table. The use of Shield would not meet the requirements in the scenario.
- **Incorrect:** Direct Connect provides a dedicated connection to your AWS environment. The use of Direct Connect would not meet the requirements in the scenario.
- links:
  + routing: https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Scenario2.html#VPC_Scenario2_Routing
  + ENI: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-eni.html
  + AWS Shield: https://docs.aws.amazon.com/waf/latest/developerguide/shield-chapter.html
  + Direct Connect: https://aws.amazon.com/directconnect/features/

16. Which components are required to build a site-to-site VPN connection on AWS? (Select TWO.)
  + **answer:** customer gateway
  + **answer:** a virtual private gateway
- A customer gateway is required for the VPN connection to be established. A customer gateway device is set up and configured in the customer's data center.
- A virtual private gateway is attached to a VPC to create a site-to-site VPN connection on AWS. You can accept private encrypted network traffic from an on-premises data center into your VPC without the need to traverse the open public internet.
- **Incorrect:** An internet gateway is attached to a VPC to allow traffic from the internet to flow into or out of the VPC. A VPN connection does not flow through an internet gateway. The internet gateway is designed to allow traffic from the open internet, not an encrypted VPN connection
- **Incorrect:** A NAT gateway provides a way for private Amazon EC2 instances to send requests to the internet. A NAT gateway does not give you the ability to create an encrypted site-to-site VPN connection.
- **Incorrect:** API Gateway is a fully managed service for developers to create, publish, maintain, monitor, and secure APIs at any scale. APIs act as the front door for applications to use to access data, business logic, or functionality from backend services. However, API Gateway is not necessary for the implementation of a VPN connection.
- links:
  + Internet gateways: https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html
  + NAT gateway: https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html
  + AWS site-to-site VPN: https://docs.aws.amazon.com/vpn/latest/s2svpn/VPC_VPN.html
  + 

17. A company is developing a new mobile version of its popular web application in the AWS Cloud. The mobile app must be accessible to internal and external users. The mobile app must handle authorization, authentication, and user management from one central source.
- Which solution meets these requirements?
- **answer:** Amazon cognito user pools
- Amazon Cognito provides authentication, authorization, and user management for your web and mobile apps. Users can sign in directly with a user name and password, or through a trusted third party.
- **Incorrect:** An IAM role is an IAM entity that is assumable by an IAM user. An IAM role has permissions policies that define what the entity can and cannot do. However, an IAM role does not control access to an application.
- **Incorrect:** You can use IAM users and groups to control who is authenticated and authorized to use an AWS service. However, users and groups do not control access to an application.
- **Incorrect:** You can use AWS STS to create and provide trusted users with temporary security credentials that can control access to your AWS resources. However, AWS STS does not control access to an application.
- links:
  + IAM roles: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html
  + IAM user: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users.html
  + IAM groups: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_groups.html
  + Amazon cognito: https://docs.aws.amazon.com/cognito/latest/developerguide/what-is-amazon-cognito.html

18. A company is designing a disaster recovery (DR) architecture for an important application on AWS. The company has determined that the RTO is 5 minutes with a minimal instance capacity to support the application in the AWS DR site. The company needs to minimize costs for the DR architecture.
- Which DR strategy will meet these requirements?
- **answer:** warm standby
- This solution meets the requirement for an RTO of 5 minutes. The instances run at a low capacity and can scale within minutes.
- **Incorrect:** This solution would not meet the requirement for an RTO of 5 minutes. The instances are idle and unable to run and scale to full capacity within 5 minutes.
- **Incorrect:** Because this is an active-active environment, this solution would address the requirement for an RTO within moments. The services are already running at full capacity within that time. However, this solution costs more than is necessary to meet the company's requirements.
- **Incorrect:** This solution would not achieve the RTO of 5 minutes that the company requires.
- links:
  + https://docs.aws.amazon.com/wellarchitected/latest/reliability-pillar/plan-for-disaster-recovery-dr.html

19. A company is deploying a new application that will consist of an application layer and an online transaction processing (OLTP) relational database. The application must be available at all times. However, the application will have periods of inactivity. The company wants to pay the minimum for compute costs during these idle periods.
- Which solution meets these requirements MOST cost-effectively?
- **answer:** run the application in containers with Amazon Elastic Container Service (Amazon ECS) on AWS Fargate. Use Amazon Aurora Serverless for the database.
- When Amazon ECS uses Fargate for compute, it incurs no costs when the application is idle. Aurora Serverless also incurs no compute costs when it is idle.
- EC2 burstable instances offer burstable capability without scaling. However, this solution does not minimize cost during the periods of inactivity and is not the most cost-effective option. In addition, an Amazon Redshift database is not ideal for OLTP. Amazon Redshift is specifically designed for online analytic processing (OLAP).
- Although infrastructure as code (IaC) helps with availability, this solution does not meet the requirement of being always available. In addition, this solution offers no way to keep the database data after the database is recreated.
- **Incorrect:** With this solution, at least one instance and a database will run during the periods of inactivity. This solution does not minimize cost during the periods of inactivity. This solution is not the most cost-effective option.
- links:
  + Amazon RedShift: https://docs.aws.amazon.com/redshift/latest/mgmt/welcome.html
  + Amazon Cloud Formation: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html
  + Fargate pricing: https://aws.amazon.com/fargate/pricing/
  + Aurora serverless: https://aws.amazon.com/rds/aurora/serverless/

20. A company has an application that runs on a large general purpose Amazon EC2 instance type that is part of an EC2 Auto Scaling group. The company wants to reduce future costs associated with this application. After the company reviews metrics and logs in Amazon CloudWatch, the company notices that this application runs randomly a couple of times a day to retrieve and manage data. According to CloudWatch, the maximum runtime for each request is 10 minutes, the memory use is 4 GB, and the instances are always in the running state.
- Which solution will reduce costs the MOST?
- **answer:** refactor the application code to run as an AWS Lambda function
- Lambda is a fully managed service that would automatically scale when necessary and would be highly available. A solution that deploys the application as a Lambda function reduces costs the most.
- **Incorrect:** This solution would keep the EC2 instance in the running state 24 hours a day. This solution would not reduce costs.
- **Incorrect:** This solution would not reduce costs because this solution would still require EC2 instances to be in the running state beyond the run duration of each request.
- **Incorrect:** This solution would not be appropriate because the request times are unpredictable. This solution would create scenarios where the application would not be available because instance launches are not correctly scheduled. This solution would also incur unnecessary costs because the company would be charged on an hourly basis for the EC2 instances instead of on the basis of exact runtimes.
- links:
  + EC2 on-demand pricing: https://aws.amazon.com/ec2/pricing/on-demand/
  + AWS Lambda: https://docs.aws.amazon.com/lambda/latest/dg/welcome.html
  + Amazon EKS: https://docs.aws.amazon.com/whitepapers/latest/overview-deployment-options/amazon-elastic-kubernetes-service.html
  + instance scheduler: https://aws.amazon.com/solutions/implementations/instance-scheduler/