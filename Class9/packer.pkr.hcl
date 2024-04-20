packer {
  required_plugins {
    amazon = {
      version = " >= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "amazon" {
  ami_name      = "golden-image {{timestamp}}"
  instance_type = "t2.micro"
  region        = "us-east-2"
  source_ami    = "ami-09b90e09742640522"
  ssh_username  = "ec2-user"
  run_tags = {
    Name = "golden image"
  }
  ami_regions = [
    "us-east-1",
    "us-west-1"
  ]
#   ami_users = [        #share ami with another accounts
#     "992382578994",
#     "211125299363"
#     ]

}

build {
  name = "learn-packer"
  sources = [
    "source.amazon-ebs.amazon"
  ]

  provisioner "shell" {
    script = "kaizen.sh"
  }

  provisioner "breakpoint" {
    note = "Please verify"
  }
}
