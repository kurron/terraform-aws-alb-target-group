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

module "target-group" {
    source = "../"

    region                         = "us-west-2"
    name                           = "Ultron"
    project                        = "Debug"
    purpose                        = "Balance to Ultron containers"
    creator                        = "kurron@jvmguy.com"
    environment                    = "development"
    freetext                       = "No notes at this time."
    port                           = "8080"
    protocol                       = "HTTP"
    vpc_id                         = "${data.terraform_remote_state.vpc.vpc_id}"
    enable_stickiness              = "No"
    health_check_interval          = "30"
    health_check_path              = "/operations/health"
    health_check_protocol          = "HTTP"
    health_check_timeout           = "5"
    health_check_healthy_threshold = "5"
    unhealthy_threshold            = "2"
    matcher                        = "200-299"
}

output "alb_id" {
    value = "${module.alb.alb_id}"
}
