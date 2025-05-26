#!/bin/bash

set -e

echo "=== Quotes App Local Deployment Environment Check ==="

# --- Check required commands ---
REQUIRED_CMDS=(ansible docker docker-compose)

for cmd in "${REQUIRED_CMDS[@]}"; do
  if ! command -v $cmd &>/dev/null; then
    echo "❌ $cmd is not installed. Please install it before proceeding."
    MISSING=true
  else
    echo "✅ $cmd is installed: $(command -v $cmd)"
  fi
done

# --- Check if Docker daemon is running ---
if ! docker info >/dev/null 2>&1; then
  echo "❌ Docker daemon is not running. Please start Docker."
  exit 1
else
  echo "✅ Docker is running."
fi

# --- Check Docker Compose V2 compatibility ---
if docker compose version &>/dev/null; then
  echo "✅ Docker Compose V2 is available via 'docker compose'."
else
  echo "❌ Docker Compose V2 is not available. Please install it (e.g., via Docker Desktop or CLI plugin)."
  MISSING=true
fi

# --- Check expected directories and files ---
REQUIRED_FILES=("../docker-compose.yml" "ansible/temp/beforeCert" "ansible/temp/afterCert" "../certbot-acme/issue.sh")

for file in "${REQUIRED_FILES[@]}"; do
  if [ ! -e "$file" ]; then
    echo "❌ Required file or directory missing: $file"
    MISSING=true
  else
    echo "✅ Found $file"
  fi
done

# --- Summary ---
if [ "$MISSING" = true ]; then
  echo -e "\n❗ Please install the missing tools and make sure all required files are present before running Ansible."
  exit 1
else
  echo -e "\n🎉 All checks passed! You can now run the Ansible deployment script:"
  ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini ./ansible/eg-local-deployment.yml
fi
