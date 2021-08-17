介绍：

利用 nginx 支持 WebSocket（WS）反向代理，实现除 Xray\v2ray 的 kcp 应用外，WebSocket（WS）类应用共用443端口。包括应用如下：

1、B=vless+ws+tls（tls由nginx提供及处理，不需配置；另可改成或添加其它WS类应用，参考对应的服务端单一应用配置示例。）

2、C=SS+v2ray-plugin+tls（tls由nginx提供及处理，不需配置。）

3、A=vless+kcp+seed（可改成vmess-kcp-seed，或添加它。）

注意：

1、如果系统版本过低，其对应发行版仓库自带 nginx 预编译程序包可能不支持 tls1.3；如需要支持 tls1.3，必须先升级 OpenSSl 版本大于 1.1.1，再进行 nginx 源代码编译和安装。

2、本示例配置不要使用 ACME 客户端在当前服务器上申请与更新普通证书及密钥，因普通证书及密钥申请与更新需要占用或监听80端口（或443端口），从而与当前应用端口冲突。

3、配置1：采用端口转发。配置2：vless+ws+tls 采用进程转发，其它应用采用端口转发。

