### 启动kafka集群

1. 第一次使用时，创建一个data文件夹作为数据持久化，并且修改目录data权限，

```bash
mkdir data/kafka-1 data/kafka-2 data/kafka-3
chmod -R 0777 data
```

2. 启动前，打开`.env`文件，修改ACCESS_ADDR，ip是宿主机地址，端口为kafka服务监听端口，


3. 启动服务

> docker-compose up -d

启动服务

> docker-compose up -d

打开kafka ui界面 `http://192.168.3.37:18080` 可以查看topic的所有信息。

<br>

### 测试

创建主题：foobar

> docker exec -it kafka-1 kafka-topics.sh --create --bootstrap-server localhost:9092 --topic foobar

发送消息到主题foobar

> docker exec -it kafka-1 kafka-console-producer.sh --bootstrap-server localhost:9092 --topic foobar

在另一个终端执行命令订阅主题接收消息

> docker exec -it kafka-1 kafka-console-consumer.sh --from-beginning --bootstrap-server localhost:9092 --topic foobar


