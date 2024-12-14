### Key Pair 생성 ###
# resource "aws_key_pair" "keypair" {
#     public_key = file("./.ssh/weplat-key.pub")
#     key_name = "${var.tag_name}-key"
# }

### Bastion EC2 생성 ###
resource "aws_instance" "bastion_ec2" {
  ami                         = var.ami_amznlinux3
  instance_type               = var.ec2_type_bastion
  key_name                    = "${var.key_name}-key"
  availability_zone           = "${var.region}${var.ava_zone[1]}"
  subnet_id                   = var.pub_subnet[1]
  vpc_security_group_ids      = [var.bastion_sg]
  iam_instance_profile = aws_iam_instance_profile.ssm.name
  associate_public_ip_address = true
  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    delete_on_termination = true
  }
  tags = {
    Name = "${var.tag_name}-Bastion"
  }
}

### Monitoring EC2 생성 ###
resource "aws_instance" "Monitoring_ec2" {
  ami                         = var.ami_ubuntu20_04
  instance_type               = "t3.large"
  key_name                    = "${var.tag_name}-key"
  iam_instance_profile = aws_iam_instance_profile.ssm.name
  availability_zone           = "${var.region}${var.ava_zone[1]}"
  subnet_id                   = var.pri_subnet[1]
  vpc_security_group_ids      = [var.monitoring_sg]
  associate_public_ip_address = false
  root_block_device {
    volume_size           = 20
    volume_type           = "gp3"
    delete_on_termination = true
  }
  tags = {
    Name = "${var.tag_name}-monitoring"
  }
}


data "aws_iam_policy_document" "ssm" {
  version = "2012-10-17"
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_instance_profile" "ssm" {
  name = "ssm-role"
  role = aws_iam_role.ssm.name
}


resource "aws_iam_role" "ssm" {
  name               = "ssm-role"
  assume_role_policy = data.aws_iam_policy_document.ssm.json
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
