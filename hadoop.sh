# Navigate to home directory and clear up folders and directories
cd
sudo rm hadoop-*
sudo rm -rf hadoop-*
sudo rm -rf dfsdata
sudo rm -rf tmpdata


# Update stuff first
sudo apt update -y
sudo apt upgrade -y


# Install Java 8
sudo apt install openjdk-8-jdk -y
java -version
javac -version


# Setup and enable passwordless SSH
sudo apt install openssh-server openssh-client -y

ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys


# Download Hadoop
cd
wget https://downloads.apache.org/hadoop/common/hadoop-3.2.2/hadoop-3.2.2.tar.gz
tar xzf /home/$USER/hadoop-3.2.2.tar.gz


# Setting up Hadoop directories
mkdir dfsdata
mkdir tmpdata
mkdir dfsdata/datanode
mkdir dfsdata/namenode
sudo chown -R $USER:$USER /home/$USER/dfsdata/
sudo chown -R $USER:$USER /home/$USER/dfsdata/datanode/
sudo chown -R $USER:$USER /home/$USER/dfsdata/namenode/


# Setting up bashrc
sudo echo "export HADOOP_HOME=/home/$USER/hadoop-3.2.2" >> ~/.bashrc
source ~/.bashrc
sudo echo "export HADOOP_INSTALL=$HADOOP_HOME" >> ~/.bashrc
sudo echo "export HADOOP_MAPRED_HOME=$HADOOP_HOME" >> ~/.bashrc
sudo echo "export HADOOP_COMMON_HOME=$HADOOP_HOME" >> ~/.bashrc
sudo echo "export HADOOP_HDFS_HOME=$HADOOP_HOME" >> ~/.bashrc
sudo echo "export YARN_HOME=$HADOOP_HOME" >> ~/.bashrc
sudo echo "export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native" >> ~/.bashrc
sudo echo "export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin" >> ~/.bashrc
sudo echo "export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"" >> ~/.bashrc
source ~/.bashrc


# Setting up hadoop-env.sh
sudo rm $HADOOP_HOME/etc/hadoop/tmp-hadoop-env.sh
sudo touch $HADOOP_HOME/etc/hadoop/tmp-hadoop-env.sh
sudo chmod 777 $HADOOP_HOME/etc/hadoop/tmp-hadoop-env.sh

while read line;
do
    if [ "$line" = "# export JAVA_HOME=" ]; then
        sudo echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> $HADOOP_HOME/etc/hadoop/tmp-hadoop-env.sh
    else
        sudo echo $line >> $HADOOP_HOME/etc/hadoop/tmp-hadoop-env.sh
    fi
done < $HADOOP_HOME/etc/hadoop/hadoop-env.sh

sudo rm $HADOOP_HOME/etc/hadoop/hadoop-env.sh
sudo mv $HADOOP_HOME/etc/hadoop/tmp-hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh


# Setting up core-site.xml
sudo rm $HADOOP_HOME/etc/hadoop/tmp-core-site.xml
sudo touch $HADOOP_HOME/etc/hadoop/tmp-core-site.xml
sudo chmod 777 $HADOOP_HOME/etc/hadoop/tmp-core-site.xml

while read line;
do
    if [ "$line" = "<configuration>" ]; then
        sudo echo "<configuration>" >> $HADOOP_HOME/etc/hadoop/tmp-core-site.xml
        sudo echo "<property>" >> $HADOOP_HOME/etc/hadoop/tmp-core-site.xml
        sudo echo "  <name>hadoop.tmp.dir</name>" >> $HADOOP_HOME/etc/hadoop/tmp-core-site.xml
        sudo echo "  <value>/home/$USER/tmpdata</value>" >> $HADOOP_HOME/etc/hadoop/tmp-core-site.xml
        sudo echo "</property>" >> $HADOOP_HOME/etc/hadoop/tmp-core-site.xml
        sudo echo "<property>" >> $HADOOP_HOME/etc/hadoop/tmp-core-site.xml
        sudo echo "  <name>fs.default.name</name>" >> $HADOOP_HOME/etc/hadoop/tmp-core-site.xml
        sudo echo "  <value>hdfs://127.0.0.1:9000</value>" >> $HADOOP_HOME/etc/hadoop/tmp-core-site.xml
        sudo echo "</property>" >> $HADOOP_HOME/etc/hadoop/tmp-core-site.xml
        sudo echo "</configuration>" >> $HADOOP_HOME/etc/hadoop/tmp-core-site.xml
        break
    else
        sudo echo $line >> $HADOOP_HOME/etc/hadoop/tmp-core-site.xml
    fi
done < $HADOOP_HOME/etc/hadoop/core-site.xml

sudo rm $HADOOP_HOME/etc/hadoop/core-site.xml
sudo mv $HADOOP_HOME/etc/hadoop/tmp-core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml


# Setting up hdfs-site.xml
sudo rm $HADOOP_HOME/etc/hadoop/tmp-hdfs-site.xml
sudo touch $HADOOP_HOME/etc/hadoop/tmp-hdfs-site.xml
sudo chmod 777 $HADOOP_HOME/etc/hadoop/tmp-hdfs-site.xml

while read line;
do
    if [ "$line" = "<configuration>" ]; then
        sudo echo "<configuration>" >> $HADOOP_HOME/etc/hadoop/tmp-hdfs-site.xml
        sudo echo "<property>" >> $HADOOP_HOME/etc/hadoop/tmp-hdfs-site.xml
        sudo echo "  <name>dfs.name.dir</name>" >> $HADOOP_HOME/etc/hadoop/tmp-hdfs-site.xml
        sudo echo "  <value>/home/$USER/dfsdata/namenode</value>" >> $HADOOP_HOME/etc/hadoop/tmp-hdfs-site.xml
        sudo echo "</property>" >> $HADOOP_HOME/etc/hadoop/tmp-hdfs-site.xml
        sudo echo "<property>" >> $HADOOP_HOME/etc/hadoop/tmp-hdfs-site.xml
        sudo echo "  <name>dfs.data.dir</name>" >> $HADOOP_HOME/etc/hadoop/tmp-hdfs-site.xml
        sudo echo "  <value>/home/$USER/dfsdata/datanode</value>" >> $HADOOP_HOME/etc/hadoop/tmp-hdfs-site.xml
        sudo echo "</property>" >> $HADOOP_HOME/etc/hadoop/tmp-hdfs-site.xml
        sudo echo "<property>" >> $HADOOP_HOME/etc/hadoop/tmp-hdfs-site.xml
        sudo echo "  <name>dfs.replication</name>" >> $HADOOP_HOME/etc/hadoop/tmp-hdfs-site.xml
        sudo echo "  <value>1</value>" >> $HADOOP_HOME/etc/hadoop/tmp-hdfs-site.xml
        sudo echo "</property>" >> $HADOOP_HOME/etc/hadoop/tmp-hdfs-site.xml
        sudo echo "</configuration>" >> $HADOOP_HOME/etc/hadoop/tmp-hdfs-site.xml
        break
    else
        sudo echo $line >> $HADOOP_HOME/etc/hadoop/tmp-hdfs-site.xml
    fi
done < $HADOOP_HOME/etc/hadoop/hdfs-site.xml

sudo rm $HADOOP_HOME/etc/hadoop/hdfs-site.xml
sudo mv $HADOOP_HOME/etc/hadoop/tmp-hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml


# Setting up mapred-site.xml
sudo rm $HADOOP_HOME/etc/hadoop/tmp-mapred-site.xml
sudo touch $HADOOP_HOME/etc/hadoop/tmp-mapred-site.xml
sudo chmod 777 $HADOOP_HOME/etc/hadoop/tmp-mapred-site.xml

while read line;
do
    if [ "$line" = "<configuration>" ]; then
        sudo echo "<configuration>" >> $HADOOP_HOME/etc/hadoop/tmp-mapred-site.xml
        sudo echo "<property>" >> $HADOOP_HOME/etc/hadoop/tmp-mapred-site.xml
        sudo echo "    <name>mapreduce.framework.name</name>" >> $HADOOP_HOME/etc/hadoop/tmp-mapred-site.xml
        sudo echo "    <value>yarn</value>" >> $HADOOP_HOME/etc/hadoop/tmp-mapred-site.xml
        sudo echo "</property>" >> $HADOOP_HOME/etc/hadoop/tmp-mapred-site.xml
        sudo echo "</configuration>" >> $HADOOP_HOME/etc/hadoop/tmp-mapred-site.xml
        break
    else
        sudo echo $line >> $HADOOP_HOME/etc/hadoop/tmp-mapred-site.xml
    fi
done < $HADOOP_HOME/etc/hadoop/mapred-site.xml

sudo rm $HADOOP_HOME/etc/hadoop/mapred-site.xml
sudo mv $HADOOP_HOME/etc/hadoop/tmp-mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml


# Setting up yarn-site.xml
sudo rm $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
sudo touch $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
sudo chmod 777 $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml

while read line;
do
    if [ "$line" = "<configuration>" ]; then
        sudo echo "<configuration>" >> $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
        sudo echo "<property>" >> $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
        sudo echo "  <name>yarn.nodemanager.aux-services</name>" >> $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
        sudo echo "  <value>mapreduce_shuffle</value>" >> $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
        sudo echo "</property>" >> $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
        sudo echo "<property>" >> $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
        sudo echo "  <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>" >> $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
        sudo echo "  <value>org.apache.hadoop.mapred.ShuffleHandler</value>" >> $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
        sudo echo "</property>" >> $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
        sudo echo "<property>" >> $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
        sudo echo "  <name>yarn.resourcemanager.hostname</name>" >> $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
        sudo echo "  <value>127.0.0.1</value>" >> $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
        sudo echo "</property>" >> $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
        sudo echo "<property>" >> $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
        sudo echo "  <name>yarn.acl.enable</name>" >> $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
        sudo echo "  <value>0</value>" >> $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
        sudo echo "</property>" >> $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
        sudo echo "<property>" >> $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
        sudo echo "  <name>yarn.nodemanager.env-whitelist</name>   " >> $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
        sudo echo "  <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PERPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME</value>" >> $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
        sudo echo "</property>" >> $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
        sudo echo "</configuration>" >> $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
        break
    else
        sudo echo $line >> $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml
    fi
done < $HADOOP_HOME/etc/hadoop/yarn-site.xml

sudo rm $HADOOP_HOME/etc/hadoop/yarn-site.xml
sudo mv $HADOOP_HOME/etc/hadoop/tmp-yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml


# Formatting HDFS NameNode
hdfs namenode -format


# Starting Hadoop Processes
cd
cd hadoop-3.2.2/sbin/
./start-all.sh


# Checking Java Processes (should show 6 processes, including jps)
jps

