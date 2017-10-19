terraform {
    required_version = ">= 0.10.7"
    backend "s3" {}
}

provider "aws" {
    region     = "${var.region}"
}

resource "aws_lb_target_group" "group" {
    name_prefix          = "alb-"
    port                 = "${var.port}"
    protocol             = "${var.protocol}"
    vpc_id               = "${var.vpc_id}"
    deregistration_delay = 300
    stickiness {
        type            = "lb_cookie"
        cookie_duration = 86400
        enabled         = "${var.enable_stickiness == "Yes" ? true : false}"
    }
    health_check {
        interval            = "${var.health_check_interval}"
        path                = "${var.health_check_path}"
        port                = "traffic-port"
        protocol            = "${var.health_check_protocol}"
        timeout             = "${var.health_check_timeout}"
        healthy_threshold   = "${var.health_check_healthy_threshold}"
        unhealthy_threshold = "${var.unhealthy_threshold}"
        matcher             = "${var.matcher}"
    }
    tags {
        Name        = "${var.name}"
        Project     = "${var.project}"
        Purpose     = "${var.purpose}"
        Creator     = "${var.creator}"
        Environment = "${var.environment}"
        Freetext    = "${var.freetext}"
    }
}
