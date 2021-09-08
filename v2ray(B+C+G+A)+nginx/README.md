介绍：

利用 nginx 支持 WebSocket（WS）、gRPC 反向代理，实现除 Xray\v2ray 的 KCP 应用外，WebSocket（WS）、gRPC 类应用共用443端口。包括应用如下：

1、B=vless+ws+tls（TLS由nginx提供及处理，不需配置；另可改成或添加其它WS类应用，参考对应的服务端单一应用配置示例。）

2、C=SS+v2ray-plugin+tls（TLS由nginx提供及处理，不需配置。）

3、G=vless+grpc+tls（TLS由nginx提供及处理，不需配置；另可改成或添加其它gRPC类应用，参考对应的服务端单一应用配置示例。）

4、A=vless+kcp+seed（可改成vmess+kcp+seed，或添加它。）

注意：

1、Xray 版本不小于 v1.4.0 或 v2ray 版本不小于v4.36.2，才支持 gRPC 传输方式。

2、nginx 支持 HTTP/2 server 及 gRPC proxy，需要 nginx 包含 http_v2_module 和 http_ssl_module 模块。

3、nginx 支持 TLSv1.3，需要 nginx 包含版本大于 1.1.1 的 OpenSSl 库和 http_ssl_module 模块。

4、本示例配置不要使用 ACME 客户端在当前服务器上申请与更新普通证书及密钥，因普通证书及密钥申请与更新需要占用或监听80端口（或443端口），从而与当前应用端口冲突。

5、配置1：采用端口转发。配置2：除SS+v2ray-plugin+tls外，其它采用进程转发。
