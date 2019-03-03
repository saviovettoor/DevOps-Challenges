```
Setting-up terraform sandbox 
----------------------------
To install Terraform 0.11.5:
	sudo curl -O https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip
	sudo apt-get install unzip
	sudo mkdir /bin/terraform 
	sudo unzip terraform_0.11.11_linux_amd64.zip -d /usr/local/bin/
```
```
prerequisites
-------------
1. AWS account
2. IAM user with admin access
3. S3 buck with name equalexperts.terraform.state to store the state
```
```
How to start
-------------
1. Checkout the code.
2. Command out ci_server module in main.tf
3. Create workspace first 
	]# terraform workspace new development
4. Now lets Initialize a Terraform working directory 
	]# terraform init
5. Now lets  Builds or changes infrastructure
	]# terraform apply -auto-approve
6. Once the vpc and everything is ready un command the module ci_server in the main.tf and run terraform apply -auto-approve
	which will bringup a jenkins server
```