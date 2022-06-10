打开.env环境变量，修改elasticsearch密码和kibana密码，注：kibana密码如果为纯数字，需要用双引号，否则是被为数字报错

```bash
vim .env
```

<br>


启动：

> docker-compose up -d

<br>

查看集群

```bash
curl -k --insecure https://elastic:123456@localhost:9200/_cat/nodes?pretty

// 或
curl -k --insecure -u elastic:123456 https://localhost:9200/_cat/nodes?pretty
```

<br>

在浏览器打开 `http://ip:5601`，然后登录，用户名:elastic，密码在环境变量:123456

如果想查看日志，选择Discover功能，过滤搜索日志

<br>

如果有需要可以复制证书到本地。

```bash
docker cp es-setup:/usr/share/elasticsearch/config/certs/ca.zip . 
docker cp es-setup:/usr/share/elasticsearch/config/certs/certs.zip .  
```

<br>

refer:

- https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#docker-file
- https://www.elastic.co/guide/cn/kibana/current/settings.html

