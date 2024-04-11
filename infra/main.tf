variable "public_key" {
  description = "SSH public key"
}

resource "aws_vpc" "ts_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev"
  }
}
resource "aws_subnet" "ts_pulic_subnet" {
  vpc_id                  = aws_vpc.ts_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "dev-public"
  }

}

resource "aws_internet_gateway" "ts_internet_gateway" {
  vpc_id = aws_vpc.ts_vpc.id

  tags = {
    Name = "dev-igw"
  }
}

resource "aws_route_table" "ts_public_rt" {
  vpc_id = aws_vpc.ts_vpc.id

  tags = {
    Name = "dev-public-rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.ts_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ts_internet_gateway.id
}

resource "aws_route_table_association" "mtc_public_assoc" {
  subnet_id      = aws_subnet.ts_pulic_subnet.id
  route_table_id = aws_route_table.ts_public_rt.id


}


resource "aws_security_group" "ts_sg" {
  name        = "dev-sg"
  description = "Dev security group"
  vpc_id      = aws_vpc.ts_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["115.246.24.52/32","106.216.101.89/32"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]


  }
}

resource "aws_key_pair" "ts_auth" {
  key_name   = "tskey"
  public_key = var.public_key

}

resource "aws_instance" "dev_node" {
  instance_type = "t2.micro"
  ami           = data.aws_ami.server_ami.id
  root_block_device {
    volume_size = 10
  }
  associate_public_ip_address = true 
  tags = {
    Name = "dev-node"
  }
  # provisioner "local-exec" {
  #   command =templatefile("windows-ssh-config.tpl",{
  #     hostname =self.public_ip
  #     user ="ubuntu"
  #     identityfile ="~/.ssh/id_ed25519"
  #   })
  #   interpreter = ["Powershell","-Command"]
  # }

  key_name               = aws_key_pair.ts_auth.id
  vpc_security_group_ids = [aws_security_group.ts_sg.id]
  subnet_id              = aws_subnet.ts_pulic_subnet.id
  user_data       =   file("userdata.tpl")
  

}

# ami-080e1f13689e07408 (64-bit (x86))
# 099720109477  
