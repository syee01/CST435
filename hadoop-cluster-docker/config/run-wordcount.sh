#!/bin/bash

hdfs dfs -rm -r output

# create input files 
mkdir input
echo "Cloud computing is usually associated with a set of applications and tools, used by companies to conduct their businesses. However, the possibilities offered by the cloud, and its versatility, causes that its tools and applications can also be used in education. There are several articles and papers presenting the advantages offered by the implementation and use of the cloud by the universities, but none of these studies have raised the issue of using the cloud by students, who are the backbone of any university. Therefore, the aim of this article is to present, not only the possibilities offered by the cloud in education, but also how cloud computing is perceived by students, and whether they consider introducing cloud computer at universities." >input/file2.txt
echo "Cloud computing has evolved from the earlier technology called grid computing, but has reached the stage of commercialization recently. Cloud computing has raised from a large growth of the Internet and the increasing number of e-commerce transactions, carried out all around the world. This caused, that large technology companies have created huge data centers, to handle with the growing movement taking place all over the Internet. Cloud computing has enabled companies to provide Internet service without the need to purchase additional hardware, also helped to reduce costs, including incurred in connection with the work, they had done at the customer service staff." >input/file1.txt

# create input directory on HDFS
hadoop fs -mkdir -p input

# put input files to HDFS
hdfs dfs -put -f ./input/* input

# Record start time
start_time=$(($(date +%s%N)/1000000))

# run wordcount 
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/sources/hadoop-mapreduce-examples-2.7.2-sources.jar org.apache.hadoop.examples.WordCount input output

# print the input files
echo -e "\ninput file1.txt:"
hdfs dfs -cat input/file1.txt

echo -e "\ninput file2.txt:"
hdfs dfs -cat input/file2.txt

# print the output of wordcount
echo -e "\nwordcount output:"
hdfs dfs -cat output/part-r-00000

# Record end time
end_time=$(($(date +%s%N)/1000000))

duration=$((end_time - start_time))
echo -e "\nScript started at: $(date -d @$((start_time/1000)))" # Convert start time back to seconds for human-readable format
echo -e "Script ended at: $(date -d @$((end_time/1000)))" # Convert end time back to seconds for human-readable format
echo -e "Total duration: $duration milliseconds"