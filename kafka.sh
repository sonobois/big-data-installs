#!/bin/bash
cd
# Delete previous zookeeper files and installations
if [ -d "apache-zookeeper-*" ]; then
    echo "Deleting previous zookeeper files and installations"
    sudo rm apache-zookeeper-*
fi
sudo rm -rf apache-zookeeper-*

# Installing zookeeper
wget https://dlcdn.apache.org/zookeeper/zookeeper-3.8.0/apache-zookeeper-3.8.0-bin.tar.gz
tar xzf apache-zookeeper-3.8.0-bin.tar.gz

# If not installed before
if [ -d "/opt/apache-zookeeper" ]; then
    echo "Deleting previous zookeeper installation"
    sudo rm -rf /opt/apache-zookeeper-*
fi
sudo mv apache-zookeeper-3.8.0-bin /opt

cd /opt/apache-zookeeper-3.8.0-bin
sudo mkdir data

# Create a configuration file
sudo touch conf/zoo.cfg

sudo bash -c "echo 'tickTime=2000
dataDir=/var/lib/zookeeper
clientPort=2181' > conf/zoo.cfg"

sudo bin/zkServer.sh start