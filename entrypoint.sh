#!/bin/bash
# Author: Zak Hassan


/etc/init.d/ssh start

printenv

cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
echo "Host 0.0.0.0" >> ~/.ssh/config
echo "Hostname $HOSTNAME" >> ~/.ssh/config
echo "IdentityFile ~/.ssh/id_rsa" >> ~/.ssh/config

# If this variable is set then we know that we are running on Kubernetes or OSEv3
if [ -z "$SPARK_NOTEBOOK_D_SERVICE_HOST" ]; then
  echo "LOG: Not kubernetes environment"
else
  echo "LOG: Starting Master"
  $SPARK_HOME/sbin/start-master.sh
  echo $SPARK_NOTEBOOK_D_SERVICE_HOST > $SPARK_HOME/conf/slaves
  echo "LOG: Starting Worker"
  $SPARK_HOME/sbin/start-slave.sh spark://spark-notebook:7077
fi


/usr/local/zeppelin/bin/zeppelin-daemon.sh start
# $SPARK_HOME/sbin/start-all.sh
# For debugging uncomment below:
# cat /usr/local/spark/logs/spark--org.apache.spark.deploy.master.Master*


tail -f /usr/local/zeppelin/logs/*.log
