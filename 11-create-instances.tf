resource "aws_instance" "dev-loadbalancer" {
  ami           = "ami-06ce824c157700cd2"
  instance_type = "t2.micro"
  key_name      = "terraform-key-pair"
  subnet_id     = aws_subnet.dev-public.id
  availability_zone = "eu-central-1a"
  associate_public_ip_address = true
  private_ip = "10.0.1.50"
  vpc_security_group_ids = [aws_security_group.allow_public_web_traffic.id]
  iam_instance_profile = aws_iam_instance_profile.iam_s3_profile.name


  user_data = <<-EOF
    #!/bin/bash
    sudo apt update && sudo apt upgrade -y
    sudo apt install nginx -y
    sudo systemctl start nginx && sudo systemctl enable nginx
    sudo service apache2 stop
    sudo apt-get purge apache2 apache2-utils apache2-bin apache2.2-common
    sudo apt-get autoremove
    sudo apt install unzip awscli -y
    sudo apt autoremove -y
    sudo systemctl stop ufw
    sudo systemctl disable ufw
    sudo aws s3 cp s3://whyarebucketnamesalwaystaken-bucket/load-balancer.conf /etc/nginx/
    sudo cat /etc/nginx/load-balancer.conf > /etc/nginx/nginx.conf
    sudo rm /etc/nginx/sites-enabled/default
    sudo systemctl restart nginx
    EOF
  tags = {
    Name = "NGX-LB"
  }
}

resource "aws_instance" "dev-webserver-1" {
  ami           = "ami-06ce824c157700cd2"
  instance_type = "t2.micro"
  key_name      = "terraform-key-pair"
  subnet_id     = aws_subnet.dev-private-1.id
  availability_zone = "eu-central-1a"
  private_ip = "10.0.2.51"
  vpc_security_group_ids = [aws_security_group.allow_private_traffic.id]
  iam_instance_profile = aws_iam_instance_profile.iam_s3_profile.name

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update && sudo apt upgrade -y
    sudo apt install nginx php8.1-fpm -y
    sudo systemctl start nginx && sudo systemctl enable nginx
    sudo service apache2 stop
    sudo apt-get purge apache2 apache2-utils apache2-bin apache2.2-common
    sudo apt install unzip awscli -y
    sudo apt autoremove -y
    sudo systemctl stop ufw
    sudo systemctl disable ufw
    sudo mv /var/www/html/index.html /var/www/html/index.html.bak
    sudo aws s3 cp s3://whyarebucketnamesalwaystaken-bucket/index.php /var/www/html
    sudo rm /etc/nginx/nginx.conf
    sudo aws s3 cp s3://whyarebucketnamesalwaystaken-bucket/nginx.conf /etc/nginx/
    sudo rm /etc/nginx/sites-enabled/default
    sudo systemctl restart nginx
    sudo echo 'listen.owner = www-data' | sudo tee -a /etc/php/8.1/fpm/pool.d/www.conf
    sudo echo 'listen.group = www-data' | sudo tee -a /etc/php/8.1/fpm/pool.d/www.conf
    sudo echo 'listen.mode = 0660' | sudo tee -a /etc/php/8.1/fpm/pool.d/www.conf
    sudo service php8.1-fpm restart
    EOF

  tags = {
    Name = "NGX-WS-1"
  }
}

resource "aws_instance" "dev-webserver-2" {
  ami           = "ami-06ce824c157700cd2"
  instance_type = "t2.micro"
  key_name      = "terraform-key-pair"
  subnet_id     = aws_subnet.dev-private-1.id
  availability_zone = "eu-central-1a"
  private_ip = "10.0.2.52"
  vpc_security_group_ids = [aws_security_group.allow_private_traffic.id]
  iam_instance_profile = aws_iam_instance_profile.iam_s3_profile.name

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update && sudo apt upgrade -y
    sudo apt install nginx php8.1-fpm -y
    sudo systemctl start nginx && sudo systemctl enable nginx
    sudo service apache2 stop
    sudo apt-get purge apache2 apache2-utils apache2-bin apache2.2-common
    sudo apt install unzip awscli -y
    sudo apt autoremove -y
    sudo systemctl stop ufw
    sudo systemctl disable ufw
    sudo mv /var/www/html/index.html /var/www/html/index.html.bak
    sudo aws s3 cp s3://whyarebucketnamesalwaystaken-bucket/index.php /var/www/html
    sudo rm /etc/nginx/nginx.conf
    sudo aws s3 cp s3://whyarebucketnamesalwaystaken-bucket/nginx.conf /etc/nginx/
    sudo rm /etc/nginx/sites-enabled/default
    sudo systemctl restart nginx
    sudo echo 'listen.owner = www-data' | sudo tee -a /etc/php/8.1/fpm/pool.d/www.conf
    sudo echo 'listen.group = www-data' | sudo tee -a /etc/php/8.1/fpm/pool.d/www.conf
    sudo echo 'listen.mode = 0660' | sudo tee -a /etc/php/8.1/fpm/pool.d/www.conf
    sudo service php8.1-fpm restart
    EOF

  tags = {
    Name = "NGX-WS-2"
  }
}

resource "aws_instance" "dev-webserver-3" {
  ami           = "ami-06ce824c157700cd2"
  instance_type = "t2.micro"
  key_name      = "terraform-key-pair"
  subnet_id     = aws_subnet.dev-private-1.id
  availability_zone = "eu-central-1a"
  private_ip = "10.0.2.53"
  vpc_security_group_ids = [aws_security_group.allow_private_traffic.id]
  iam_instance_profile = aws_iam_instance_profile.iam_s3_profile.name

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update && sudo apt upgrade -y
    sudo apt install nginx php8.1-fpm -y
    sudo systemctl start nginx && sudo systemctl enable nginx
    sudo service apache2 stop
    sudo apt-get purge apache2 apache2-utils apache2-bin apache2.2-common
    sudo apt install unzip awscli -y
    sudo apt autoremove -y
    sudo systemctl stop ufw
    sudo systemctl disable ufw
    sudo mv /var/www/html/index.html /var/www/html/index.html.bak
    sudo aws s3 cp s3://whyarebucketnamesalwaystaken-bucket/index.php /var/www/html
    sudo rm /etc/nginx/nginx.conf
    sudo aws s3 cp s3://whyarebucketnamesalwaystaken-bucket/nginx.conf /etc/nginx/
    sudo rm /etc/nginx/sites-enabled/default
    sudo systemctl restart nginx
    sudo echo 'listen.owner = www-data' | sudo tee -a /etc/php/8.1/fpm/pool.d/www.conf
    sudo echo 'listen.group = www-data' | sudo tee -a /etc/php/8.1/fpm/pool.d/www.conf
    sudo echo 'listen.mode = 0660' | sudo tee -a /etc/php/8.1/fpm/pool.d/www.conf
    sudo service php8.1-fpm restart
    EOF

  tags = {
    Name = "NGX-WS-3"
  }
}

# Create a database instance
# resource "aws_instance" "dev-database" {
#   ami           = "ami-06ce824c157700cd2"
#   instance_type = "t2.micro"
#   key_name      = "terraform-ssh"
#   subnet_id     = aws_subnet.dev-private-2.id
#   availability_zone = eu-central-1a
#   private_ip = "10.0.1.50"
#   vpc_security_group_ids = [aws_security_group.allow_private_db_traffic.id]

#   tags = {
#     Name = "NGX-DB"
#   }
# }