#!/bin/bash
set -e

# Mark start
sudo mkdir -p /beforeDockerini

# Update and install packages
sudo dnf update -y
sudo dnf install -y dnf-plugins-core curl git firewalld

# Enable and start firewalld (instead of ufw)
sudo systemctl enable firewalld
sudo systemctl start firewalld

# Install Docker
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io

# Install Docker Compose (plugin-style or binary)
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Enable and start Docker
sudo systemctl start docker
sudo systemctl enable docker

# Wait for Docker daemon to be responsive
until sudo docker info >/dev/null 2>&1; do
  echo "⏳ Waiting for Docker daemon to be ready..."
  sleep 5
done
echo "✅ Docker is ready"

# Open firewall ports
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --permanent --add-port=80/tcp
sudo firewall-cmd --permanent --add-port=443/tcp
sudo firewall-cmd --reload

# Clone project repo
sudo mkdir -p /opt/quotes

echo "📥 Cloning repository..."
if sudo git clone https://github.com/Saa1amand3r/infra3.git /opt/quotes; then
  echo "✅ Repository cloned successfully"
else
  echo "❌ Failed to clone repository"
  exit 1
fi

# Navigate into the project folder
cd /opt/quotes

# Export env flag and bring up Docker containers
export COMPOSE_INTERACTIVE_NO_CLI=1
sudo docker-compose up -d

# Show status
sudo docker-compose ps

# Register & enable check_docker service
# sudo chmod +x infra/check_docker.sh
# sudo mv infra/check_docker.service /etc/systemd/system/check_docker.service

# sudo systemctl daemon-reexec
# sudo systemctl enable check_docker
# sudo systemctl start check_docker

# Mark done
sudo mkdir -p /afterDockerini
