terraform {
    required_version = ">= 0.10.7"
    backend "s3" {}
}

data "terraform_remote_state" "vpc" {
    backend = "s3"
    config {
        bucket = "transparent-test-terraform-state"
        key    = "us-west-2/debug/networking/vpc/terraform.tfstate"
        region = "us-east-1"
    }
}

data "terraform_remote_state" "security-groups" {
    backend = "s3"
    config {
        bucket = "transparent-test-terraform-state"
        key    = "us-west-2/debug/networking/security-groups/terraform.tfstate"
        region = "us-east-1"
    }
}

module "alb" {
    source = "../"

    region             = "us-west-2"
    name               = "Ultron"
    project            = "Debug"
    purpose            = "Fronts Docker containers"
    creator            = "kurron@jvmguy.com"
    environment        = "development"
    freetext           = "No notes at this time."
    internal           = "No"
    security_group_ids = ["${data.terraform_remote_state.security-groups.alb_id}"]
    subnet_ids         = "${data.terraform_remote_state.vpc.public_subnet_ids}"
    s3_bucket          = "transparent-test-access-logs"
    log_access         = "No"
}

output "alb_id" {
    value = "${module.alb.alb_id}"
}

output "alb_arn" {
    value = "${module.alb.alb_arn}"
}

output "alb_arn_suffix" {
    value = "${module.alb.alb_arn_suffix}"
}

output "alb_dns_name" {
    value = "${module.alb.alb_dns_name}"
}

output "canonical_hosted_zone_id" {
    value = "${module.alb.canonical_hosted_zone_id}"
}

output "alb_zone_id" {
    value = "${module.alb.alb_zone_id}"
}
