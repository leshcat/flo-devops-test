# DevOps Flo Health test

Contents:
* [Preamble](#preamble)
* [Provisioning Infrastructure](#provisioning-infrastructure)
  * [Bugs-Todo](#bugs-todo)
* [Provisioning App](#provisioning-app)
* [ADR]($adr)


## Preamble

Create infrastructure and deploy stateful app in compliance with:
https://github.com/dmitry-yackevich/flo-devops-test

## Provisioning Infrastructure
1. This guide assumes you have shell variables exported:

  * AWS_ACCESS_KEY_ID
  * AWS_SECRET_ACCESS_KEY
  * AWS_DEFAULT_REGION
  * [AWS_SESSION_TOKEN]


2. AWS EC2 keypair imported in respective region

3. Execute as follows:

  * `$ cd ${git_root}/terraform`
  * `$ terraform init`
  * Change desired variables to your taste @  *terraform.tfvars*, [example](terraform/terraform.tfvars)
  * `$ terraform plan [-var 'region=${your_region}']`
  * `$ terraform apply [-var 'region=${your_region}']`

### Bugs-Todo

* EFS mount point fails to mount automatically, no readiness check implemented yet
* No Route53 alias record created
* All-in-one SG
* No ASG lifecycle hooks implemented
* No ami override (auto selection, latest amz2_linux)
* No SSL generated/used (access on test account limited)
* No encryption used

## Provisioning App

##### ToDo

## ADR

[architecture_design.md](adr/architecture_design.md)
