#remote state
remote_state_key    = "PROD/cloud-network.tfstate"
remote_state_bucket = "elva-terraform-test-states"

id_vpc_this_infra = "vpc-00c95528abac11c8b"

public_subnet_1_id = "subnet-0bd3515961399d46f"
public_subnet_2_id = "subnet-00938db3488525e25"

private_subnet_1_id = "subnet-008c68195a278f49a"
private_subnet_2_id = "subnet-09e6721c87eb75692"
private_subnet_3_id = "subnet-01ca5b0d4050f5e87"

sg_public = "sg-0ae5b6e8daf1ae080"
sg_private = "sg-036b4d1f215d622ca"

db_username = "root"
db_password = "sskeyBas1212."