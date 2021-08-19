# Cluster-Raspberry-SS

Configuracion inicial para Hadoop en una raspberry Pi 4 con Ubuntu server 

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


4. copnfiguramos zona horaria
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



9. cambiar  permisos para que sean de hadoop

```
sudo chown -R hadoop:hadoop /opt/*
```

10. buscar el directorio de instalación Java JDK.
```
update-alternatives --config java
```

11. agregar las variables al final de archivo [.bashrc](.bashrc)

12 Cargar las nuevas variables 
```
. ./.bashrc
```
13. agregar un export al archivo (/Hadoop/hadoop-env.sh) ubicado en /opt/hadoop-3.3.0/etc/hadoop/
```
nano /opt/hadoop-3.3.0/etc/hadoop/hadoop-env.sh
```

