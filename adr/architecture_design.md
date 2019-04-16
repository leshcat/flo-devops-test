
# Flo DevOps test ADR

Contents:

* [Summary](#summary)
  * [Issue](#issue)
  * [Decision](#decision)
  * [Status](#status)
* [Details](#details)
  * [Assumptions](#assumptions)
  * [Constraints](#constraints)
  * [Positions](#positions)
  * [Argument](#argument)
  * [Implications](#implications)

## Summary


### Issue

Test task should be completed https://github.com/dmitry-yackevich/flo-devops-test with the help of DevOps practices and tooling.

Minimal requirements:

* Classic stateful application (wordpress) should be deployed in HA fashion on AWS infrastructure

* Cluster endpoint should be accessible via test.wodpress.int

* Wordpress internals should be dockerized (You are allowed to use https://roots.io/bedrock/ fork)

* It should be possible to update in compliance with zero downtime deployment practice

Additional requirements:

* Create AWS EFS attachments for cluster instances

* Utilize AWS ALB

* Use SSL certificate for cluster setup

* Create AWS Docker repository to host dockerized Wordpress images


### Decision

Decided to comply with task's requirements.


### Status

Pending. Open to revisiting if/when new significant info arrives.


## Details


### Assumptions

Required Infrastructure should follow DevOps methodology practices, such as:

  * being repeatable

  * producing identical environment

  * provisioning resources/code deployment automated as much as possible

### Constraints

Since our test task is intended to be completed utilizing AWS Cloud services, we should think of what exactly AWS services will come handy to succeed in our goal while avoiding unnecessary complexity to our environment.

The task is also expecting us to work with following tools:

- terraform
- docker
- ansible

### Positions

Lets go through some of important requirements and review possible positions.

Minimal requirements:

* Classic stateful application (wordpress) should be deployed in HA fashion on AWS infrastructure

 Positions:
   1. 2+n regular EC2 instances + ALB. Repeatable but limited in terms of auto-scaling.
   2. AWS AutoScaling Group + ALB. Selected as simplest/effective solution.
   3. AWS Beanstalk. Easy to setup but complexity grows when making deployment packages.
   4. AWS ECS. Since our app is dockerized, ECS nicely fits, however it will take much more time to figure out its internals than option n2.
   5. AWS EKS. The best solution at the present time for dockerized apps, however it also brings much higher complexity both in terms of provisioning service & creating actual configurations.


* Cluster endpoint should be accessible via test.wodpress.int

  Since domain 'wodpress.int' is already occupied, at the moment following positions are available:

  * Create AWS Route53 private zone, then use one of the possible solutions:

  * Then one of the following:

   1. Semi-hack way:
      - Create 'web.wordpress.int' alias for ALB endpoint
      - Modify /etc/hosts or dnsmasq to emulate wordpress.int ownership


   2. Setup up dns forwarder, similar to:
   https://aws.amazon.com/premiumsupport/knowledge-center/r53-private-ubuntu/

   3. Utilize Route 53 Resolver (not yet investigated)

* Wordpress internals should be dockerized (You are allowed to use https://roots.io/bedrock/ fork)

   While there is no practical need for creating your own Dockerfile for this task, it still would be good for training purposes.
   Docker-compose can hold the configuration required for running Wordpress.
   AWS ECR can effectively store the built images.

* It should be possible to update in compliance with zero downtime deployment practice

   While AWS Beanstalk, ECS and EKS have built-in zero downtime deployment mechanisms, in our case Ansible can handle this process, examples:


   Text: https://medium.com/opendoor-labs/ami-rolling-update-using-ansible-b7c216292b5f


   Video: https://sysadmincasts.com/episodes/47-zero-downtime-deployments-with-ansible-part-4-4

* Use SSL certificate for cluster setup

Create self-signed certificate, upload via services above and attach to ALB.

   Positions:
       1. IAM: https://aws.amazon.com/premiumsupport/knowledge-center/import-ssl-certificate-to-iam/
       2. ACM: AWS Certificate Manager (blocked on current AWS account)

* Create AWS EFS attachments for cluster instances

  EFS attachments will come handy when there will be the need to share 'uploads' folder between the containers, example:

  volumes:
  \- /mnt/efs/wordpress/uploads:/var/www/html/wp-content/uploads


### Argument

Please see Positions.


### Implications

None at the moment.
