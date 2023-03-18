介绍：

利用 Caddy 或 Nginx 支持 WebSocket 代理实现 Xray 或 V2Ray 的 Trojan+WebSocket+TLS 应用，TLS 由 Caddy 提供及处理或由 Nginx 启用及处理。此服务端兼容 Trojan-Go 的 WebSocket 应用，可直接使用 Trojan-Go 客户端连接（不能启用多路复用，不兼容。）。

原理：

默认流程：WEB client <------------ HTTPS（HTTP/1.1+TLS） ------------> Caddy/Nginx（WEB server）  
反代流程：Trojan-Go/Xray/V2Ray client <------- WebSocket+TLS -------> Caddy/Nginx <-- WebSocket --> Xray/V2Ray server

注意：

1、V2Ray 版本不小于 v4.31.0 才支持 trojan 协议。

2、若采用 Caddy 反向代理，本示例 Caddy 支持自动 HTTPS，即自动申请与更新 TLS 证书，自动 HTTP 重定向到 HTTPS。

3、Nginx 支持 HTTPS server 及 WebSocket proxy 需要 Nginx 包含 http_ssl_module 模块及 OpenSSL 库。

4、若采用 Nginx 反向代理，不要使用 ACME 客户端在采用本示例的服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书需监听 80 或 443 端口，从而与当前应用端口冲突。

5、配置1：使用 Local Loopback 连接。配置2：使用 UDS 连接。
