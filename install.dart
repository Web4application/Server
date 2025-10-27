Copy
#!/bin/sh

# Install basic utilities.
sudo apt-get update && sudo apt-get install wget gpg coreutils

# Get the latest Hashicorp gpg keyring.
sudo rm -f /usr/share/keyrings/hashicorp-archive-keyring.gpg
wget -O- https://apt.releases.hashicorp.com/gpg | \
  sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add the hashicorp source list.
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
  sudo tee /etc/apt/sources.list.d/hashicorp.list

# Install Nomad and Vault.
sudo apt-get update && sudo apt-get install nomad vault
