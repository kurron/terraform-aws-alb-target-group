variable "region" {
    type = "string"
    description = "The AWS region to deploy into (e.g. us-east-1)"
}

variable "name" {
    type = "string"
    description = "What to name the resources being created"
}

variable "project" {
    type = "string"
    description = "Name of the project these resources are being created for"
}

variable "purpose" {
    type = "string"
    description = "The role the resources will play"
}

variable "creator" {
    type = "string"
    description = "Person creating these resources"
}

variable "environment" {
    type = "string"
    description = "Context these resources will be used in, e.g. production"
}

variable "freetext" {
    type = "string"
    description = "Information that does not fit in the other tags"
}

variable "port" {
    type = "string"
    description = "The port on which targets receive traffic."
}

variable "protocol" {
    type = "string"
    description = "The protocol to use for routing traffic to the targets."
}

variable "vpc_id" {
    type = "string"
    description = "The identifier of the VPC in which to create the target group."
}

variable "enable_stickiness" {
    type = "string"
    description = "If set to Yes, the balancer will attempt to route clients to a consistent back end."
}

variable "health_check_interval" {
    type = "string"
    description = "The approximate amount of time, in seconds, between health checks of an individual target."
}

variable "health_check_path" {
    type = "string"
    description = "The destination for the health check request."
}

variable "health_check_protocol" {
    type = "string"
    description = "The protocol to use to connect with the target."
}

variable "health_check_timeout" {
    type = "string"
    description = "The amount of time, in seconds, during which no response means a failed health check."
}

variable "health_check_healthy_threshold" {
    type = "string"
    description = "The number of consecutive health checks successes required before considering an unhealthy target healthy."
}

variable "unhealthy_threshold" {
    type = "string"
    description = "The number of consecutive health check failures required before considering the target unhealthy."
}

variable "matcher" {
    type = "string"
    description = "The HTTP codes to use when checking for a successful response from a target."
}

variable "load_balancer_arn" {
    type = "string"
    description = "The ARN of the load balancer to bind the listener to."
}

variable "ssl_policy" {
    type = "string"
    description = "The name of the SSL Policy for the listener, e.g. ELBSecurityPolicy-TLS-1-2-2017-01"
}

variable "certificate_arn" {
    type = "string"
    description = "The ARN of the SSL server certificate"
}
