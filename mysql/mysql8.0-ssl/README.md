

```bash
# 开启ssl连接授权，在配置文件[mysqld]下添加 require_secure_transport = ON
ALTER USER 'cbmain'@'%' REQUIRE SSL;
FLUSH PRIVILEGES;

# 如果需要使用x509认证，对某个用户进行设置
create user 'vison'@'%' identified by '123456' require X509;
grant all privileges on *.* to 'vison'@'%';
FLUSH PRIVILEGES;
```
