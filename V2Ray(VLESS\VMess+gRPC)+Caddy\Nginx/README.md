介绍：

利用 Caddy 或 Nginx 支持 gRPC 代理，实现 Xray 或 V2Ray 的 vless+grpc+tls 与 vmess+grpc+tls 两种反向代理应用，TLS 由 Caddy 提供及处理或由 Nginx 启用及处理。

原理：

默认流程：WEB client <------ HTTP/2（H2C+TLS） ------> Caddy/Nginx（WEB server）  
反代流程：Xray/V2Ray client <-------- gRPC+TLS --------> Caddy/Nginx <-- gRPC --> Xray/V2Ray server

注意：

1、Xray 版本不小于 v1.4.0 或 V2Ray 版本不小于 v4.36.2 才支持 gRPC 传输方式。

2、Caddy 版本不小于 v2.2.0 才支持 H2C proxy，即 Caddy 支持基于 H2C 代理实现 Xray 或 V2Ray 的 gRPC 反向代理。Caddy 版本不小于 v2.6.0 才支持 H2C proxy 的 UDS 转发。

3、若采用 Caddy 反向代理，本示例 Caddy 支持自动 HTTPS，即自动申请与更新 TLS 证书，自动 HTTP 重定向到 HTTPS。

4、Nginx 支持 HTTP/2 server 及 gRPC proxy 需要 Nginx 包含 http_ssl_module 与 http_v2_module 模块及 OpenSSL 库。

5、若采用 Nginx 反向代理，不要使用 ACME 客户端在采用本示例的服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书需监听 80 或 443 端口，从而与当前应用端口冲突。

6、配置1：使用 Local Loopback 连接。配置2：使用 UDS 连接。
