# ELVA-AI-TF-TEST
Technical test to Elva AI company using Terraform - by - Andrés Vallejo.

In this project there are three directories that represent the three layers of the infrastructure. I have chosen this kind of development because I think it helps better to organize, create and destroy infrastructure with the help of S3 buckets. These three layers share its own backend state and also have its own per each layer. In the case we wanted to add or destroy an specific part of the infrastructure, we just have to go to the specific layer and worry about of that layer, not in entire infrastructure.

Inside each direcotory there are important file to take into account. They are files with prod.config and tfvars suffix. prod.config files are needed to give terraform the information about the bucket and location inside that bucket where will be saved backend and tfstates. On the other hand, tfvars files are very important because here we save information of variables that we need to initialize to configure some resources. That is the reason I considered to do not add modules, just modifying that variables we could customize our infrastructure. 

It is important to mention that in this project I did not add a .gitignore file that has some private files inside of it like tfvars, prod.config, id_rsa.pub (key of machines), welcome.sh (script to execute ngnix); because I thought that would be better that you could see entire project, of course, on  real projects do not have a .gitignore file would be a bad practice considering that this file helps us to do not upload this sensible information to remote repositories.

Being more specific about the chosen infrastructure, for me, it is importan to mention that I added a NAT gateway because it is more secure to only have a public Load balancer and the other machines of the application inside a private network. For that reason, I created a NAT gateway, to give the possibility of those machines to get connected to the internet and may download some packages.

Here below you might see which were the results when I was creating each layer of the infrastructure.

Inside state-picture directory you may see the created states inside S3 bucket.

Thanks.

Andrés Vallejo.

RESULTS OF THE INFRASTRUCTURE:

1-Cloud-Network

Apply complete! Resources: 20 added, 0 changed, 0 destroyed.

Outputs:

private_subnet_1_id = "subnet-008c68195a278f49a"
private_subnet_2_id = "subnet-09e6721c87eb75692"
private_subnet_3_id = "subnet-01ca5b0d4050f5e87"
public_subnet_1_id = "subnet-0bd3515961399d46f"
public_subnet_2_id = "subnet-00938db3488525e25"
sg_private_id = "sg-036b4d1f215d622ca"
sg_public_id = "sg-0ae5b6e8daf1ae080"
vpc_cidr_block = "10.0.0.0/16"
vpc_id = "vpc-00c95528abac11c8b"


2-Instances-Services
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

name_key = "TEST-ELVA-key"
public_ip_bastion = "18.207.211.245"


3-Autoscaling
Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

Outputs:

lb_arn = "arn:aws:elasticloadbalancing:us-east-1:855149291285:loadbalancer/test-elva-elb"
lb_url = "test-elva-elb-1653560684.us-east-1.elb.amazonaws.com"


