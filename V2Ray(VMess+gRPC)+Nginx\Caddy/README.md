介绍：

利用 Nginx 或 Caddy 支持 gRPC 反向代理实现 V2Ray 或 Xray 的 VMess+gRPC+TLS 应用，TLS 由 Nginx 启用及处理或由 Caddy 提供及处理。

原理：

默认流程：WEB client <-------- HTTP/2（H2C+TLS） --------> Nginx/Caddy（WEB server）  
反代流程：V2Ray/Xray client <---------- gRPC+TLS ----------> Nginx/Caddy <-- gRPC --> V2Ray/Xray server

注意：

1、V2Ray 版本不小于 v4.36.2 或 Xray 版本不小于 v1.4.0 才支持 gRPC 传输方式。

2、Nginx 支持 HTTP/2 server 需要 Nginx 包含 http_ssl_module 与 http_v2_module 模块构建。

3、若选用 Nginx 实现应用，ACME 客户端在采用本示例的服务器上以 HTTP-01 验证方式申请与更新 TLS 证书时，建议仅使用 Nginx 模式，避免端口冲突。

4、Caddy 版本不小于 v2.6.0 才支持 H2C 反向代理的 UDS 转发。

5、若选用 Caddy 实现应用，本示例 Caddy 支持自动 HTTPS，即自动申请与更新 TLS 证书，自动 HTTP 重定向到 HTTPS。

6、配置1：使用 Local Loopback 连接。配置2：使用 UDS 连接。
