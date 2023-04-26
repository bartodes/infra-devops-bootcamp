locals {
    env = path_relative_to_include()
}


remote_state {
    backend = "s3"
    config = {
        # Asing a bucket that's previously created. Example: dev-tf-devops. 
        # Use ${local.env} for the assignment of different buckets to multiple states/backends.
        bucket = "${local.env}-tf-devops" 
        region = "us-east-1"
        key    = "${local.env}-state/terraform.tfstate"
    }
    generate = {
        path      = "backend.tf"
        if_exists = "overwrite_terragrunt"
    }
}