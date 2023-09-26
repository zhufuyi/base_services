
### 设置主从mysql

#### 主库设置

进入主mysql终端

```bash
docker exec -it mysql-master bash
mysql -u root -p
```

设置master

```bash
# 创建用户
CREATE USER 'slave'@'%' IDENTIFIED BY '123456';
GRANT REPLICATION SLAVE ON *.* TO 'slave'@'%';

# 刷新权限
FLUSH PRIVILEGES;

# 获取相关信息，在从库中MASTER_LOG_FILE和MASTER_LOG_POS
show master status;
```

<br>

#### 从库

进入从mysql终端

```bash
docker exec -it mysql-slave1 bash
mysql -u root -p
```

设置从mysql

```bash
# 在从上设置主库配置信息
CHANGE MASTER TO
master_host='mysql-master',
master_port=3306,
MASTER_USER='slave',
MASTER_PASSWORD='123456',
MASTER_LOG_FILE='mysql-bin.000003',
MASTER_LOG_POS=827;

# 启动从服务器
start slave;

# 查看配置状态 slave_IO_runring和slave_slq_runring
show slave status\G
```

<br>

#### 查看binlog日志

在mysql主库和从库都可以查看

```bash
# 查看日志文件名
show master logs;

# 查看日志内容
show binlog events in 'mysql-bin.000003';
show binlog events in 'mysql-slave1-bin.000003';
```


<br>

#### 异常解决

- 从数据库异常
  - 确认是io线程问题
  - sql线程问题： 根据日志来恢复数据
- 主数据库异常
  - 查看相关从数据库日志时间， 谁近就把谁升级为主库

在从mysql数据库执行

```bash
# 查看配置状态，查看 Last_SQL_Errno，Last_SQL_Error
show slave status\G

# 查看日志文件
show binlog events;
```

<br>

#### 恢复同步

在从mysql数据库执行

```bash
stop slave;
# 跳过一个事务，可选
SET GLOBAL SQL_SLAVE_SKIP_COUNTER = 1;
start slave;
```

<br>

在从mysql创建一个用户，因为配置了只读，因此读数据不支持写

```bash
CREATE USER 'iuser'@'%' IDENTIFIED WITH mysql_native_password BY '123456';
GRANT ALL ON account.* TO 'iuser'@'%';
FLUSH PRIVILEGES;
```

<br>

### 启动mysql

> docker-compose up -d



