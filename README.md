# Terraform Multi-Cloud Infrastructure

This project provisions web servers across multiple cloud providers using Terraform. Currently supports AWS with plans for additional cloud providers.

## Overview

The infrastructure creates:
- AWS EC2 instance running Ubuntu 22.04 LTS
- NGINX web server with a simple "Hello World" page
- Security group allowing SSH and HTTP access
- Auto-configured networking using default VPC

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.3.0
- AWS CLI configured with appropriate credentials
- SSH key pair for EC2 access (optional)

## Quick Start

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd terraform-multicloud
   ```

2. **Initialize Terraform**
   ```bash
   terraform init
   ```

3. **Review the plan**
   ```bash
   terraform plan
   ```

4. **Apply the configuration**
   ```bash
   terraform apply
   ```

5. **Access your web server**
   After deployment, use the output IP address to access your web server:
   ```bash
   curl http://<aws_instance_ip>
   ```

## Configuration

### Variables

| Variable | Description | Type | Default |
|----------|-------------|------|---------|
| `aws_region` | AWS region to deploy resources | string | `us-east-1` |
| `ssh_ingress_cidrs` | CIDR blocks allowed SSH/HTTP access | list(string) | `["0.0.0.0/0"]` |

### Customizing Variables

Create a `terraform.tfvars` file to override defaults:

```hcl
aws_region = "us-west-2"
ssh_ingress_cidrs = ["YOUR_IP/32"]  # Replace with your IP for better security
```

## Architecture

### AWS Resources

- **EC2 Instance**: t3.micro running Ubuntu 22.04 LTS
- **Security Group**: Allows inbound SSH (22) and HTTP (80)
- **VPC**: Uses default VPC and subnets
- **AMI**: Latest Ubuntu 22.04 LTS from Canonical

### Security Considerations

⚠️ **Important**: The default configuration allows access from anywhere (`0.0.0.0/0`). For production use:

1. Restrict `ssh_ingress_cidrs` to your IP address
2. Consider using a bastion host or VPN
3. Implement proper key management
4. Enable CloudTrail and monitoring

## File Structure

```
terraform-multicloud/
├── .gitignore              # Terraform and sensitive files to ignore
├── .terraform.lock.hcl     # Provider version locks
├── aws.tf                  # AWS-specific resources
├── outputs.tf              # Output definitions
├── providers.tf            # Provider configurations
├── variables.tf            # Variable definitions
└── README.md               # This file
```

## Commands Reference

### Basic Operations
```bash
# Initialize and download providers
terraform init

# Format code
terraform fmt

# Validate configuration
terraform validate

# Plan changes
terraform plan

# Apply changes
terraform apply

# Destroy infrastructure
terraform destroy
```

### Useful Commands
```bash
# Show current state
terraform show

# List resources
terraform state list

# Get outputs
terraform output

# Refresh state
terraform refresh
```

## Outputs

After successful deployment, you'll see:

- `aws_instance_ip`: Public IP address of the AWS EC2 instance

## Troubleshooting

### Common Issues

1. **AWS Credentials**: Ensure AWS CLI is configured or environment variables are set
   ```bash
   aws configure
   # OR
   export AWS_ACCESS_KEY_ID="your-access-key"
   export AWS_SECRET_ACCESS_KEY="your-secret-key"
   ```

2. **Region Limits**: Some AWS regions may have service limits or require opt-in
   
3. **Security Group**: If you can't access the web server, check security group rules

4. **Instance State**: Verify the instance is running in AWS console

### Getting Help

- Check Terraform logs: `TF_LOG=DEBUG terraform apply`
- Validate configuration: `terraform validate`
- AWS Console: Monitor resources in AWS Management Console

## Development

### Adding New Cloud Providers

To extend this project for other cloud providers:

1. Create provider-specific `.tf` files (e.g., `gcp.tf`, `azure.tf`)
2. Add required providers to `providers.tf`
3. Update `variables.tf` with provider-specific variables
4. Add outputs for new resources in `outputs.tf`

### Best Practices

- Use version constraints for providers
- Store sensitive values in environment variables or AWS Secrets Manager
- Use remote state storage for team collaboration
- Implement proper tagging strategy
- Regular backup of state files

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make changes and test thoroughly
4. Submit a pull request

## License

[Add your license information here]

## Support

For issues and questions:
- Create an issue in the repository
- Check Terraform documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
- AWS documentation: https://docs.aws.amazon.com/
