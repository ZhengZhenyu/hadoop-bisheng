wget https://mirrors.huaweicloud.com/kunpeng/archive/compiler/bisheng_jdk/bisheng-jdk-8u262-linux-aarch64.tar.gz
tar zxvf bisheng-jdk-8u262-linux-aarch64.tar.gz
 

export JAVA_HOME=/opt/bisheng-jdk1.8.0_262/bin/
echo "export JAVA_HOME=/opt/bisheng-jdk1.8.0_262/bin/" >> etc/hadoop/hadoop-env.sh

HDFS_DATANODE_USER=root
HADOOP_SECURE_DN_USER=hdfs
HDFS_NAMENODE_USER=root
HDFS_SECONDARYNAMENODE_USER=root

YARN_RESOURCEMANAGER_USER=root
HADOOP_SECURE_DN_USER=yarn
YARN_NODEMANAGER_USER=root
