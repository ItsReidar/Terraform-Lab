resource "aws_iam_role" "s3-ec2-role" {
  name = "AllowS3Access"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      tag-key = "Allow S3 Access"
  }
}

resource "aws_iam_instance_profile" "iam_s3_profile" {
  name = "iam_s3_ec2_profile"
  role = aws_iam_role.s3-ec2-role.name
}

resource "aws_iam_role_policy" "s3_ec2_policy" {
  name = "s3_ec2_policy"
  role = aws_iam_role.s3-ec2-role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}