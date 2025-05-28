#!/bin/bash

set -e

# Step 1: Initialize and apply infrastructure with OpenTofu
echo "[+] Running OpenTofu..."
tofu init
tofu apply -auto-approve

# Step 2: Get the public IP from OpenTofu output
echo "[+] Extracting public IP..."
IP=$(tofu output -raw public_ip_address)

if [ -z "$IP" ]; then
  echo "[-] Failed to get public IP from OpenTofu output."
  exit 1
fi

echo "[+] Public IP: $IP"

# Step 3: Write Ansible inventory file
INVENTORY_FILE="inventory.ini"
echo "[eg_quotes_vm]" >$INVENTORY_FILE
echo "$IP ansible_user=azureuser ansible_ssh_private_key_file=./id_rsa ansible_python_interpreter=/usr/bin/python3" >>$INVENTORY_FILE

# Step 4: Run the Ansible playbook
echo "[+] Running Ansible playbook..."
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i $INVENTORY_FILE ansible/eg-azure-deployment.yml
