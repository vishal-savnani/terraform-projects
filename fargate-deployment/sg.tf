resource "aws_security_group" "ALB-SG" {
  name        = "${var.app-name}-ALB-SG"
  description = "Security group for Task that is going to be binded with ALB"
  tags = {
    name = "${var.app-name}-ALB-SG"
  }
}

resource "aws_security_group" "Task-SG" {
  name        = "${var.app-name}-Task-SG"
  description = "Security group for Task that is going to be binded with Task Group"
  tags = {
    name = "${var.app-name}-Task-SG"
  }
}
resource "aws_vpc_security_group_ingress_rule" "outbound-allow-task-sg" {
  security_group_id            = aws_security_group.Task-SG.id
  ip_protocol                  = -1
  referenced_security_group_id = aws_security_group.ALB-SG.id
}
resource "aws_vpc_security_group_egress_rule" "inbound-allow-task-sg" {
  security_group_id = aws_security_group.Task-SG.id
  ip_protocol       = -1
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "Allow-https" {
  security_group_id = aws_security_group.ALB-SG.id
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "49.36.65.33/32"
}

resource "aws_vpc_security_group_ingress_rule" "Allow-http" {
  security_group_id = aws_security_group.ALB-SG.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "49.36.65.33/32"
}

resource "aws_vpc_security_group_egress_rule" "outbound-allow" {
  security_group_id = aws_security_group.ALB-SG.id
  ip_protocol       = -1
  cidr_ipv4         = "0.0.0.0/0"

}

