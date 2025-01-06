介绍：

利用 Nginx 或 Caddy 支持 XHTTP 反向代理实现 Xray 的 VMess+XHTTP+TLS 应用，TLS 由 Nginx 启用及处理或由 Caddy 提供及处理。XHTTP 应用使用 HTTP 分块传输编码流式响应处理下载、使用多个 HTTP POST 请求（或者流式）进行上传，可解决如 CDN 不支持 WebSocket/HTTPUpgrade、gRPC 通过就无法通过的问题。


原理：

默认流程：WEB client <-------- HTTP/3或HTTP/2 --------> Nginx/Caddy（WEB server）  
反代流程：Xray client <----------- XHTTP+TLS -----------> Nginx/Caddy <-- XHTTP --> Xray server

注意：

1、Xray 版本不小于 v24.11.30 才支持完全体 XHTTP，其 XHTTP 传输方式实现了真正的上下行分离（见客户端配置示例），给 GFW 针对单个连接的分析带来了麻烦。

2、Nginx 支持 HTTP/2 server、HTTP/3 server 需要 Nginx 包含 http_ssl_module、http_v2_module、http_v3_module 模块构建。

3、Nginx 版本不小于 v1.25.0 才支持 HTTP/3 server，且 http_ssl_module 所用 SSL 库必须支持 QUIC。

4、若选用 Nginx 实现应用，不要使用 ACME 客户端在采用本示例的服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书需监听 80 或 443 端口，从而与当前应用端口冲突。

5、Caddy 版本不小于 v2.6.0 才支持 H2C 反向代理的 UDS 转发。

6、若选用 Caddy 实现应用，本示例 Caddy 支持自动 HTTPS，即自动申请与更新 TLS 证书，自动 HTTP 重定向到 HTTPS。

7、本示例支持 HTTP/3 传输。若想要由 Caddy 处理的 HTTP/3 应用高速传输，建议[增加服务端系统的 UDP 缓冲区大小](https://github.com/quic-go/quic-go/wiki/UDP-Buffer-Sizes)。

8、配置1：使用 Local Loopback 连接。配置2：使用 UDS 连接。
