# Spark Installation Guide
Please ensure that you have first installed Hadoop before you install Spark. Also remember to perform these installations in the home directory of the the Hadoop user profile. Switch to the Hadoop user and then execute `cd` to reach the home directory.

## Install Scala and Git

Since we have already installed Java 8, we just need to install Scala and Git

```bash
sudo apt install scala git -y
```

Check the versions of all the installed packages so far with

```bash
java -version
javac -version
scala -version
git --version
```

## Downloading Spark
Download Spark compatible with the version of Hadoop on your system. Extract it and move it to `opt/spark` directory.

```bash
wget https://downloads.apache.org/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz
tar xvf spark-3.1.2-bin-hadoop3.2.tgz
sudo mv spark-3.1.2-bin-hadoop3.2 /opt/spark
```

## Configure Spark
We need to configure a few environment variables. Execute the following

```bash
echo "export SPARK_HOME=/opt/spark" >> ~/.profile
echo "export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin" >> ~/.profile
echo "export PYSPARK_PYTHON=/usr/bin/python3" >> ~/.profile
sudo source ~/.profile
```

## Starting Spark
To start the Spark application, we need to navigate to the right directory and then convert all shell scripts to an executable. We can then execute the start commands. 

```bash
cd /opt/spark/sbin
sudo chmod +x *.sh
```

Then run `./start-all.sh` to start Spark. This will create a master and slave with default configurations. Remember to use `./stop-all.sh` to shut down all processes once you are done.

You can find more details about Master and Slave processes [here](https://phoenixnap.com/kb/install-spark-on-ubuntu).

## Access Spark from Browser
You can view Spark on a browser, visit http://localhost:8080

## Spark Shell

You can also use the Spark Shell to execute commands. First navigate to the right directory and then convert the required files to executables

```bash
cd /opt/spark/bin
sudo chmod +x pyspark 
sudo chmod +x spark-shell
```

Then execute the Spark Shell with Scala using 
```bash
./spark-shell
```

Or, you can also access Spark using Python3 with
```bash
./pyspark
```
