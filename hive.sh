cd
if [ -d "hive" ]; then
    echo "Deleting previous hive installation"
    sudo rm -rf hive
fi

mkdir hive
cd hive

wget https://downloads.apache.org/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz
tar -xvf apache-hive-3.1.3-bin.tar.gz
mv apache-hive-3.1.3-bin apache_hive

cd
export HIVE_HOME=$HOME/hive/apache_hive >> ~/.bashrc
source ~/.bashrc
export PATH=$PATH:$HIVE_HOME/bin
source ~/.bashrc

hadoop version

cd hadoop-3.3.3/sbin/
./start-all.sh

jps

hdfs dfs -mkdir -p /root/hive/warehouse
$HIVE_HOME/bin/schematool -initSchema -dbType derby

hive