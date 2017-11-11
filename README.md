# Overview
This Terraform module creates a [Target Group](http://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-target-groups.html)/
[Listener](http://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-listeners.html)
pair, which are added to the specified Application Load Balancer.  This useful
if you are partitioning your services by port, e.g. port 1234 maps to Service A
and port 5678 maps to Service B.  The use of ALB Listener Rules is a more
elegant solution.

# Prerequisites
* [Terraform](https://terraform.io/) installed and working
* Development and testing was done on [Ubuntu Linux](http://www.ubuntu.com/)

# Building
Since this is just a collection of Terraform scripts, there is nothing to build.

# Installation
This module is not installed but, instead, is obtained by the project using
the module.  See [kurron/terraform-environments](https://github.com/kurron/terraform-environments)
for example usage.

# Tips and Tricks

## Debugging
The `debug` folder contains files that can be used to test out local changes
to the module.  Edit `backend.cfg` and `plan.tf` to your liking and
then run `debug/debug-module.sh` to test your changes.

# Troubleshooting

# License and Credits
This project is licensed under the [Apache License Version 2.0, January 2004](http://www.apache.org/licenses/).

# List of Changes
