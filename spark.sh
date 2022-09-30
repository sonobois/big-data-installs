# Navigate to home directory and clear up folders and directories
cd
FOLDER=`ls -d */ | grep spark-`
if [ -d "${FOLDER}" ]; then
    echo "Deleting previous spark installations"
    sudo rm spark-*
fi
sudo rm -rf spark-*


# Installing Scala and Git
sudo apt install scala git -y


# Downloading and setting up Spark
wget https://dlcdn.apache.org/spark/spark-3.3.0/spark-3.3.0-bin-hadoop3.tgz
tar xzf spark-3.3.0-bin-hadoop3.tgz
if [ -d "/opt/spark" ]; then
    echo "Spark directory exists, deleting it."
    sudo rm -rf /opt/spark
fi
sudo mv spark-3.3.0-bin-hadoop3 /opt/spark
sudo rm -rf spark-*

# Configuring Spark
echo "export SPARK_HOME=/opt/spark" >> ~/.bashrc
source ~/.bashrc
echo "export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin" >> ~/.bashrc
echo "export PYSPARK_PYTHON=/usr/bin/python3" >> ~/.bashrc
source ~/.bashrc

# Starting Spark
cd /opt/spark/sbin
sudo chmod +x *.sh

cd /opt/spark/bin
sudo chmod +x pyspark 
sudo chmod +x spark-shell
sudo chmod +x spark-submit

cd ../sbin

./start-all.sh

cd ..

./bin/run-example SparkPi 10

cd sbin

./stop-all.sh