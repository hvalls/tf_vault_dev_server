**Terraform configuration to deploy Hashicorp Vault development server on AWS EC2 instance**

**Details**

- Hashicorp Vault version: 0.10.4
- Instance AMI: ami-466768ac
- Instance type: t2.micro
- Instance name: Vault

**Required Terraform variables**

- aws_key
- aws_secret
- aws_region
- vault_private_key_file (host absolute path to *.pem* file)
- vault_key_name

**Outputs**

- vault_ip

**Usage**

1. Create a Key Pair from your AWS console and download *.pem* file
1. Create *variables.tf* file with all the required variables (See https://www.terraform.io/docs/configuration/variables.html)
2. initialize working directory with `$ terraform init`
3. Apply configuration with `$ terraform apply`

*vault_ip* will be shown. Navigate to http://{vault_ip}:8200/ui and you will see Hashicorp Vault Web UI.

NOTE: Hashicorp vault dev server runs on port 8200, by default.

NOTE: If you can't see the Vault Web UI, make sure your default security group are not missconfigured (inbound protocol/ports).

NOTE: When Vault server is started, it shows root and unseal keys. Run `journalctl -u vault.service` on the remote instance to get those keys.
