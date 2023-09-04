###INFRAESTRUTURA DE TRES CAMADAS#######
###INFRAESTRUTURA PARA HOMOLOGAÇÃO######
###RECURSOS#############################
###ELASTIC LOAD BALANCER################
###ELASTIC COMPUTE SERVICE##############
###RELATIONAL DATABASE SERVICE##########

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.0.0"
}



##criando instancia ec2
resource "aws_instance" "app_server" {
  name = "${var.name}-homolog"
  ami           = ""
  instance_type = "t3.large"
  key_name = var.key-name
  security_groups = var.security-group
  vpc_id = var.vpc-id
  subnet_id = var.subnet-id
  root_block_device {
    volume_size = 30 #tamanho do volume em GB
  }

  tags = {
    Name = [var.name]
  }
}

###Definindo Load Balancer
resource "aws_lb" "alb_homolog" {
  name               = "elb-${var.name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.elb-sg]
  subnets            = [for subnet in var.elb-sg : subnet.id]

  enable_deletion_protection = false

  tags = {
    Environment = "homolog"
  }
}

##defininfo target group

resource "aws_alb_target_group" "tg_alb_homolog"{
    name = var.name
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc-id
    health_check {
      path = "/"
      port = 80
    }
}

##adicionando instancia ao target group

resource "aws_lb_target_group_attachment" "attach_tg_alb_homolog" {
  target_group_arn = aws_alb_target_group.tg_alb_homolog.arn
  target_id        = aws_instance.app_server.id
  port             = 80
}

#criando listeners
resource "aws_alb_listener" "listner_alb_homolog" {
  load_balancer_arn = aws_alb.alb_homolog.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.tg_alb_homolog.arn
    type             = "forward"
  }
  depends_on  = [aws_alb.alb_homolog]
}

#attach ACM certificate:

resource "aws_lb_listener_certificate" "acm_homolog" {
  listener_arn    = aws_lb_listener.listener_alb_homolog.arn
  certificate_arn = data.aws_acm_certificate.issued.arn
}

### AWS RDS

resource "aws_db_instance" "rds_homolog" {
  allocated_storage           = 10
  db_name                     = "${var.db-name}"
  engine                      = var.db-engie
  engine_version              = var.db-engie-verison
  instance_class              = var.db-instance-class
  manage_master_user_password = true
  username                    = var.db-username
  parameter_group_name        = "default.mysql5.7"
}
