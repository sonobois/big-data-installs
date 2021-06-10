# Installing Scala and Git
sudo apt install scala git -y


# Downloading and setting up Spark
wget https://downloads.apache.org/spark/spark-3.1.1/spark-3.1.1-bin-hadoop3.2.tgz
tar xvf spark-3.1.1-bin-hadoop3.2.tgz
sudo mv spark-3.1.1-bin-hadoop3.2.tgz /opt/spark


# Configuring Spark
echo "export SPARK_HOME=/opt/spark" >> ~/.profile
echo "export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin" >> ~/.profile
echo "export PYSPARK_PYTHON=/usr/bin/python3" >> ~/.pro


# Starting 
cd /opt/spark/sbin
sudo chmod +x *.sh
./start-all.sh