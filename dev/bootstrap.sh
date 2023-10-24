sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo systemctl enable docker
sudo systemctl start docker
users=($(cat /etc/passwd | grep /bin/bash | awk -F':' '{print $1}'))
for u in ${users[@]}; do
    sudo usermod -aG docker $u
done
# docker run --rm -p 80:3000 bkimminich/juice-shop