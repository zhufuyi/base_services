# base_services

some of the base services used for development, these services run in docker.

## Install

### Install docker

**Install docker in `centos`**

```bash
yum install -y yum-utils device-mapper-persistent-data lvm2

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

yum install -y docker-ce  docker-ce-cli containerd.io

systemctl enable docker

systemctl start docker

docker info
```

<br>

**Install docker in `ubuntu`**

```bash
curl -fsSL https://mirrors.ustc.edu.cn/docker-ce/linux/debian/gpg | apt-key add -

echo 'deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/debian buster stable' | tee /etc/apt/sources.list.d/docker.list

apt update && apt install docker-ce -y

systemctl enable docker

systemctl start docker

docker info
```

<br>

### Install docker-compos

```bash
curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

curl -L https://raw.githubusercontent.com/docker/compose/1.25.0/contrib/completion/bash/docker-compose -o /usr/share/bash-completion/completions/docker-compose

source /usr/share/bash-completion/completions/docker-compose
```

<br>

### List of services

- [consul](consul)
- [crawlab](crawlab)
- [etcd](etcd)
  - [etcd standalone](etcd/etcd-standalone)
  - [etcd clusters in one host](etcd/etcd-cluster-in-one-host)
  - [etcd cluster in 3 hosts](etcd/etcd-cluster-in-3-hosts)
- [jaeger](jaeger)
- [logging](logging)
  - [elasticsearch kibana standalone](logging/EK/elasticsearch-standalone)
  - [elasticsearch kibana cluster](logging/EK/elasticsearch-cluster)
  - [elasticsearch fluentbit redis logstash kibana standalone](logging/fluentbit-redis-logstash-es)
- [loki](loki)
- [milvus](milvus)
  - [milvus standalone](milvus/milvus-standalone)
  - [bert server](milvus/bert)
- [mongodb](mongodb)
- [monitor](monitor)
  - [prometheus](monitor/prometheus)
  - [grafana](monitor/grafana)
  - [exporter](monitor/exporter)
  - [thanos](monitor/thanos)
- [mysql](mysql)
  - [mysql5.7](mysql/mysql5.7)
  - [mysql8.0](mysql/mysql8.0)
  - [mysql8.0-ssl](mysql/mysql8.0-ssl)
- [nats](nats)
  - [nats stand-alone](nats/nats-no-persistence/nats-standalone)
  - [nats cluster](nats/nats-no-persistence/nats-cluster)
  - [nats streaming file standalone](nats/nats-persistence/nats-streaming-file-standalone)
  - [nats streaming file cluster](nats/nats-persistence/nats-streaming-file-cluster)
  - [nats streaming mysql standalone](nats/nats-persistence/nats-streaming-mysql-standalone)
- [rabbitmq](rabbitmq)
  - [rabbitmq standalone](rabbitmq/rabbitmq-standalone)
  - [rabbitmq cluster](rabbitmq/rabbitmq-cluster)
- [redis](redis)
  - [redis standalone](redis/redis-standalone)
  - [redis cluster](redis/redis-cluster-sentinel)
- [sqlpad](sqlpad)
- [syslog-ng](syslog-ng)
- [yapi](yapi)
