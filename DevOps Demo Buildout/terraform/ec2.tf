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