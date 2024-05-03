variable "PREFIX" {}

variable "AWS_REGION" {}
variable "AWS_ACCOUNT_ID" {}
variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY" {}
variable "AWS_VPC_ID" {}

variable "UPSTASH_EMAIL" {}
variable "UPSTASH_API_KEY" {}

variable "DOCKER_IMAGE" {
  default = "activepieces/activepieces"
}

variable "AP_LICENSE_KEY" {
  default = ""
}

variable "AP_FRONTEND_URL" {}

variable "AP_EDITION" {}

variable "AP_EXECUTION_MODE" {
  default = "UNSANDBOXED"
}

variable "TASK_INSTANCES" {}
variable "TASK_CPU" {}
variable "TASK_MEMORY" {}
