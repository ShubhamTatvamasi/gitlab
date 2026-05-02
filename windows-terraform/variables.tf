variable "project_name" {
  type        = string
  description = "Project Name"
  default     = "gitlab-runner-windows"
}

variable "sg_ports" {
  type        = list(number)
  description = "Security Group Ports"
  default     = [3389]
}

variable "instance_type" {
  type        = string
  description = "Instance Type"
  default     = "t3a.large"
}

variable "public_key_path" {
  type        = string
  description = "Local public key path for the EC2 key pair"
  default     = "~/.ssh/id_rsa.pub"
}

variable "volume_size" {
  type        = number
  description = "Volume Size"
  default     = 100
}

variable "volume_type" {
  type    = string
  default = "gp3"
}

variable "spot_instance" {
  type    = bool
  default = false
}

variable "spot_type" {
  type    = string
  default = "one-time"
}
