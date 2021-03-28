介绍：

除 v2ray（Xray） kcp 外，所用应用共用443端口。此端口由 nginx 监听（即 nginx 前置），反向代理 ws（WebSocket）。v2ray（Xray） 包括应用如下：

1、B=vless+ws+tls（tls由nginx提供及处理，不需配置；另可改成或添加其它ws类应用，参考反向代理ws类的单一示例。）

2、C=SS+v2ray-plugin+tls（tls由nginx提供及处理，不需配置。）

3、A=vless+kcp+seed（可改成vmess-kcp-seed，或添加它。）

注意：

1、nginx 不支持 h2c proxy，故 nginx 不能实现 v2ray（Xray） 的 h2c（http/2）反向代理。

2、若系统版本过低，其对应发行版仓库自带 nginx 预编译程序包可能不支持 tls1.3；如需要支持 tls1.3，必须先升级 OpenSSl 版本大于 1.1.1，再进行 nginx 源代码编译和安装。

3、配置1：全部端口转发。配置2：vless+ws+tls应用进程转发，其它端口转发。
