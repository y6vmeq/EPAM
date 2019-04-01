provider "aws" {
  shared_credentials_file = "%USERPROFILE%\.aws\credentials"
  region                    = "eu-west-3"
}
resource "aws_default_vpc" "default" {
  tags {
    Name                    = "Default VPC"
  }
}
resource "aws_default_subnet" "default_az1" {
  availability_zone         = "eu-west-3a"
  tags {
    Name                    = "Default subnet for eu-west-3a"
  }
}
resource "aws_default_subnet" "default_az2" {
  availability_zone         = "eu-west-3b"
  tags {
    Name                    = "Default subnet for eu-west-3b"
  }
}
resource "aws_security_group" "TER_SG" {
  name                      = "terSG"
  ingress {
    from_port               = 80
    to_port                 = 80
    protocol                = "tcp"
    cidr_blocks             = ["0.0.0.0/0"]
  }
  ingress {
    from_port               = 22
    to_port                 = 22
    protocol                = "tcp"
    cidr_blocks             = ["0.0.0.0/0"]
  }
  tags {
      Name                  = "terSG"
  }
}
resource "aws_lb_target_group" "TER_lb_target_group" {
  name                      = "TERlbtargetgroup"
  port                      = 80
  protocol                  = "HTTP"
  target_type               = "instance"
  vpc_id                    = "${aws_default_vpc.default.id}"
}
resource "aws_launch_configuration" "TER_LC" {
  name                      = "terLC"
  image_id                  = "ami-0451ae4fd8dd178f7"
  instance_type             = "t2.micro"
  key_name                  = "test"
  enable_monitoring         = true
  security_groups           = ["${aws_security_group.TER_SG.id}"]
  lifecycle {
    create_before_destroy   = true
  }
}
resource "aws_lb" "TER_ALB" {
  name                      = "terALB"
  internal                  = false
  load_balancer_type        = "application"
  security_groups           = ["${aws_security_group.TER_SG.id}"]
  subnets                   = ["${aws_default_subnet.default_az1.id}","${aws_default_subnet.default_az2.id}"]
}

resource "aws_autoscaling_group" "TER_ASG" {
  name = "terASG"
  min_size = 1
  max_size = 5
  desired_capacity          = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  vpc_zone_identifier       = ["${aws_default_subnet.default_az1.id}","${aws_default_subnet.default_az2.id}"]
  launch_configuration      = "${aws_launch_configuration.TER_LC.id}"
  target_group_arns         = ["${aws_lb_target_group.TER_lb_target_group.id}"]
}