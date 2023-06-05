resource "aws_instance" "vault" {
  ami           = var.aws_instance_ami
  instance_type = var.aws_instance_type
  key_name      = var.aws_instance_key_name

  tags = {
    Name = "Vault Server"
  }

  connection {
    host        = self.public_ip
    type        = "ssh"
    agent       = false
    user        = var.aws_instance_user
    private_key = file("${var.aws_instance_conn_priv_key}")
    timeout     = "10m"
  }

  provisioner "file" {
    source      = templatefile("vault.service", { user : var.aws_instance_user })
    destination = "/home/${var.aws_instance_user}/vault.service"
  }

  provisioner "remote-exec" {
    inline = [
      "curl -O https://releases.hashicorp.com/vault/${var.vault_version}/vault_${var.vault_version}_linux_amd64.zip",
      "unzip vault_${var.vault_version}_linux_amd64.zip",
      "sudo mv /home/${var.aws_instance_user}/vault.service /etc/systemd/system/",
      "sudo systemctl start vault.service"
    ]
  }

}

output "vault_instance_ip" {
  value = aws_instance.vault.public_ip
}
