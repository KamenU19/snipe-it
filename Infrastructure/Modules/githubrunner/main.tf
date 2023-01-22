resource "aws_instance" "runner" {
    tags = { Name = "Github Runner2" } 
    ami = var.ami
    instance_type = var.ec2_instance_type
    subnet_id = var.subnets_id[0]
    vpc_security_group_ids = var.sec_groups
    
user_data = <<EOF
#!/bin/bash
cd /home/ubuntu
sudo wget https://releases.hashicorp.com/terraform/1.3.4/terraform_1.3.4_linux_amd64.zip
sudo apt install unzip -y
sudo unzip terraform_1.3.4_linux_amd64.zip
sudo -u ubuntu cp .profile .bash_profile
sudo -u ubuntu echo -e $"export PATH=\$PATH:$(pwd)" > /home/ubuntu/.bash_profile
source ~/.bash_profile
sudo apt update -y
sudo apt install nodejs -y
sudo ln -s /usr/bin/nodejs /usr/local/bin/node
sudo -u ubuntu mkdir /home/ubuntu/actions-runner && cd /home/ubuntu/actions-runner
sudo -u ubuntu curl -o /home/ubuntu/actions-runner-linux-x64-2.299.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.299.1/actions-runner-linux-x64-2.299.1.tar.gz    
echo "147c14700c6cb997421b9a239c012197f11ea9854cd901ee88ead6fe73a72c74  actions-runner-linux-x64-2.299.1.tar.gz" | shasum -a 256 -c
sudo -u ubuntu tar xzf /home/ubuntu/actions-runner-linux-x64-2.299.1.tar.gz -C /home/ubuntu/actions-runner
sudo -u ubuntu bash -c 'cd /home/ubuntu/actions-runner/;./config.sh --url  https://github.com/KamenU19/snipe-it --token arn:aws:secretsmanager:eu-west-1:133333268094:secret:runnersecret-clEFYO --name "github-runner" --work _work --labels "self hosted" --runasservice'
sudo -u root bash -c 'cd /home/ubuntu/actions-runner/;./svc.sh install'
sudo -u root bash -c 'cd /home/ubuntu/actions-runner/;./svc.sh start'
EOF
}
    