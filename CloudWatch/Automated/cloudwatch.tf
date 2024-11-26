provider "aws" {

  region = "us-east-1" # Specify your region

}

# IAM Role for EC2

resource "aws_iam_role" "ec2_cloudwatch_role" {

  name = "ec2-cloudwatch-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17",

    Statement = [

      {

        Action = "sts:AssumeRole",

        Effect = "Allow",

        Principal = {

          Service = "ec2.amazonaws.com"

        }

      }

    ]

  })

}



# IAM Policy to Allow Logs to CloudWatch

resource "aws_iam_policy" "cloudwatch_policy" {

  name        = "cloudwatch-log-policy"

  description = "Allow EC2 to write logs to CloudWatch"

  policy = jsonencode({

    Version = "2012-10-17",

    Statement = [

      {

        Action = [

          "logs:CreateLogGroup",

          "logs:CreateLogStream",

          "logs:PutLogEvents",

          "logs:DescribeLogGroups",

          "logs:DescribeLogStreams"

        ],

        Effect   = "Allow",

        Resource = "*"

      }

    ]

  })

}



# Attach the Policy to the Role

resource "aws_iam_role_policy_attachment" "attach_cloudwatch_policy" {

  role       = aws_iam_role.ec2_cloudwatch_role.name

  policy_arn = aws_iam_policy.cloudwatch_policy.arn

}



# EC2 Instance Profile

resource "aws_iam_instance_profile" "ec2_instance_profile" {

  name = "ec2-instance-profile"

  role = aws_iam_role.ec2_cloudwatch_role.name

}



# CloudWatch Log Group

resource "aws_cloudwatch_log_group" "app_logs" {

  name              = "/ec2/app-logs"

  retention_in_days = 7

}



# Security Group for EC2

resource "aws_security_group" "ec2_sg" {

  name_prefix = "ec2-sg"

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



# User Data Script for CloudWatch Agent

data "template_file" "user_data" {

  template = <<EOT

#!/bin/bash
# Update the instance
sudo yum update -y

# Install Nginx and Unzip (for application setup)
sudo yum install -y nginx unzip

# Download and extract the application
cd /tmp
wget https://www.free-css.com/assets/files/free-css-templates/download/page296/listrace.zip
unzip listrace.zip

# Move the application files to the Nginx directory
sudo mv listrace-v1.0/ /usr/share/nginx/html/
sudo mv /usr/share/nginx/html/listrace-v1.0 /usr/share/nginx/html/lists

# Start Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

yum install -y amazon-cloudwatch-agent

cat <<EOF > /opt/aws/amazon-cloudwatch-agent/bin/config.json

{

  "logs": {

    "logs_collected": {

      "files": {

        "collect_list": [

          {

            "file_path": "/var/log/messages",

            "log_group_name": "${aws_cloudwatch_log_group.app_logs.name}",

            "log_stream_name": "{instance_id}/messages",

            "timestamp_format": "%b %d %H:%M:%S"

          }

        ]

      }

    }

  }

}

EOF

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a start -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -m ec2

EOT

}



# EC2 Instance

resource "aws_instance" "ec2_instance" {

  ami           = "ami-0c02fb55956c7d316" # Replace with your AMI

  instance_type = "t2.micro"



  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  security_groups      = [aws_security_group.ec2_sg.name]



  user_data = data.template_file.user_data.rendered



  tags = {

    Name = "EC2-CloudWatch-Logs"

  }

}
