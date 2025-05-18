output "public_ip_address" {
  value = azurerm_public_ip.main.ip_address
}
output "ssh_private_key" {
  value     = tls_private_key.vm_ssh_key.private_key_pem
  sensitive = true
}

output "ssh_command" {
  value = "ssh -i ./id_rsa azureuser@${azurerm_public_ip.main.ip_address}"
}
