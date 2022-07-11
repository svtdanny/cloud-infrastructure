resource "aws_instance" "db-b" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    aws_security_group.db.id,
  ]
  subnet_id = aws_subnet.db-b.id
  user_data = file("src/db/run.sh")
  tags = {
    Name = "db-b"
  }
}

resource "aws_instance" "db-a" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    aws_security_group.db.id,
  ]
  subnet_id = aws_subnet.db-a.id
  private_ip = var.db_a.ip
  user_data = file("src/db/run.sh")
  tags = {
    Name = "db-a"
  }
}

resource "aws_instance" "app-a" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    aws_security_group.app.id,
  ]
  subnet_id = aws_subnet.app-a.id
  private_ip = var.app_a.ip
  user_data = file("src/app/run-a.sh")
  tags = {
    Name = "app-a"
  }
}

resource "aws_instance" "app-b" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    aws_security_group.app.id,
  ]
  subnet_id = aws_subnet.app-b.id
    private_ip = var.app_b.ip
  user_data = file("src/app/run-b.sh")
  tags = {
    Name = "app-b"
  }
}

resource "aws_instance" "web-a" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    aws_security_group.web.id,
  ]
  subnet_id = aws_subnet.web-a.id
  private_ip = var.web_b.ip
  user_data = file("src/nginx/run-a.sh")
  tags = {
    Name = "web-a"
  }
}

resource "aws_instance" "web-b" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    aws_security_group.web.id,
  ]
  subnet_id = aws_subnet.web-b.id
  private_ip = var.app_b.ip
  user_data = file("src/nginx/run-b.sh")
  tags = {
    Name = "web-b"
  }
}