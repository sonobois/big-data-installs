EMAIL=$2
mkdir $HOME/.ssh
eval "$(ssh-agent -s)"
ssh-keygen -t rsa -b 4096 -C $EMAIL
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub
echo "Visit https://github.com/settings/keys. Create a new SSH key and paste the above key there"
echo "Then run this on the terminal: ssh -T git@github.com"
