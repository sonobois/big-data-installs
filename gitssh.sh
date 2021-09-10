EMAIL=$2
mkdir $HOME/.ssh
ssh-keygen -t rsa -b 4096 $EMAIL
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub
