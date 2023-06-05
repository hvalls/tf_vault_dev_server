**Terraform configuration to deploy Hashicorp Vault development server on AWS EC2 instance**

**Info**

- Hashicorp vault dev server runs on port 8200, by default.

- If you can't see the Vault Web UI, check your default security group rules.

- When Vault server is started, it shows root and unseal keys. Run `journalctl -u vault.service` on the remote instance to get those keys.
