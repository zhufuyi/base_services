## 在docker安装哨兵(sentinel)主从集群

### (1) 启动redis集群

切换到redis-cluster目录下，启动redis集群

> docker-compose up -d

登录master容器查看集群是否正常

```bash
# 登录master
docker exec -it redis-master redis-cli -a 123456

# 执行命令查看集群信息
info replication
```

<br>

### (2) 启动sentinel

获取master的ip地址，这个ip地址用来给哨兵配置时使用。

```bash
docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq) | grep  master

# 示例
# /redis-master - 172.18.0.3
```

在sentinel目录下创建sentinel配置文件sentinel1.conf、sentinel2.conf、sentinel3.conf，三个配置都一样，内容如下：

```
port 26379
dir /tmp
sentinel monitor mymaster 172.18.0.3 6379 2
sentinel auth-pass mymaster 123456
sentinel down-after-milliseconds mymaster 30000
sentinel parallel-syncs mymaster 1
sentinel failover-timeout mymaster 180000
sentinel deny-scripts-reconfig yes
```

修改权限和所属用户
```bash
chomd 0666 sentinel1.conf  sentinel2.conf  sentinel3.conf
chown 999 sentinel1.conf  sentinel2.conf  sentinel3.conf
```

</br>

切换到redis-sentinel目录下，启动sentinel

> docker-compose up -d

获取sentinel的ip地址。

```bash
docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq) | grep  master

# 示例
# /redis-sentinel-2 - 172.18.0.5
# /redis-sentinel-3 - 172.18.0.6
# /redis-sentinel-1 - 172.18.0.7
```

检查sentinel是否正常连接master和slave

```bash
# 登录master或slave
docker exec -it redis-master redis-cli -a 123456

# 执行monitor命令查看是否各个哨兵有订阅__sentinel__:hello
monitor
```
