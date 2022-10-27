output "MyApp_Server_Public_IP" {
  value = aws_instance.MyApp_Server.public_ip
}