module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.4.0"
}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                   = "single-instance"
  ami                    = "ami-0189c3f216088b7db"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Name        = "module-project"
    Environment = "dev"
  }
}
