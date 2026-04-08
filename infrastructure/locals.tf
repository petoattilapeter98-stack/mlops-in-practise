locals {
  project_name      = "mlops-in-practise"

  mlflow_bucket_name = "${local.project_name}-mlflow-artifacts"
  test_bucket_name = "${local.project_name}-terracotta-ai-test-bucket"
  
  state_bucket_name = "${local.project_name}-terraform-state"
  dynamodb_name = "${local.project_name}-terraform-state-locking"
}