介绍：

利用 Nginx 或 Caddy 支持 WebSocket 反向代理实现 V2Ray 或 Xray 的 Trojan+WebSocket+TLS 应用，TLS 由 Nginx 启用及处理或由 Caddy 提供及处理。

原理：

默认流程：Web client <------------ HTTP/1.1+TLS ------------> Nginx/Caddy（Web server）  
反代流程：V2Ray/Xray client <------- WebSocket+TLS -------> Nginx/Caddy <-- WebSocket --> V2Ray/Xray server

注意：

1、V2Ray 版本不小于 v4.31.0 才支持 Trojan 协议。

2、Nginx 支持 HTTPS server 需要 Nginx 包含 http_ssl_module 模块构建。

3、若选用 Nginx 实现应用，ACME 客户端在采用本示例的服务器上以 HTTP-01 验证方式申请与更新 TLS 证书时、建议使用 Nginx 模式来避免端口冲突。

4、若选用 Caddy 实现应用，本示例 Caddy 支持自动 HTTPS，即自动申请与更新 TLS 证书，自动 HTTP 重定向到 HTTPS。

5、本示例虽然兼容 Trojan-Go 服务端的 WebSocket 应用，但是 Trojan-Go 客户端不支持指纹伪造、不支持 WebSocket 0-RTT、且不能启用多路复用（不兼容），故不推荐使用 Trojan-Go 客户端来连接。

6、配置1：使用 Local Loopback 连接。配置2：使用 UDS 连接。
