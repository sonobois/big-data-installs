# Navigate to home directory and clear up folders and directories
cd
sudo rm spark-*
sudo rm -rf spark-*


# Installing Scala and Git
sudo apt install scala git -y


# Downloading and setting up Spark
wget https://downloads.apache.org/spark/spark-3.1.1/spark-3.1.1-bin-hadoop3.2.tgz
tar xzf spark-3.1.1-bin-hadoop3.2.tgz
sudo mv spark-3.1.1-bin-hadoop3.2 /opt/spark


# Configuring Spark
sudo echo "export SPARK_HOME=/opt/spark" >> ~/.profile
sudo echo "export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin" >> ~/.profile
sudo echo "export PYSPARK_PYTHON=/usr/bin/python3" >> ~/.profile


# Starting Spark
cd /opt/spark/sbin
sudo chmod +x *.sh
./start-all.sh