介绍：

利用 Nginx 或 Caddy 支持 HTTPUpgrade 反向代理实现 Xray 的 VMess+HTTPUpgrade+TLS 应用，TLS 由 Nginx 启用及处理或由 Caddy 提供及处理，可完美替代 VMess+WebSocket+TLS 应用实现更高的效率。

原理：

默认流程：Web client <------------- HTTP/1.1+TLS --------------> Nginx/Caddy（Web server）  
反代流程：Xray client <----------- HTTPUpgrade+TLS -----------> Nginx/Caddy <-- HTTPUpgrade --> Xray server

注意：

1、Xray 版本不小于 v1.8.9 才支持 HTTPUpgrade 传输方式。

2、Nginx 支持 HTTPS server 需要 Nginx 包含 http_ssl_module 模块构建。

3、若选用 Nginx 实现应用，ACME 客户端在采用本示例的服务器上以 HTTP-01 验证方式申请与更新 TLS 证书时、建议使用 Nginx 模式来避免端口冲突。

4、若选用 Caddy 实现应用，本示例 Caddy 支持自动 HTTPS，即自动申请与更新 TLS 证书，自动 HTTP 重定向到 HTTPS。

5、配置1：使用 Local Loopback 连接。配置2：使用 UDS 连接。
