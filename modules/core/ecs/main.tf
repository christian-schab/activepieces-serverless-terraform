resource "random_password" "ap_encryption_key" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_ssm_parameter" "user_password" {
  name      = "/${var.PREFIX}/AP/ENCRYPTION_KEY"
  type      = "SecureString"
  value     = random_password.ap_encryption_key.result
  overwrite = true
}

resource "aws_ecs_cluster" "activepieces_cluster" {
  name = "${var.PREFIX}__activepieces-cluster"
}

resource "aws_ecs_cluster_capacity_providers" "activepieces_cluster_capacity_provider" {
  cluster_name = aws_ecs_cluster.activepieces_cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

resource "aws_ecs_task_definition" "activepieces_task_definition" {
  family                   = "${var.PREFIX}__activepieces-task-definition"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = var.IAM_EXECUTION_ROLE_ARN
  task_role_arn            = var.IAM_TASK_ROLE_ARN

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }

  cpu                   = var.TASK_CPU
  memory                = var.TASK_MEMORY
  container_definitions = jsonencode([
    {
      name  = "activepieces"
      image = var.DOCKER_IMAGE

      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = "/activepieces/${var.PREFIX}",
          "awslogs-region"        = var.AWS_REGION,
          "awslogs-create-group"  = "true",
          "awslogs-stream-prefix" = var.PREFIX
        }
      }


      essential    = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]

      environment = [
        {
          name  = "AP_QUEUE_MODE",
          value = "REDIS"
        }, {
          name  = "AP_FRONTEND_URL"
          value = var.AP_FRONTEND_URL
        }, {
          name  = "AP_DB_TYPE",
          value = "POSTGRES"
        }, {
          name  = "AP_POSTGRES_DATABASE"
          value = var.DB_NAME
        }, {
          name  = "AP_POSTGRES_HOST"
          value = var.DB_HOST
        }, {
          name  = "AP_POSTGRES_PORT"
          value = tostring(var.DB_PORT)
        }, {
          name  = "AP_ENVIRONMENT"
          value = "prod"
        }, {
          name  = "AP_EDITION",
          value = var.AP_EDITION
        }
      ]

      secrets = [
        {
          name      = "AP_REDIS_URL",
          valueFrom = "arn:aws:ssm:${var.AWS_REGION}:${var.AWS_ACCOUNT_ID}:parameter/${var.PREFIX}/REDIS/URL"
        }, {
          name      = "AP_POSTGRES_USERNAME",
          valueFrom = "arn:aws:ssm:${var.AWS_REGION}:${var.AWS_ACCOUNT_ID}:parameter/${var.PREFIX}/POSTGRES/USER_NAME"
        }, {
          name      = "AP_POSTGRES_PASSWORD",
          valueFrom = "arn:aws:ssm:${var.AWS_REGION}:${var.AWS_ACCOUNT_ID}:parameter/${var.PREFIX}/POSTGRES/USER_PASSWORD"
        }, {
          name      = "AP_ENCRYPTION_KEY",
          valueFrom = "arn:aws:ssm:${var.AWS_REGION}:${var.AWS_ACCOUNT_ID}:parameter/${var.PREFIX}/AP/ENCRYPTION_KEY"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "activepieces_task_service" {
  name            = "${var.PREFIX}__activepieces-service"
  cluster         = aws_ecs_cluster.activepieces_cluster.id
  task_definition = aws_ecs_task_definition.activepieces_task_definition.arn
  desired_count   = var.TASK_INSTANCES

  depends_on = [aws_lb_target_group.ap_alb_tg]

  propagate_tags = "NONE"
  tags = {}
  tags_all = {}
  triggers = {}

  network_configuration {
    assign_public_ip = true
    subnets          = data.aws_subnets.default_subnets.ids
    security_groups  = [
      var.SG_AP_INSTANCES_ID
    ]
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    base              = 1
    weight            = 100
  }

  deployment_circuit_breaker {
    enable   = false
    rollback = false
  }

  deployment_controller {
    type = "ECS"
  }

  load_balancer {
    container_name   = "activepieces"
    container_port   = 80
    target_group_arn = aws_lb_target_group.ap_alb_tg.arn
  }
}
