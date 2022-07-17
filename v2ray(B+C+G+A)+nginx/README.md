介绍：

利用 nginx 支持 WebSocket（WS）、gRPC 代理，实现除 Xray 或 v2ray 的 KCP 应用外，WebSocket（WS）、gRPC 类反向代理应用共用 443 端口。包括应用如下：

1、B=vless+ws+tls（TLS由nginx提供及处理，不需配置。另可改、可增其它WS类应用，参考对应的服务端单一应用配置示例。）

2、C=shadowsocks+xray-plugin/v2ray-plugin+tls（TLS由nginx提供及处理，不需配置。）

3、G=vless+grpc+tls（TLS由nginx提供及处理，不需配置。另可改、可增其它gRPC类应用，参考对应的服务端单一应用配置示例。）

4、A=vless+kcp+seed（可改成vmess+kcp+seed，或添加它。）

注意：

1、Xray 版本不小于 v1.4.0 或 v2ray 版本不小于v4.36.2，才支持 gRPC 传输方式。

2、nginx 支持 HTTP/2 server 及 gRPC proxy，需要 nginx 包含 http_v2_module 和 http_ssl_module 模块。

3、nginx 支持 TLSv1.3，需要包含版本不小于 1.1.1 的 OpenSSL 软件库包和 http_ssl_module 模块。

4、不要使用 ACME 客户端在当前服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 SSL/TLS 证书，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 SSL/TLS 证书需监听 80 或 443 端口，从而与当前应用端口冲突。

5、配置1：采用端口转发。配置2：除shadowsocks+xray-plugin/v2ray-plugin+tls外，其它采用进程转发。
