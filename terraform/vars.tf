variable "proxmox_api_url" {
  type = string
  default = "https://10.0.0.2:8006/api2/json"
}

variable "proxmox_api_user" {
    type = string
    default = "root@pam!terraform" 
}

variable "proxmox_api_key" {
    type = string
    default = "4e2f83de-8c52-47a3-9337-7d593801845f"
}

variable "proxmox_lxc_default_password" {
    type = string
    default = "KamiKadz%#90"
}

variable "root_ssh_key" {
    type = string
    default = <<-EOT
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJZTa0aosyBszCNX+8rBW2oHFQa347M5UrquxuXbQ0+h pawel@owczarczyk.it
  EOT
}
