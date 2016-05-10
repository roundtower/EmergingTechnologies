# S3 Buckets

resource "aws_iam_access_key" "s3_user" {
    user = "${aws_iam_user.s3_user.name}"
}

resource "aws_iam_user_policy" "s3_user_all" {
    name = "s3_user"
    user = "${aws_iam_user.s3_user.name}"
    policy= <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
            	"arn:aws:s3:::rtt-et-site",
            	"arn:aws:s3:::rtt-et-site/*"
            ]
        }
   ]
}
EOF
}

resource "aws_s3_bucket" "rtt-et-bucket" {
    bucket = "rtt-et-site"
    acl = "private"
}

resource "aws_s3_bucket_object" "object" {
    bucket = "rtt-et-site"
    key = "index.html"
    source = "s3/index.html"
    etag = "${md5(file("s3/index.html"))}"
}