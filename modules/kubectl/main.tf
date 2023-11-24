resource "aws_key_pair" "test_ssh_key" {
    key_name = "testing-ssh-key"
    public_key = file(var.public_key)
}

resource "aws_instance" "kubectl-server" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    key_name = aws_key_pair.test_ssh_key.key_name
    associate_public_ip_address = true
    vpc_security_group_ids = var.sec_group_ids
    user_data = file("${path.module}/userdata.sh")
    tags = {
        "Name" = "kubectl_host"
    }
}