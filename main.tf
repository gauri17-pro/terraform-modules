terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

provider "aws" {
    region = var.aws_region
}

resource "aws_instance" "ec2_instance" {
    ami                    = data.aws_ami.ubuntu.id
    instance_type          = var.instance_type
    vpc_security_group_ids = [aws_security_group.sg.id]
    key_name               = var.key_name

    tags = {
        Name = "my-instance",
        ManagedBy = "Terraform"
    }
}

resource "aws_security_group" "sg" {
    name = "sg-1"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

data "aws_ami" "ubuntu" {
    most_recent = true
    owners      = ["099720109477"]

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }
}
