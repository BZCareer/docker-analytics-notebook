Apache Spark And Zeppelin Notebook On Docker
==========

In this repository you will find a docker file which will allow for running Apache Spark and Zeppelin inside docker containers or inside kubernetes.


## Screencast ( Demo on Kubernetes/Openshift Origin v3 )

![alt tag](https://media.githubusercontent.com/media/BZCareer/docker-analytics-notebook/master/Screencast-SparkNotebook-3.gif)

##Pull the image from Docker Repository
```
docker pull  bzcareer/docker-analytics-notebook
```

## Building the image
Navigate to the bin directory and run
```
cd bin
./make-all.sh
```

or via docker commands:

```
docker build --rm -t bzcareer/docker-analytics-notebook .
```
## Environment Variables

N/A

## Running the image in docker standalone

* if using boot2docker make sure your VM has more than 2GB memory
for single standalone mode:
```
 docker run   -it -p 8080:8080 -p 9999:9999 -p 7077:7077  --hostname  spark-notebook.hadoopdata.com   bzcareer/docker-analytics-notebook

```


## Running on Kubernetes or OpenShift Origin V3

To speed things up a bit pull down the docker image from dockerhub:
```
[ zak@localhost ] $ vagrant up
[ zak@localhost ] $ vagrant ssh default
```
Once your in the vm:
```
[ vagrant@localhost] oc login
                     username: admin
                    password: password
```

```
[ vagrant@localhost] $ oc new-project cloudanalytics
Now using project "cloudcassandra" on server "https://10.2.2.2:8443".
...
[ vagrant@localhost] $ docker pull bzcareer/docker-analytics-notebook
[ vagrant@localhost] $ git clone https://github.com/BZCareer/docker-analytics-notebook.git
[ vagrant@localhost] $ cd  docker-analytics-notebook/kubernetes-demo/
[ vagrant@localhost] $ oc create -f zeppelin-spark-notebook.pod.json
[ vagrant@localhost] $ oc create -f zeppelin-spark-notebook.service.json
```


## This Example Should Not Be Used In Production

This is just an experiment so I hope you do not use in production.

## Versions
```
Apache Spark v1.6.1 and Apache Zeppelin v0.6.0  on Ubuntu with Java 8
```
