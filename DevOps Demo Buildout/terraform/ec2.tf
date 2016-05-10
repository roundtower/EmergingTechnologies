resource "aws_instance" "chef" {
	ami = "${var.ami}"
	instance_type = "${var.instance_type}"
	associate_public_ip_address = true
	tags {
		Name = "chefserver01"
	}

	key_name = "${var.key_name}"
	
	connection {
		user = "ubuntu"
		type = "ssh"
		key_file = "${var.key_file}"
		timeout = "2m"
	}

	provisioner "remote-exec" {
		inline = [
			# install and configure chef
			"cd /tmp",
			"wget https://packages.chef.io/stable/ubuntu/14.04/chef-server-core_${var.chef_version}_amd64.deb",
			"sudo dpkg -i chef-server-core_${var.chef_version}_amd64.deb",
			"sudo chef-server-ctl reconfigure",
			"sudo chef-server-ctl user-create rttadmin RoundTower Administrator rtt-admin@noreply.com 'admin1' --filename /tmp/rtt-admin.pem",
			"sudo chef-server-ctl org-create rttet 'RoundTower Emerging Tech' --association_user rttadmin --filename /tmp/rtt_et.pem",
			"sudo chef-server-ctl install chef-manage",
			"sudo chef-server-ctl reconfigure",
			"sudo chef-manage-ctl reconfigure --accept-license"
		]
	}
}

resource "aws_instance" "www" {
	ami = "${var.ami}"
	instance_type = "t2.micro"
	associate_public_ip_address = true
	tags {
		Name = "web01"
	}

	key_name = "${var.key_name}"

	connection {
		user = "ubuntu"
		type = "ssh"
		key_file = "${var.key_file}"
		timeout = "2m"
	}

#	provisioner "chef" {
#		attributes_json = <<EOF
#		{
#			"key": "value",
#			"app": {
#				"webcluster": {
#					"nodes": [
#						"web01"
#					]
#				}
#			}
#		}
#		EOF
#		environment = "_default"
#		run_list = ["cookbook::recipe"]
#		node_name = "web01"
#		secret_key = "${file("../chef/encrypted_data_bag_secret")}"
#		secret_url = "https://chef.roundtower.io/organizations/rttet"
#		validation_client_name = "chef-validator"
#		validation_key = "${file("../chef/chef-validator.pem")}"
#		version = "${var.chef_version}"
#	}
}