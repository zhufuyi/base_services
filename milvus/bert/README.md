## bert server

通过bert服务可以把文本转为特征向量值，bert-server提供了http和tcp两种请求方式。

<br>

### 在python环境使用


安装bert-serving-client包 

> pip install -U bert-serving-client


调用bert-serving服务接口生成向量值

```python
from bert_serving.client import BertClient
bc = BertClient(ip='192.168.3.36',port=5555)
bc.encode(['5G技术'])
```

<br>

### 通过api接口方式

获取文本特征向量值示例：

> curl -X POST http://localhost:8125/encode -H 'content-type: application/json' -d '{"id": 123,"texts": ["正方形","长方形"], "is_tokenized": false}'

`id`是帮助您同步结果的唯一标识符；`is_tokenized`遵循BertClient API，默认为`false`。

返回json结果：

```json
{
    "id": 123,
    "results": [[768 float-list], [768 float-list]],
    "status": 200
}
```

<br>

### 基于tensorflow制作bert-server镜像

```bash
# 启动 tensorflow
docker run -it -d --name=tensorflow tensorflow/tensorflow:1.15.5 bash

# 下载简体中文字库https://storage.googleapis.com/bert_models/2018_11_03/chinese_L-12_H-768_A-12.zip，并解压出目录chinese_L-12_H-768_A-12

# 复制文件chinese_L-12_H-768_A-12目录进入容器
docker cp chinese_L-12_H-768_A-12 tensorflow:/tmp/

# 进入容器
docker exec -it tensorflow bash

# 移动chinese_L-12_H-768_A-12到工作目录app下
mkdir -p /app
mv /tmp/chinese_L-12_H-768_A-12 /app/

# 安装 bert-serving和一些依赖，如果下载缓慢可以使用代理
pip install -U bert-serving-server bert-serving-client
pip install flask flask-compress flask-cors flask-json --user

# 检查bert-serving是否可以正常启动
bert-serving-start -model_dir=/app/chinese_L-12_H-768_A-12 -max_seq_len=100 -num_worker=2 -http_port 8125
# 如果出现all set, ready to serve request!，说明可以正常启动，退出bert-serving服务。

# 构建生成新镜像
docker commit -a 'zhuyasen' -m 'bert-server' tensorflow zhuyasen/bert-server:1.15 
```

<br>
