# Cluster-Raspberry-SS

Configuración inicial para Hadoop en una raspberry Pi 4 con Ubuntu server 

1. se cambiara el nombre del hostname para poder reconocerlos

```
hostnamectl set-hostname nodo1
```

2. Creamos el grupo hadoop y creamos el usuario hadoop

```
sudo addgroup hadoop
sudo adduser --ingroup hadoop hadoop
```

3. agregar el usuario al grupo sudo:

```
sudo usermod -aG sudo hadoop
```


4. configuramos zona horaria
```
sudo tzselect
```

5. instalar jdk 8
```
sudo apt-get install openjdk-8-jdk
```
6. instalar jupyter
```
 sudo apt-get install jupyter
```
7. bajar frameworks
```
## bajar hadoop

wget https://downloads.apache.org/hadoop/common/hadoop-3.3.0/hadoop-3.3.0.tar.gz

#bajar spark

wget https://downloads.apache.org/spark/spark-3.0.2/spark-3.0.2-bin-hadoop3.2.tgz

## bajar hive 

wget https://downloads.apache.org/hive/hive-3.1.2/apache-hive-3.1.2-src.tar.gz

## bajar sqoop

wget https://downloads.apache.org/sqoop/1.99.7/sqoop-1.99.7.tar.gz

## bajar ambari 

wget https://downloads.apache.org/ambari/ambari-2.7.5/apache-ambari-2.7.5-src.tar.gz

## bajar flume

wget https://downloads.apache.org/flume/1.9.0/apache-flume-1.9.0-src.tar.gz
```

8. descomprimir y mandar al directorio /opt como root

```
tar xvf hadoop-3.3.0.tar.gz -C /opt
tar xvf spark-3.0.2-bin-hadoop3.2.tgz -C /opt
tar xvf apache-hive-3.1.2-src.tar.gz -C /opt
tar xvf hsqoop-1.99.7.tar.gz -C /opt
tar xvf apache-ambari-2.7.5-src.tar.gz -C /opt
tar xvf apache-flume-1.9.0-src.tar.gz -C /opt
```

9. buscar el directorio de instalación Java JDK.
```
update-alternatives --config java
```

10. agregar las variables al final de archivo [.bashrc](.bashrc)

11. cargar las nuevas variables 
```
. ./.bashrc
```
12. modificar los archivos de configuración
    - archivos de configuración Hadoop ubicados en /opt/hadoop-3.3.0/etc/hadoop/
      - archivo [hadoop-env.sh](Hadoop/hadoop-env.sh) 
      ```
      nano /opt/hadoop-3.3.0/etc/hadoop/hadoop-env.sh
      ```
      - archivo [core-site.xml](Hadoop/core-site.xml) 
      ```
      nano /opt/hadoop-3.3.0/etc/hadoop/core-site.xml
      ```
      - archivo [hdfs-site.xml](Hadoop/hdfs-site.xml) 
      ```
      nano /opt/hadoop-3.3.0/etc/hadoop/hdfs-site.xml
      ```
      - archivo [mapred-site.xml](Hadoop/mapred-site.xml) 
      ```
      nano /opt/hadoop-3.3.0/etc/hadoop/mapred-site.xml
      ```
      - archivo [yarn-site.xml](Hadoop/yarn-site.xml) 
      ```
      nano /opt/hadoop-3.3.0/etc/hadoop/yarn-site.xml
      ```
      - archivo [master](Hadoop/master) 
      ```
      nano /opt/hadoop-3.3.0/etc/hadoop/master
      ```
      - archivo [worjers](Hadoop/workers) 
      ```
      nano /opt/hadoop-3.3.0/etc/hadoop/workers
      ```
    - archivos de configuración spark ubicados en /opt/spark-3.0.2-bin-hadoop3.2/conf/
      - archivo [spark-env.sh](Spark/spark-env.sh)  
      ```
      nano  /opt/spark-3.0.2-bin-hadoop3.2/conf/spark-env.sh 
      ```
      - archivo [spark-defaults.conf](Spark/spark-defaults.conf) 
      ```
      nano  /opt/spark-3.0.2-bin-hadoop3.2/conf/spark-defaults.conf 
      ```
      - archivo [slaves](Spark/slaves)   
      ```
      nano  /opt/spark-3.0.2-bin-hadoop3.2/conf/slaves 
      ```
13. montar la carpeta /opt en un ssd(opcional) 
    - formatear ssd 
    ```
    mkfs.ext4 /dev/sda
    ```
    - modificar el archivo /fstab para que cada que se reinicie el SO el ssd siga montado
    ```
    sudo nano /etc/fstab
    ```
    - y agregar lo siguiente:
    ```
    /dev/sda1       /opt/workspace  ext4    defaults        0       0
    ```
    - montar ssd
    ```
    sudo mount -a
    ```

14. crear los directorios donde se guardara la informacion del namenode y datanode, la asignacion de estas carpetas esta en el archivo [hdfs-site.xml](Hadoop/hdfs-site.xml)
```
mkdir -p /opt/workspace/hdfs/namenode/ 
mkdir -p /opt/workspace/hdfs/datanode/
```
15. cambiar permisos para que sean de hadoop

```
sudo chown -R hadoop:hadoop /opt/*
```

16. formatear el espacio del namenode
```
hdfs namenode -format -force
```
17. Levantar el cluster
```
start-dfs.sh && start-yarn.sh
start-master.sh && start-slaves.sh
```
18. para ver los servicios de cada nodo usamos el siguiente comando
```
jps
```
19. Por ultimo empezaremos a trabajar con pyspark, el siguiente comando nos dara como resultado una dirreccion con la cual podemos trabajar con jupyter
```
pyspark
```
