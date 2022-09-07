data "aws_vpc" "aws-vpc" {
  default = true
}

/*data "aws_subnets" "subnet" {
    id = 
    vpc_id = aws_vpc.aws-vpc.id
}*/

data "aws_security_group" "Selected" {
  id = "sg-09c431acf91fe28d3"
}

resource "aws_lb_target_group" "my-target-group" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  name        = "my-test-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc
}

resource "aws_lb" "my-aws-alb" {
  name            = "jmsth-test-alb"
  internal        = false
  security_groups = var.sg
  subnets         = var.subnets

  ip_address_type    = "ipv4"
  load_balancer_type = "application"

}

resource "aws_lb_listener" "jmsth-test-alb-listner" {
  load_balancer_arn = aws_lb.my-aws-alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.my-target-group.arn
    type             = "forward"
  }
}

resource "aws_alb_target_group_attachment" "ec2_attach" {
  target_group_arn = aws_lb_target_group.my-target-group.arn
  target_id        = "i-0c866dbb9bedeeab8"

}
resource "aws_alb_target_group_attachment" "ec2_attach1" {
  target_group_arn = aws_lb_target_group.my-target-group.arn
  target_id        = "i-089177068f4479a0f"

}

