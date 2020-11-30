
import time
import os

for run in range(10):
    cmd = """/opt/hadoop-3.3.0/bin/hadoop jar /opt/hadoop-3.3.0/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.0.jar terasort -Dmapred.reduce.tasks=15 -Dmapreduce.map.java.opts="-Xshare:on -XX:+UseAppCDS -XX:SharedArchiveFile=/opt/terasort.jsa" -Dmapreduce.reduce.java.opts="-Xshare:on -XX:+UseAppCDS -XX:SharedArchiveFile=/opt/terasort.jsa" terasort/tera-input terasort/tera-output-%s""" %run
    time_start=time.time()
    os.system(cmd + ' 2>&1 | tee cds-logs/run-%s.log' %run)
    time_end=time.time()
    time_cost = time_end - time_start
    running_time = open("/opt/logs/running_times.txt", "a")
    running_time.writelines("run %s:" %run)
    running_time.writelines(str(time_cost) + ' s\n')
    running_time.close()
    cleanup_cmd = "/opt/hadoop-3.3.0/bin/hdfs dfs -rm -r terasort/tera-output-*"
    os.system(cleanup_cmd)


for run in range(10):
    cmd = """/opt/hadoop-3.3.0/bin/hadoop jar /opt/hadoop-3.3.0/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.0.jar terasort -Dmapred.reduce.tasks=15 terasort/tera-input terasort/tera-output-%s""" %run
    time_start=time.time()
    os.system(cmd + ' 2>&1 | tee nocds-logs/run-%s.log' %run)
    time_end=time.time()
    time_cost = time_end - time_start
    running_time = open("/opt/logs/running_times.txt", "a")
    running_time.writelines("run %s:" %run)
    running_time.writelines(str(time_cost) + ' s\n')
    running_time.close()
    cleanup_cmd = "/opt/hadoop-3.3.0/bin/hdfs dfs -rm -r terasort/tera-output-*"
    os.system(cleanup_cmd)
