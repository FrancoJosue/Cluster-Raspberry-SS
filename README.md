# Cluster-Raspberry-SS

## se cambiara el nombre del hostname para poder reconocerlos

hostnamectl set-hostname nodo1

# Creamos el grupo hadoop y creamos el usuario hadoop

sudo addgroup hadoop
sudo adduser --ingroup hadoop hadoop

## agregar el usuario al grupo sudo:

sudo usermod -aG sudo hadoop

## eliminamos el usuario ubuntu, que es el que trae por defecto esta distribucion.
sudo userdel -rf 

## copnfiguramos zona horaria

sudo tzselect


# instalar jdk 11

sudo apt-get install openjdk-11-jdk

# bajar hadoop

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

# descomprimir y mandar a un directorio como root


tar xvf hadoop-3.3.0.tar.gz -C /opt
tar xvf spark-3.0.2-bin-hadoop3.2.tgz -C /opt
tar xvf apache-hive-3.1.2-src.tar.gz -C /opt
tar xvf hsqoop-1.99.7.tar.gz -C /opt
tar xvf apache-ambari-2.7.5-src.tar.gz -C /opt
tar xvf apache-flume-1.9.0-src.tar.gz -C /opt




# cambiar  permisos para que sean de hadoop


sudo chown -R hadoop:hadoop /opt/hadoop-3.3.0/
# buscar el directorio de instalación Java JDK.

update-alternatives --config java

# agregar los export al final usando como usuario hadoop

nano .bashrc 






