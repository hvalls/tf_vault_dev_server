**Terraform configuration to deploy Hashicorp Vault development server on AWS EC2 instance**

NOTE: You need to configure a Key Pair on your AWS console and download *.pem* file

NOTE: Vault dev server runs on port 8200, by default.

**Required Terraform variables**

- aws_key
- aws_secret
- aws_region
- vault_private_key_file
- vault_key_name

**Outputs**

- vault_ip

**Usage**

```
$ terraform init
$ terraform apply
