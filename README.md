# Setup-a-CloudWatch-Alarm-for-Lambda-Invocation-Errors-Python-handler-with-SNS-Notifications

Prerequisites : Code editor (Vscode, Atom, etc), Setup Terraform on your local machine, Setup Terraform in Visual Studio Code, Having an AWS account and an AWS IAM user with the appropriate permissions to perform the necessary actions, Install AWS CLI based on your operating system.

Clone the code to your code editor with git clone command git clone https://github.com/Assassin010/Setup-a-CloudWatch-Alarm-for-Lambda-Invocation-Errors-Python-handler-with-SNS-Notifications

Deployment Steps: In your terminal Run these commands below (-)

-Terraform init

Initialize a working directory containing Terraform configuration files. This is the first command that should be run after writing a new Terraform configuration or cloning an existing one from version control. It is safe to run this command multiple times.

-Terraform plan

The terraform plan command lets you to preview the actions Terraform would take to modify your infrastructure, or save a speculative plan which you can apply later.

-Terraform apply-auto-approve To deploy the infra



• Note: Modify the terraform.tfvars file:
put YOUR AWS ACCOUND ID only on the first arn


-To destroy the resources use the command: Terraform destroy-auto-approve
Note: To see the entire article please go to my medium page: https://bit.ly/3RPq7s5
