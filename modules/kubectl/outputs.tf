output "kubectl_server_ip" {
    value = aws_instance.kubectl-server.public_ip 
}

output "ssh_key_name" {
    value = aws_key_pair.test_ssh_key.key_name 
}