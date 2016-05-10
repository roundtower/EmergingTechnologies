# terraform Route53

resource "aws_route53_record" "chef" {
	zone_id = "ZUUW6JGBSDPGF"
	name = "chef.roundtower.io"
	type = "CNAME"
	ttl = "300"
	records = ["${aws_instance.chef.public_dns}"]
}

resource "aws_route53_record" "www" {
	zone_id = "ZUUW6JGBSDPGF"
	name = "www.roundtower.io"
	type = "CNAME"
	ttl = "300"
	records = ["${aws_instance.www.public_dns}"]
}