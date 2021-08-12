# Installing curl
sudo apt install curl -y

# Obtaining and adding repositories
curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list

# Updating system and installing MongoDB
sudo apt update -y
sudo apt install mongodb-org -y

#Starting MongoDB
sudo systemctl start mongod.service
