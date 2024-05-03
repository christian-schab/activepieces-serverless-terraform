output "endpoint" {
  value = "http://${module.ecs.alb_endpoint}/"
}
