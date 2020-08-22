# Cassandra Installation Guide
Please ensure that you have first installed Hadoop before you install Cassandra. Also remember to perform these installations in the home directory of the the Hadoop user profile. Switch to Hadoop with ```su - hadoop``` and then execute ```cd``` to reach the home directory.

## Install the apt-transport-https Package
Run the following command to install the apt-transport-https package
```sh
sudo apt install apt-transport-https -y
```

## Add Apache Cassandra Repository and Import GPG Key
You need to add the Apache Cassandra repository and pull the GPG key before installing the database.Enter the commands below to add the Cassandra repository to the sources list. Then, use the ```wget``` command to pull the public key from the URL.
```sh
sudo sh -c 'echo "deb http://www.apache.org/dist/cassandra/debian 40x main" > /etc/apt/sources.list.d/cassandra.list'
wget -q -O - https://www.apache.org/dist/cassandra/KEYS | sudo apt-key add -
```
If everything worked fine, it will display ```OK```.

## Install Apache Cassandra
Installing Cassandra is pretty easy. First, update the repository package list and then apt install it.
```sh
sudo apt update -y
sudo apt install cassandra -y
```

## Verify Cassandra Installation
Note that it might take a while for the installation to finish, even after the ```apt install``` command as finished executing. It typically takes a few minutes. 
To verify if Cassandra has installed completely, run
```sh
nodetool status
```
The ```UN``` letters indicate that Cassandra has been successfully installed. Otherwise you will get a message saying it has not finished. Ensure that Cassandra has complteley finished installing before moving on to the next section.

## Running Cassandra

You can perform the following operations using Cassandra
* Start Cassandra: ```sudo systemctl start cassandra```
* Stop Cassandra: ```sudo systemctl stop cassandra```
* Check Status: ```sudo systemctl status cassandra```

## Cassandra Shell
To access the Cassandra shell, use the ```cqlsh``` command.

## Additional Configuration
You can find additional configuration for Cassandra such as the names of the clusters and IP addresses of the nodes [here](https://phoenixnap.com/kb/install-cassandra-on-ubuntu).
