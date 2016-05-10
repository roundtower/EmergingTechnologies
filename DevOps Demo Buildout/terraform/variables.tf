# terraform variables

#variable "aws_access_key_id" {
#	default = ""
#}

#variable "aws_secret_access_key" {
#	default = ""
#}

#variable "aws_region" {
#	default = "us-east-1"
#}

variable "instance_type" {
  default = "m3.medium"
}

variable "ami" {
	# Ubuntu 14.04 LTS
	default = "ami-63ac5803"
	# Amazon Linux AMI
	#default = {
		#"us-west-2": "ami-d13845e1"
	#}
}

variable "key_name" {
	default = "eric-key2"
}

variable "key_file" {
	default = "/Users/eric/Downloads/eric-key2.pem"
}

variable "chef_version" {
	default = "12.6.0-1"
}

resource "aws_iam_user" "s3_user" {
    name = "s3_user"
}