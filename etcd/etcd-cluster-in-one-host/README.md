
执行脚本`gen-peer-serts.sh` 生成证书，参数为各个节点容器名称，在当前certs目录下。

> ./gen-peer-certs.sh etcd1 etcd2 etcd3

注：如果是在本地一台主机使用docker搭建的需要tls鉴权认证的etcd集群，局域网内其他主机想要通过tls鉴权访问集群，必须把etcd集群所在主机的ip地址填写到req-csr.json配置文件的hosts字段下，否则会报错authentication handshake failed: x509: certificate is valid for 127.0.0.1, not 192.168.3.5(集群所在主机的ip地址)
