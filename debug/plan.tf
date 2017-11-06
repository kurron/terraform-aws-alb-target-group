terraform {
    required_version = ">= 0.10.7"
    backend "s3" {}
}

provider "aws" {
    region = "${var.region}"
}

variable "region" {
    type = "string"
    default = "us-west-2"
}

variable "domain_name" {
    type = "string"
    default = "transparent.engineering"
}

data "aws_acm_certificate" "certificate" {
    domain   = "*.${var.domain_name}"
    statuses = ["ISSUED"]
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

    region                         = "${var.region}"
    name                           = "Ultron"
    project                        = "Debug"
    purpose                        = "Balance to Ultron containers"
    creator                        = "kurron@jvmguy.com"
    environment                    = "development"
    freetext                       = "Using TLS communications"
    port                           = "8443"
    protocol                       = "HTTPS"
    vpc_id                         = "${data.terraform_remote_state.vpc.vpc_id}"
    enable_stickiness              = "Yes"
    health_check_interval          = "15"
    health_check_path              = "/operations/health"
    health_check_protocol          = "HTTPS"
    health_check_timeout           = "5"
    health_check_healthy_threshold = "5"
    unhealthy_threshold            = "2"
    matcher                        = "200-299"
    load_balancer_arn              = "${data.terraform_remote_state.alb.alb_arn}"
    ssl_policy                     = "ELBSecurityPolicy-TLS-1-2-2017-01"
    certificate_arn                = "${data.aws_acm_certificate.certificate.arn}"
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
