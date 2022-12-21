# #Create a new SSH key pair in AWS and save it to the current directory
# variable "generated_key_name" {
#   type        = string
#   default     = "terraform-key-pair"
#   description = "Key-pair generated by Terraform"
# }

resource "tls_private_key" "dev_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "terraform-key-pair"
  public_key = tls_private_key.dev_key.public_key_openssh

# For mac/unix users, you can use the following command to generate a key pair:
# provisioner "local-exec" {    # Generate "terraform-key-pair.pem" in current directory
#     command = <<-EOT
#       echo '${tls_private_key.dev_key.private_key_pem}' > ./'${var.generated_key_name}'.pem
#       chmod 400 ./'${var.generated_key_name}'.pem
#     EOT
#   }
}

resource "local_file" "private_key" {
  content  = tls_private_key.dev_key.private_key_pem
  filename = "terraform-key-pair.pem"
}
  

output "ssh_key" {
  description = "ssh key generated by terraform"
  value       = tls_private_key.dev_key.private_key_pem
  sensitive   = true
}
