
## 部署只有3个节点的etcd集群

准备3个节点ip地址分别是 你的ip1、你的ip2、你的ip3，分别把etcd1目录、etcd2目录、etcd3目录复制到对于主机上。

```bash
# 生成证书
./gen-peer-cert.sh 你的ip1 你的ip2 你的ip3


# 复制证书到每个节点文件夹下
cp -r certs etcd1
cp -r certs etcd2
cp -r certs etcd3

# 分别把etcd1、etcd2、etcd3文件夹复制到对应节点，然后统一替换每个节点ip地址，例如用vim打开docker-compose.yml，然后替换ip，每个节点都要执行3次替换
%s/192.168.3.101/你的ip1/g
%s/192.168.3.102/你的ip2/g
%s/192.168.3.103/你的ip3/g

# 在每个节点启动etcd
docker-compose up -d

# 3个节点都启动完成后，查看成员列表
export ENDPOINTS=你的ip1:2379,你的ip2:2379,你的ip3:2379

etcdctl --endpoints=$ENDPOINTS \
--cacert=ca.crt \
--cert=你的ip1.pem \
--key=你的ip1-key.pem \
member list
```
