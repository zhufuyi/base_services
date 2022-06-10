#!/bin/bash


# -------------------------------- 参数判断 --------------------------------------------
params=$@

if [ $# -lt 1 ]; then
    echo "param is empty"
    echo "usage: $0 [domain ...] | [ip ...]"
    echo "eg: $0 zhuyasen.com 192.168.3.100"
    echo ""
    exit
fi

# 用参数替换req-csr.json固定字段值domains_or_ips
hostFields=''
for ip in $params; do
    hostFields=${hostFields}\\\"$ip\\\",
done
# 去掉最后一个逗号
hostFields=${hostFields%?}


# ---------------------------------- 创建认证中心(CA) ----------------------------------

# 创建存储证书目录和配置目录
mkdir -p certs
cd certs
mkdir -p config

# 创建根CA证书和私钥的CSR(证书签名请求文件)配置文件ca-csr.json
cat > config/ca-csr.json <<EOF
{
    "CN": "myMechanism",
    "key": {
        "algo": "rsa",
        "size": 2048
    },
    "names": [
        {
            "C": "CN",
            "ST": "Beijing",
            "L": "Beijing",
            "O": "my organization",
            "OU": "my organization unit name"
        }
    ]
}
EOF

# 生成CA证书和私钥，先判断ca-key.pem是否存在，如果存在则使用已存在的
if [[ ! -f "ca-key.pem" ]]; then
  echo "generate new ca.pem and ca-key.pem"
  cfssl gencert -initca config/ca-csr.json | cfssljson -bare ca -
else
  echo "use existing ca-key.pem."
fi


# ---------------------------------- 派发证书  ----------------------------------

# 创建证书签名请求配置文件req-csr.json，这里填写申请组织信息、ip或域名
cat > config/req-csr.json <<EOF
{
    "CN": "your-test-domain.com",
    "hosts": [
        "localhost",
        "127.0.0.1",
        "domains_or_ips"
    ],
    "key": {
        "algo": "rsa",
        "size": 2048
    },
    "names": [
        {
            "C": "CN",
            "ST": "GuangDong",
            "L": "GuangZhou",
            "O": "communication",
            "OU": "cluster"
        }
    ]
}
EOF


# 配置证书生成策略，让CA知道颁发什么样的证书。
cat > config/ca-config.json <<EOF
{
    "signing":{
        "default":{
            "expiry":"87600h"
        },
        "profiles":{
            "peer":{
                "expiry":"8760h",
                "usages":[
                    "signing",
                    "key encipherment",
                    "server auth",
                    "client auth"
                ]
            }
        }
    }
}
EOF


tagName='\"domains_or_ips\"'
# 把domains_or_ips替换为输入的参数
sed -i "s/$tagName/$hostFields/g" config/req-csr.json

# 使用现有证书和私钥重新颁发新的证书，类型为服务端使用
for name in $params; do
  cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=config/ca-config.json -profile=peer config/req-csr.json | cfssljson -bare $name
  cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=config/ca-config.json -profile=peer config/req-csr.json | cfssljson -bare peer-$name
done

# 删除多余文件
ls | grep -v pem | xargs -i rm -rf {}

