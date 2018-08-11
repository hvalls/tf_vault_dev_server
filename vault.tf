provider "aws" {
  access_key = "${var.aws_key}"
  secret_key = "${var.aws_secret}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "vault" {
  ami           = "ami-466768ac"
  instance_type = "t2.micro"
  key_name = "${var.vault_key_name}"

  tags {
    Name = "Vault"
  }

  provisioner "file" {
    connection {
      type        = "ssh"
      agent       = false
      user        = "ec2-user"
      private_key = "${file("${var.vault_private_key_file}")}"
      timeout = "10m"
    }
    source = "./vault.service"
    destination = "/home/ec2-user/vault.service"
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      agent       = false
      user        = "ec2-user"
      private_key = "${file("${var.vault_private_key_file}")}"
      timeout = "10m"
    }
    inline = [
      "curl -O https://releases.hashicorp.com/vault/0.10.4/vault_0.10.4_linux_amd64.zip",
      "unzip vault_0.10.4_linux_amd64.zip",
      "sudo mv /home/ec2-user/vault.service /etc/systemd/system/",
      "sudo systemctl start vault.service"
    ]
  }

}

output "vault_ip" {
  value = "${aws_instance.vault.public_ip}"
}