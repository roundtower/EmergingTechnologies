output "chef_public_ip" {
  value = "${aws_instance.chef.public_ip}"
}