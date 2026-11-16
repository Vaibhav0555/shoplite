#!/usr/bin/env bash
set -euo pipefail

echo "== 1. Remove conflicting packages =="
for pkg in docker.io docker-doc docker-compose docker-compose-v2 docker-buildx podman-docker containerd runc; do
  sudo apt-get remove -y "$pkg" || true
done

echo "== 2. Add Docker's apt repository =="
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
sudo tee /etc/apt/sources.list.d/docker.sources > /dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
sudo apt-get update

echo "== 3. Install Docker Engine =="
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "== 4. Add user to docker group =="
sudo usermod -aG docker "$USER"

echo "== 5. Configure daemon.json =="
sudo tee /etc/docker/daemon.json > /dev/null <<'EOF'
{
  "log-driver": "json-file",
  "log-opts": { "max-size": "10m", "max-file": "3" },
  "live-restore": true
}
EOF
sudo dockerd --validate --config-file /etc/docker/daemon.json
sudo systemctl restart docker

echo "== 6. Verify =="
sudo docker version --format 'Client {{.Client.Version}} / Server {{.Server.Version}}'
sudo docker info --format 'Log driver: {{.LoggingDriver}} | live-restore: {{.LiveRestoreEnabled}}'
sudo docker run --rm hello-world
echo "Done. Log out and back in to use docker without sudo."
