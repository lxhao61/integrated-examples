介绍：

利用 caddy 或 nginx 支持 gRPC 代理，实现 Xray 或 v2ray 的 trojan+grpc+tls 反向代理应用，TLS 由 caddy 或 nginx 提供及处理。

原理：

默认流程：WEB client <--------------- HTTP/2 ---------------> caddy/nginx（WEB server）  
匹配流程：Xray/v2ray client <------- gRPC+TLS -------> caddy/nginx <-- gRPC --> Xray/v2ray server

注意：

1、Xray 版本不小于 v1.4.0 或 v2ray 版本不小于 v4.36.2 才支持 gRPC 传输方式。

2、caddy 版本不小于 v2.2.0 才支持 H2C proxy，即 caddy 支持基于 H2C 代理实现 Xray 或 v2ray 的 gRPC 反向代理。caddy 版本不小于 v2.6.0 才支持 H2C proxy 的 Unix Domain Socket（UDS） 转发。

3、若采用 caddy 反向代理，本示例 caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可（完全等同）。支持自动 HTTPS，即自动申请与更新 SSL/TLS 证书，自动 HTTP 重定向到 HTTPS。

4、nginx 支持 HTTP/2 server 及 gRPC proxy，需要 nginx 包含 http_v2_module 和 http_ssl_module 模块。

5、nginx 支持 TLSv1.3，需要包含版本不小于 1.1.1 的 OpenSSL 软件库包和 http_ssl_module 模块。

6、若采用 nginx 反向代理，不要使用 ACME 客户端在当前服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 SSL/TLS 证书，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 SSL/TLS 证书需监听 80 或 443 端口，从而与当前应用端口冲突。

7、配置1：采用端口转发。配置2：采用进程转发。
