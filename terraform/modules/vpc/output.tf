output "vpc_id" {
    value = module.vpc.vpc_id
}

output "public_subnets_id" {
    value = module.vpc.public_subnets
}
