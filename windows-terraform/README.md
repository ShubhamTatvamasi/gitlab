# Windows Terraform Setup for GitLab Runner

This folder deploys a Windows Server 2025 Core Base EC2 instance for GitLab CI.

It uses an RSA key pair for Windows password retrieval and opens RDP by default.

## Init
```bash
terraform init -upgrade
```

## Apply
```bash
terraform apply -auto-approve
```

If your RSA public key is not at `~/.ssh/id_rsa.pub`, override the key path with:

```bash
export TF_VAR_public_key_path="~/.ssh/my_rsa.pub"
```

## Get the public IP
```bash
terraform output -raw public_ip
```

## Access Windows
Windows Server 2025 Core Base does not include the full desktop GUI, but it does support RDP for remote administration.

### Retrieve the Windows Administrator password
Use the private key that matches the public key uploaded by Terraform with `TF_VAR_public_key_path`.

If your private key file is in the new OpenSSH format, convert it to PEM first:
```bash
cp ~/.ssh/id_rsa ~/.ssh/id_rsa.orig
sudo ssh-keygen -p -m PEM -f ~/.ssh/id_rsa
```

```bash
aws ec2 get-password-data --instance-id $(terraform output -raw instance_id) --priv-launch-key ~/.ssh/id_rsa > windows-password.txt
```

Username: `Administrator`

Password:
```bash
cat windows-password.txt | jq -r '.PasswordData'
```

### Connect with RDP
Use an RDP client with the instance public IP.

### Optional SSH access
If you want SSH later, you can add port 22 with `TF_VAR_sg_ports='[22,3389]'` before `terraform apply`. By default the module opens only RDP port 3389.

## Destroy
```bash
terraform destroy -auto-approve
```
