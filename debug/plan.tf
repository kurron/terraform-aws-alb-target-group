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

data "terraform_remote_state" "alb" {
    backend = "s3"
    config {
        bucket = "transparent-test-terraform-state"
        key    = "us-west-2/debug/compute/alb/terraform.tfstate"
        region = "us-east-1"
    }
}

module "target_group" {
    source = "../"

    region                         = "us-west-2"
    name                           = "Ultron"
    project                        = "Debug"
    purpose                        = "Balance to Ultron containers"
    creator                        = "kurron@jvmguy.com"
    environment                    = "development"
    freetext                       = "No notes at this time."
    port                           = "80"
    protocol                       = "HTTP"
    vpc_id                         = "${data.terraform_remote_state.vpc.vpc_id}"
    enable_stickiness              = "Yes"
    health_check_interval          = "30"
    health_check_path              = "/operations/health"
    health_check_protocol          = "HTTP"
    health_check_timeout           = "5"
    health_check_healthy_threshold = "5"
    unhealthy_threshold            = "2"
    matcher                        = "200-299"
    load_balancer_arn              = "${data.terraform_remote_state.alb.alb_arn}"
}

output "target_group_id" {
    value = "${module.target_group.target_group_id}"
}

output "target_group_arn" {
    value = "${module.target_group.target_group_arn}"
}

output "target_group_arn_suffix" {
    value = "${module.target_group.target_group_arn_suffix}"
}

output "listener_id" {
    value = "${module.target_group.listener_id}"
}

output "listener_arn" {
    value = "${module.target_group.listener_arn}"
}
