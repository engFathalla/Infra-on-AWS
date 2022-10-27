provider "aws" {
  region  = var.region
  profile = "fathalla"
}

module "MyApp_subnet" {
  source = "./Modules/Subnet"
  vpc_id = aws_vpc.myapp_vpc.id
  sub_1 = var.sub_1
  avail_zone = var.avail_zone
  prefix_env = var.prefix_env
}

module "MyApp_Webserver" {
  source = "./Modules/Webserver"
      ami = var.ami
      instance_type =var.instance_type
      subnet_1 = var.sub_1
      avail_zone = var.avail_zone
      prefix_env =var.prefix_env
      vpc_id = aws_vpc.myapp_vpc.id
      subnet_1_id= module.MyApp_subnet.subnet_1_id
}