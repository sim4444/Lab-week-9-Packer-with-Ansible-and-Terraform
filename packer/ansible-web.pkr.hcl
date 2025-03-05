
packer {
  required_plugins {
    # COMPLETE ME
    # add necessary plugins for ansible and aws
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.0.0"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = ">= 1.0.0"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  # COMPLETE ME
  # add configuration to use Ubuntu 24.04 image as source image
  ami_name      = "packer-ubuntu-24-04"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["099720109477"] # Canonical's AWS account ID
    most_recent = true
  }
  
  region     = "us-west-2"
  instance_type = "t2.micro"
  communicator  = "ssh"
  ssh_username  = "ubuntu"
}

build {
  # COMPLETE ME
  # add configuration to: 
  # - use the source image specified above
  # - use the "ansible" provisioner to run the playbook in the ansible directory
  # - use the ssh user-name specified in the "variables.pkr.hcl" file

  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "ansible" {
    ansible_env_vars = [
      "ANSIBLE_HOST_KEY_CHECKING=False"
    ]
    playbook_file = "../ansible/playbook.yml"
    user = "ubuntu"

  }


}
