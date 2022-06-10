### 说明

这是使用file持久化的nats streaming集群，这个集群运行在同一个宿主机。

### 启动

> docker-compose up -d

<br>

遇到问题：

问题描述：当使用docker-compose down彻底删除集群后，必须把映射本地目录的文件夹(持久化文件)删除才能重新启动。

原因：容器重新启动后，服务器恢复了streaming状态(如指向-dir并位于已安装的卷中)，但是没有恢复RAFT特定状态，该状态默认存储在以您的集群ID命名的目录中，相对于当前目录启动可执行文件。在容器的上下文中，此数据将在容器停止后丢失。

解决办法：恢复streaming状态同时也要恢复RAFT状态(通过日志恢复)，在启动命令行添加启动参数--cluster_log_path /clusterLog，然后把/clusterLog目录映射到本地目录进行持久化，
