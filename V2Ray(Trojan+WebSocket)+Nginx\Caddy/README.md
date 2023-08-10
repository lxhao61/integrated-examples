介绍：

利用 Nginx 或 Caddy 支持 WebSocket 代理实现 V2Ray 或 Xray 的 Trojan+WebSocket+TLS 应用，TLS 由 Nginx 启用及处理或由 Caddy 提供及处理。

原理：

默认流程：WEB client <------------ HTTPS（HTTP/1.1+TLS） ------------> Nginx/Caddy（WEB server）  
反代流程：V2Ray/Xray client <------------- WebSocket+TLS -------------> Nginx/Caddy <-- WebSocket --> V2Ray/Xray server

注意：

1、V2Ray 版本不小于 v4.31.0 才支持 Trojan 协议。

2、Nginx 支持 HTTPS server 需要 Nginx 包含 http_ssl_module 模块等。

3、Nginx 支持请求标头还原为真实客户端地址需要 Nginx 包含 http_realip_module 模块。

4、若选用 Nginx 实现应用，不要使用 ACME 客户端在采用本示例的服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书需监听 80 或 443 端口，从而与当前应用端口冲突。

5、若选用 Caddy 实现应用，本示例 Caddy 支持自动 HTTPS，即自动申请与更新 TLS 证书，自动 HTTP 重定向到 HTTPS。

6、配置1：使用 Local Loopback 连接。配置2：使用 UDS 连接。

7、本示例兼容原版 Trojan-Go 的服务端 WebSocket 应用，即可使用 Trojan-Go 客户端连接（多路复用不能启用，不兼容。）。
