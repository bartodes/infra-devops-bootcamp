output "vpc_id" {
    value = module.vpc.vpc_id
}

output "private_subnets_id" {
    value = module.vpc.private_subnets
}

# output "ec2_security_group_id" {
#     value = module #aca va el id del security group que se cree para la ec2
# }