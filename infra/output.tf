output "public_ip_address" {
  value = "4.175.250.255"
}
output "ssh_private_key" {
  value     = tls_private_key.vm_ssh_key.private_key_pem
  sensitive = true
}

output "ssh_command" {
  value = "ssh -i ./id_rsa azureuser@4.175.250.255"
}
