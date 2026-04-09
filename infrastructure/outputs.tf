output "bucket_id" {
  description = "S3 bucket ID"
  value       = aws_s3_bucket.mlflow_bucket.id
}

output "bucket_arn" {
  description = "S3 bucket ARN"
  value       = aws_s3_bucket.mlflow_bucket.arn
}

output "gpu_instance_id" {
  description = "ID of the GPU spot EC2 instance"
  value       = aws_instance.gpu_spot_instance.id
}

output "gpu_instance_public_ip" {
  description = "Public IP address for the GPU spot EC2 instance"
  value       = aws_instance.gpu_spot_instance.public_ip
}
