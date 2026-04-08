resource "aws_s3_bucket" "mlflow_bucket" {
  bucket        = local.mlflow_bucket_name
  force_destroy = var.force_destroy

  tags = var.tags
}

resource "aws_s3_bucket" "test_bucket" {
  bucket        = local.test_bucket_name
  force_destroy = var.force_destroy

  tags = var.tags
}