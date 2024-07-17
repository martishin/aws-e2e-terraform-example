# 1. Create an Elastic Load Balancer (ELB)
resource "aws_lb" "web_server_lb" {
  name               = "web-server-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_web.id]
  subnets            = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]

  enable_deletion_protection = false
}

# 2. Create a Target Group
resource "aws_lb_target_group" "web_server_tg" {
  name     = "web-server-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.prod_vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

# 3. Create a Listener
resource "aws_lb_listener" "web_server_listener" {
  load_balancer_arn = aws_lb.web_server_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_server_tg.arn
  }
}

# 4. Register the instances with the Target Group
resource "aws_lb_target_group_attachment" "web_server_instance_1" {
  target_group_arn = aws_lb_target_group.web_server_tg.arn
  target_id        = aws_instance.web_server_instance_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "web_server_instance_2" {
  target_group_arn = aws_lb_target_group.web_server_tg.arn
  target_id        = aws_instance.web_server_instance_2.id
  port             = 80
}
