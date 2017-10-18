terraform {
    required_version = ">= 0.10.7"
    backend "s3" {}
}

provider "aws" {
    region     = "${var.region}"
}

resource "aws_lb" "alb" {
    name_prefix                = "alb-"
    internal                   = "${var.internal == "Yes" ? true : false}"
    load_balancer_type         = "application"
    security_groups            = ["${var.security_group_ids}"]
    subnets                    = ["${var.subnet_ids}"]
    idle_timeout               = 60
    enable_deletion_protection = false
    ip_address_type            = "ipv4"
    tags {
        Name        = "${var.name}"
        Project     = "${var.project}"
        Purpose     = "${var.purpose}"
        Creator     = "${var.creator}"
        Environment = "${var.environment}"
        Freetext    = "${var.freetext}"
    }
     timeouts {
         create = "10m"
         update = "10m"
         delete = "10m"
     }
}
