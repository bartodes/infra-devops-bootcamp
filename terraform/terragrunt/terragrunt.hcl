locals {
    # Parse the file path we're in to read the env name: e.g., env 
    # will be "dev" in the dev folder, "stage" in the stage folder, 
    # etc.
    env = path_relative_to_include()
}

remote_state {
    backend = "s3"
    config = {
        bucket = "bucket-${local.env}"
        region = "us-east-1"
        key    = "${local.env}/terraform.tfstate"
    }
    generate = {
        path      = "backend.tf"
        if_exists = "overwrite_terragrunt"
    }
}