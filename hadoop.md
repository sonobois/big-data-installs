# Hadoop Installation Guide

Make sure you execute everything from the home directory. Use `cd` to move to home directory.

Note that the username here is `hadoop`. You need to set this to your system username (which should be your SRN).

Change any `/home/hadoop/` to `/home/<your username>/`

Start with updating your system. Use the following commands
```bash
cd
sudo apt update -y
sudo apt upgrade -y
```
## Install Java

Since Hadoop 3.x supports Java 8 currently, we will install that version
```bash
sudo apt install openjdk-8-jdk -y
```

Check your Java versions with the following commands
```bash
java -version
javac -version
```
## Setup SSH

We now need to setup a passwordless SSH
```bash
sudo apt install openssh-server openssh-client -y
```

## Enable passwordless SSH
Generate an SSH key pair and define the location is is to be stored in id_rsa. Then use the cat command to store the public key as authorized_keys in the ssh directory. Follow these commands with change in permissions.
```bash
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
```

Verify passwordless SSH with
```bash
ssh localhost
```

Type `exit` to quit SSH.

## Downloading Hadoop

Use any mirror link to get the download url. Download and extract hadoop using the following commands
```bash
wget https://downloads.apache.org/hadoop/common/hadoop-3.2.2/hadoop-3.2.2.tar.gz
tar xzf hadoop-3.2.2.tar.gz
```

## Single Node Deployment

This setup, also called pseudo-distributed mode, allows each Hadoop daemon to run as a single Java process. A Hadoop environment is configured by editing a set of configuration files:

* bashrc
* hadoop-env.sh
* core-site.xml
* hdfs-site.xml
* mapred-site-xml
* yarn-site.xml

Before proceeding, we need to make a few directories for our namenodes and datanodes and also give them the required permissions.

```bash
cd
mkdir dfsdata
mkdir tmpdata
mkdir dfsdata/datanode
mkdir dfsdata/namenode
```
Change permissions using the following commands. Remember to replace `hadoop` with your username.

```bash
sudo chown -R hadoop:hadoop /home/hadoop/dfsdata/
sudo chown -R hadoop:hadoop /home/hadoop/dfsdata/datanode/
sudo chown -R hadoop:hadoop /home/hadoop/dfsdata/namenode/
```

### Setup ~/.bashrc 
Open .bashrc with the following command
```bash
sudo nano ~/.bashrc
```

Scroll to the bottom of the file. Copy and paste these statements right at the bottom.
```bash
#Hadoop Related Options
export HADOOP_HOME=/home/hadoop/hadoop-3.2.2
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
```

Press `Ctrl + S` to save and then `Ctrl + X` to quit. Apply the changes with
```bash
source ~/.bashrc
```
### Setup hadoop-env.sh 

Open the file with
```bash
sudo nano $HADOOP_HOME/etc/hadoop/hadoop-env.sh
```
Scroll down until you find the commented line `# export JAVA_HOME=`. Uncomment the line and replace the path with your Java path. The final line should look like this
```bash
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
```

Save and exit the file as shown previously.

### Setup core-site.xml

Open the file with
```bash
sudo nano $HADOOP_HOME/etc/hadoop/core-site.xml
```
Replace the existing configuration tags with the following
```bash
<configuration>
<property>
  <name>hadoop.tmp.dir</name>
  <value>/home/hadoop/tmpdata</value>
</property>
<property>
  <name>fs.default.name</name>
  <value>hdfs://127.0.0.1:9000</value>
</property>
</configuration>
```

Save and exit the file. 

### Setup hdfs-site.xml

Open the file using 
```bash
sudo nano $HADOOP_HOME/etc/hadoop/hdfs-site.xml
```
Replace the existing configuration tags with the following

```bash
<configuration>
<property>
  <name>dfs.name.dir</name>
  <value>/home/hadoop/dfsdata/namenode</value>
</property>
<property>
  <name>dfs.data.dir</name>
  <value>/home/hadoop/dfsdata/datanode</value>
</property>
<property>
  <name>dfs.replication</name>
  <value>1</value>
</property>
</configuration>
```

To create a multi-node setup, change the `<value></value>` attribute of `dfs.replication` to the number of nodes desired. Save and exit the file after making all the changes.

### Setup mapred-site.xml

Open the file with
```bash
sudo nano $HADOOP_HOME/etc/hadoop/mapred-site.xml
```
Replace the existing configuration tags with the following
```bash
<configuration> 
<property> 
  <name>mapreduce.framework.name</name> 
  <value>yarn</value> 
</property> 
</configuration>
```

Save and exit the file.

### Setup yarn-site.xml

Open the file with
```bash
sudo nano $HADOOP_HOME/etc/hadoop/yarn-site.xml
```
Replace the existing configuration tags with the following
```bash
<configuration>
<property>
  <name>yarn.nodemanager.aux-services</name>
  <value>mapreduce_shuffle</value>
</property>
<property>
  <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
  <value>org.apache.hadoop.mapred.ShuffleHandler</value>
</property>
<property>
  <name>yarn.resourcemanager.hostname</name>
  <value>127.0.0.1</value>
</property>
<property>
  <name>yarn.acl.enable</name>
  <value>0</value>
</property>
<property>
  <name>yarn.nodemanager.env-whitelist</name>   
  <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PERPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME</value>
</property>
</configuration>
```

Save and exit the file.

## Format HDFS NameNode

Before we start Hadoop for the first time, we need to format the namenode. Use the following command
```bash
hdfs namenode -format
```

A `SHUTDOWN` message will signify the end of the formatting process.

Congratulations! You have now installed Hadoop!

## Starting Hadoop

Navigate execute the following commands

```bash
cd hadoop-3.2.2/sbin/
./start-all.sh
```

Type `jps` to find all the Java Processes. You should see 6 total processes, including the `jps` process. Note that the order of the items and the process IDs will be different.

```bash
2994 DataNode
3219 SecondaryNameNode
3927 Jps
3431 ResourceManager
2856 NameNode
3566 NodeManager
```

You can alternatively start the nodes and then the YARN resource manager manually using
```bash
./start-dfs.sh
./start-yarn.sh
```

## Access Hadoop from Browser
You can access Hadoop on localhost on the following ports
* NameNode - http://localhost:9870
* DataNode - http://localhost:9864
* YARN Manager - http://localhost:8088

Remember to stop all processes when you are done with your work.

```bash
./stop-all.sh
```
