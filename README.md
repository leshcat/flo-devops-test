# DevOps Flo Health test

Contents:
* [Preamble](#preamble)
* [Provisioning Infrastructure](#provisioning-infrastructure)
  * [Usage](#provisioning-infrastructure-usage)   
* [Provisioning App](#provisioning-app)
  * [Usage](#provisioning-app-usage)
* [ADR]($adr)


## Preamble

Create infrastructure and deploy stateful app in compliance with:
https://github.com/dmitry-yackevich/flo-devops-test

## Provisioning Infrastructure

Terraform is used to provide whole infrastructure required for the app.

### Usage

1. This guide assumes you have shell variables exported:

  * AWS_ACCESS_KEY_ID
  * AWS_SECRET_ACCESS_KEY
  * AWS_DEFAULT_REGION
  * TF_VAR_region (i.e.: export TF_VAR_region=us-east-1)
  * [AWS_SESSION_TOKEN]


2. AWS EC2 keypair imported in respective region

3. Execute as follows:

  * `$ cd ${git_root}/terraform`
  * `$ terraform init`
  * `$ export TF_VAR_region=${aws_region}` provide current region
  * Change desired variables to your taste @ *terraform.tfvars*, [example](terraform/terraform.tfvars)
  * Ensure your EC2 KeyPair is actually present at current region
  * `$ terraform plan`
  * `$ terraform apply`

## Provisioning App

Ansible is serving as app deployer with mutable option for rolling update.


Main plays are:

 * "terraform_outputs" - this playbook is copying outputs and tfvars and formats them to serve as Ansible variables.

 * "prepare_images" - this playbook will tag and push app images to private ECR repositories.

 * "manage_targets" - deploys the app via docker-compose. By default play deploys using rolling update, thus ensuring Zero Downtime Deployment practice, however, you can skip this behavior via tags (see below). This play relies on Ansible's Dynamic inventory, utilizing tags to search for the required instances. Therefore, you should pass a `--limit tag_Name_${name}_${deployment}` flag. You can find this data via TF's `tag_di_name` output.

### Usage

1. This guide assumes you have shell variables exported:

  * AWS_ACCESS_KEY_ID
  * AWS_SECRET_ACCESS_KEY
  * AWS_DEFAULT_REGION
  * [AWS_SESSION_TOKEN]


2. Execute as follows:

Copy and convert TF outputs and vars for Ansible use:
* `$ ansible-playbook terraform_outputs.yml [-e state=${desired_state_file}]`

Push pre-cooked images to ECR:
* `$ ansible-playbook prep_images.yml`

Now you can deploy the app (if 'deploy_version' variable is not provided, 'v1' app will be deployed):
* `$ ansible-playbook manage_targets.yml --limit tag_Name_wordpress_dev [--skip-tags "roll_update"] [--extra-vars "deploy_version=[v1|v2/latest]"]`


## ADR

[architecture_design.md](adr/architecture_design.md)
