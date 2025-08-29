resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${var.app-name}-cluster"
}

resource "aws_ecs_task_definition" "ecs-cluster-app" {
  family                   = var.app-name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.mem

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      name      = var.app-name
      image     = "${data.aws_ecr_repository.ecr_repo.repository_url}@${data.aws_ecr_image.image.image_digest}"
      essential = true
      portMappings = [
        {
          containerPort = var.container-port
          hostPort      = var.host-port
          protocol      = "tcp"
        }
      ]
  }])
}

resource "aws_ecs_service" "ecs-cluster-service" {
  name            = "${var.app-name}-cluster-service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.ecs-cluster-app.arn
  launch_type     = "FARGATE"
  desired_count   = var.desired_count

  network_configuration {
    subnets          = data.aws_subnets.default_vpc_subnets.ids
    security_groups  = [aws_security_group.Task-SG.id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.ALG-TG.arn
    container_name   = var.app-name
    container_port   = var.container-port
  }
}