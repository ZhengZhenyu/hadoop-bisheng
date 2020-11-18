wget https://mirrors.huaweicloud.com/kunpeng/archive/compiler/bisheng_jdk/bisheng-jdk-8u262-linux-aarch64.tar.gz
tar zxvf bisheng-jdk-8u262-linux-aarch64.tar.gz
 
wget https://mirror.bit.edu.cn/apache/hadoop/common/hadoop-3.3.0/hadoop-3.3.0-aarch64.tar.gz
tar zxvf hadoop-3.3.0-aarch64.tar.gz

export JAVA_HOME=/opt/bisheng-jdk1.8.0_262/bin/
echo "export JAVA_HOME=/opt/bisheng-jdk1.8.0_262/" >> etc/hadoop/hadoop-env.sh

HDFS_DATANODE_USER=root
HADOOP_SECURE_DN_USER=hdfs
HDFS_NAMENODE_USER=root
HDFS_SECONDARYNAMENODE_USER=root

YARN_RESOURCEMANAGER_USER=root
HADOOP_SECURE_DN_USER=yarn
YARN_NODEMANAGER_USER=root


rows=$((5*1024*1024*1024/100))

bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.0.jar teragen -Dmapred.map.tasks=100 -Dmapreduce.map.java.opts="-Xshare:off -XX:+UseAppCDS -XX:DumpLoadedClassList=/opt/terasort.lst" ${rows} terasort/tera1-input

bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.0.jar teragen -Dmapred.map.tasks=100 -Dmapreduce.map.java.opts="-Xshare:dump -XX:+UseAppCDS -XX:SharedClassListFile=/opt/terasort.lst -XX:SharedArchiveFile=/opt/terasort.jsa -XX:SharedReadWriteSize=20000000" ${rows} terasort/tera2-input

bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.0.jar teragen -Dmapred.map.tasks=100 -Dmapreduce.map.java.opts="-Xshare:on -XX:+UseAppCDS -XX:SharedArchiveFile=/opt/terasort.jsa" ${rows} terasort/tera5-input

bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.0.jar terasort -Dmapred.reduce.tasks=7 -Dmapreduce.map.java.opts="-Xshare:on -XX:+UseAppCDS -XX:SharedArchiveFile=/opt/terasort.jsa" -Dmapreduce.reduce.java.opts="-Xshare:on -XX:+UseAppCDS -XX:SharedArchiveFile=/opt/terasort.jsa" terasort/tera-input terasort/tera-output
