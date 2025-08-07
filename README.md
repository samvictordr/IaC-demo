# Atomic Terraform IaC Demo: Docker Provider

This project demonstrates how to use the [Docker provider](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs) in [Terraform](https://www.terraform.io/) to provision and manage a Docker container. It also includes a [Nix Flake](https://nixos.wiki/wiki/Flakes) setup for reproducible development environments, especially for NixOS users. Also because I run NixOS primarily.

---

## 📁 Project Structure

```
IaC-demo/
├── flake.lock
├── flake.nix
├── logs/
│   ├── apply-log.txt
│   ├── destroy-log.txt
│   └── plan-log.txt
└── terraform/
    ├── main.tf
    ├── outputs.tf
    ├── provider.tf
    ├── terraform.tfstate
    ├── terraform.tfstate.backup
    └── variables.tf
```

- **flake.nix, flake.lock**: Nix Flake files for reproducible dev environments.
- **logs/**: Stores logs from Terraform operations. These logs are manual.
- **terraform/**: All Terraform configuration and state files.

---

## 🚀 Features

- **Provision Docker containers** using Terraform's Docker provider.
- **Parameterize** image name, container name, and ports.
- **Nix Flake** for easy, reproducible setup (NixOS and non-NixOS).
- **Logs** for all major Terraform actions.

---

## 🛠️ Prerequisites

- [Docker](https://docs.docker.com/get-docker/) (daemon running)
- [Terraform](https://www.terraform.io/downloads.html)
- [Nix](https://nixos.org/download.html) (optional, for flakes/devShell. If you do not want Nix, you can just skip over to the terraform workflow section.)

---

## 🧩 Nix Flake Setup 

### 1. Enable Flakes (if not already)
Add this to your `/etc/nix/nix.conf`:
```
experimental-features = nix-command flakes
```

### 2. Enter the Dev Shell
```sh
nix develop
```
You will see a welcome message and versions for Terraform, Docker, and Compose.

---

## 📝 Terraform Workflow

### 1. Initialize Terraform
```sh
cd terraform
terraform init
```

### 2. Review the Execution Plan
```sh
terraform plan | tee ../logs/plan-log.txt
```
- This shows what Terraform will do, without making changes, and writes the output to `plan-log.txt`.

### 3. Apply the Configuration
```sh
terraform apply | tee ../logs/apply-log.txt
```
- This provisions the Docker image and container as defined in `main.tf`.
- You will see outputs like the container ID and host port. Saves output to `apply-log.txt`.

### 4. Check Terraform State
```sh
terraform state list
terraform state show docker_container.nginx
```
- Inspect the current state and details of managed resources.

### 5. Destroy the Infrastructure
```sh
terraform destroy | tee ../logs/destroy-log.txt
```
- This removes the Docker container and image, and stores a log of the changes made to `destroy-log.txt`.

---

## 📂 Terraform Files Explained

Terraform sources are modularized to enhance debugging and general readability, while reducing future technical debt.

- **provider.tf**: Configures the Docker provider and backend.
- **main.tf**: Declares resources (Docker image and container).
- **variables.tf**: Parameterizes image/container names and ports.
- **outputs.tf**: Exposes container ID and host port as outputs.
- **terraform.tfstate**: Tracks the real infrastructure state (auto-managed).

---

## 🧑‍💻 Customization

You can change variables in `variables.tf` or override them at apply time:
```sh
terraform apply -var="host_port=9090" -var="container_name=mynginx"
```

---

## 📝 Example: Full Workflow

```sh
# 1. Enter Nix dev shell (optional, recommended)
nix develop

# 2. Initialize Terraform
cd terraform
terraform init

# 3. Plan
terraform plan | tee ../logs/plan-log.txt

# 4. Apply
terraform apply | tee ../logs/apply-log.txt

# 5. Check state
terraform state list
terraform state show docker_container.nginx

# 6. Destroy
terraform destroy | tee ../logs/destroy-log.txt
```

---

## 🧊 About Nix Flake (flake.nix)

- Provides a shell with all required tools: `terraform`, `docker`, `docker-compose`, `git`.
- Ensures everyone has the same versions and environment.
- See the welcome message for tool versions on shell entry.

---

## 📚 References
- [Terraform Docker Provider Docs](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs)
- [Terraform CLI Docs](https://developer.hashicorp.com/terraform/cli)
- [Nix Flakes](https://nixos.wiki/wiki/Flakes)

---

## 📝 Notes
- Make sure Docker is running before applying Terraform.
- The logs directory will capture all major Terraform actions for auditing or troubleshooting.
- The state file (`terraform.tfstate`) is local and not meant for production use.

---

