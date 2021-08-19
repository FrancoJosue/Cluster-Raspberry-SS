# Cluster-Raspberry-SS
Configuración para un cluster conformado por 3 nodos
## Configuración inicial de ubuntu

Configuración para Hadoop y Spark en una raspberry Pi 4 con Ubuntu Server
1. se cambiara el nombre del hostname para poder reconocer los nodos

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
## Configuración de red
5. para la configuración de red modificaremos el archivo [50-cloud-init.yaml](50-cloud-init.yaml) ubicado en /etc/netplan/ , para asignar una ip estatica
```
sudo nano /etc/netplan/50-cloud-init.yaml

```

6. aplicar la configuración de netplan
```
sudo netplan apply
```
Ejemplos y explicacion de [netplan](https://netplan.io/examples/)

## Configuración SSH
7. configuracióna de Hostnames,agregar los nodos en el archivo [hosts](hosts) ubidado en /etc/ 
```
nano /etc/hosts
```
8. coneccion SSH sin usuario y contraseña
   - generar llave publica
   ```
   ssh-keygen
   ```
   
   - SSH Aliases [config](config)
   ```
   sudo nano .shh/config
   ```
   - llaves autorizadas
   La llave publica es generada en/home/hadoop/.ssh/id_rsa.pub Esa llave la copiaremos en cada Raspberry en el archivo /home/hadoop/.ssh/authorizedkeys
   
   
   ejemplo: 
   
   
   ssh-rsa asdsadasdasdasdasdasdasd= hadoop@nodo1
   
   
   ssh-rsa asdsadasdasdasdasdasdasd= hadoop@nodo2
   
   
   ssh-rsa asdsadasdasdasdasdasdasd= hadoop@nodo3
   
   
   
   ```
   sudo nano .ssh/authorizedkeys
   ```
## Instalación 
9. instalar jdk 8
```
sudo apt-get install openjdk-8-jdk
```
10. instalar jupyter
```
 sudo apt-get install jupyter
```
11. bajar frameworks
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

12. descomprimir y mandar al directorio /opt como root

```
sudo tar xvf hadoop-3.3.0.tar.gz -C /opt
sudo tar xvf spark-3.0.2-bin-hadoop3.2.tgz -C /opt
sudo tar xvf apache-hive-3.1.2-src.tar.gz -C /opt
sudo tar xvf hsqoop-1.99.7.tar.gz -C /opt
sudo tar xvf apache-ambari-2.7.5-src.tar.gz -C /opt
sudo tar xvf apache-flume-1.9.0-src.tar.gz -C /opt
```

13. buscar el directorio de instalación Java JDK.
```
update-alternatives --config java
```

14. agregar las variables al final de archivo [.bashrc](.bashrc)
```
sudo nano .bashrc
```


15. cargar las nuevas variables 
```
. ./.bashrc
```
## Configuración Hadoop y Spark
16. modificar los archivos de configuración
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
17. montar la carpeta /opt en un ssd(opcional) 
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

18. crear los directorios donde se guardara la informacion del namenode y datanode, la asignacion de estas carpetas esta en el archivo [hdfs-site.xml](Hadoop/hdfs-site.xml)
```
mkdir -p /opt/workspace/hdfs/namenode/ 
mkdir -p /opt/workspace/hdfs/datanode/
```
19. cambiar permisos para que sean de hadoop

```
sudo chown -R hadoop:hadoop /opt/*
```
## Despliegue

20. formatear el espacio del namenode
```
hdfs namenode -format -force
```
21. Levantar el cluster
```
start-dfs.sh && start-yarn.sh
start-master.sh && start-slaves.sh
```
22. para ver los servicios de cada nodo usamos el siguiente comando
```
jps
```
23. Por ultimo empezaremos a trabajar con pyspark, el siguiente comando nos dara como resultado una dirreccion con la cual podemos trabajar con jupyter
```
pyspark
```
