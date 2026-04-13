locals {
  project_name      = "mlops-in-practise"

  mlflow_bucket_name = "${local.project_name}-mlflow-artifacts"
  state_bucket_name = "${local.project_name}-terraform-state"
  dynamodb_name = "${local.project_name}-terraform-state-locking"
}