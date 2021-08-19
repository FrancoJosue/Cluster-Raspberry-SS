#Agregar al final del archivo bashrc

# java

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-arm64
export PATH=$PATH:$JAVA_HOME/bin

#variables hadoop

export HADOOP_HOME=/opt/hadoop-3.3.0
export PATH=$PATH:/$HADOOP_HOME/bin:/$HADOOP_HOME/sbin
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export LD_LIBRARY_PATH="$HADOOP_HOME/lib/native/:$LD_LIBRARY_PATH"
export HADOOP_CLASSPATH=${JAVA_HOME}/lib/tools.jar

# variables hadoop prueba

export HADOOP_MAPRED_HOME=${HADOOP_HOME}
export HADOOP_COMMON_HOME=${HADOOP_HOME}
export HADOOP_HDFS_HOME=${HADOOP_HOME}
export YARN_HOME=${HADOOP_HOME}
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native

# variables spark

export SPARK_HOME=/opt/spark-3.0.2-bin-hadoop3.2
export PATH=$PATH:$SPARK_HOME/bin
export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
export PYSPARK_PYTHON=python3
export PYTHONPATH=$SPARK_HOME/python:$PYTHONPATH
export PYSPARK_DRIVER_PYTHON="jupyter"
export PYSPARK_DRIVER_PYTHON_OPTS="notebook --ip 192.168.0.201 --port 8888"
export PATH=$SPARK_HOME:$PATH:~/.local/bin:$JAVA_HOME/bin:$JAVA_HOME/jre/bin


function otrasraspberry {
        grep "nodo" /etc/hosts | awk '{print $2}' | grep -v $(hostname)
}
function clustercmd {
        for pi in $(otrasraspberry); do ssh $pi "$@"; done
        $@
}
function clusterreboot {
        stop-yarn.sh && stop-dfs.sh && \
        clustercmd sudo shutdown -r now
}
function clustershutdown {
        stop-yarn.sh && stop-dfs.sh && \
        clustercmd sudo shutdown now
}

function clusterscp {
        for pi in $(otrasraspberry); do
        cat $1 | ssh $pi "sudo tee $1" > /dev/null 2>&1
        done
}

function clustertemperature {
        clustercmd /usr/bin/landscape-sysinfo | grep "Temperature"
}

