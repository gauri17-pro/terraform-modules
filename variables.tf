variable "aws_region" {
    type = string
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "key_name" {
    description = "EC2 Key Pair name"
    type        = string
}