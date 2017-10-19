output "target_group_id" {
    value = "${aws_lb_target_group.group.id}"
    description = "The id of the Target Group"
}

output "target_group_arn" {
    value = "${aws_lb_target_group.group.arn}"
    description = "The ARN of the Target Group"
}

output "target_group_arn_suffix" {
    value = "${aws_lb_target_group.group.arn_suffix}"
    description = "The ARN suffix for use with CloudWatch Metrics."
}

output "listener_id" {
    value = "${aws_lb_listener.listener.id}"
    description = "The ARN of the listener."
}

output "listener_arn" {
    value = "${aws_lb_listener.listener.arn}"
    description = "The ARN of the listener."
}
