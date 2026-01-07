Terraform starter for creating an AWS S3 bucket.

Usage

1. Copy `terraform.tfvars.example` to `terraform.tfvars` and edit the `bucket_name` (must be globally unique).

2. Ensure AWS credentials are available, either via env vars or AWS profile:

- Environment variables:

```bash
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
export AWS_REGION=us-west-2
```

- Or set `aws_profile` in `terraform.tfvars` and ensure `~/.aws/credentials` has that profile.

3. Initialize, plan and apply:

```bash
cd infrastructure
terraform init
terraform plan
terraform apply
```

Notes

- The provider uses `var.region` and optional `var.aws_profile`.
- If you want remote state, add a backend block (for example an S3 backend).
