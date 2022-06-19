介绍：

利用 caddy 或 nginx 支持 gRPC 代理，实现 Xray 或 v2ray 的 shadowsocks+grpc+tls 反向代理应用，TLS 由 caddy 或 nginx 提供及处理。此服务端兼容原版 shadowsocks 加 xray-plugin 或 v2ray-plugin 插件的 gRPC 应用（服务端），即客户端也可使用 shadowsocks 加 xray-plugin 或 v2ray-plugin 插件连接。

原理：

默认流程：WEB client <-------------- HTTPS（HTTP/2）--------------> caddy/nginx（WEB server）  
匹配流程：shadowsocks/Xray/v2ray client <------- gRPC+TLS -------> caddy/nginx <-- gRPC --> Xray/v2ray server

注意：

1、SS 为 shadowsocks 简写。

2、Xray 版本不小于 v1.4.0 或 v2ray 版本不小于 v4.36.2，才支持 gRPC 传输方式。

3、caddy 版本不小于 v2.2.0-rc.1 才支持 H2C proxy，即支持 Xray 或 v2ray 的 H2C（gRPC）反向代理。

4、因 caddy 实现 H2C 反向代理仅支持端口转发，故通过 caddy 基于 H2C 代理实现的 gRPC 反向代理也仅支持端口转发，不支持进程转发。

5、若采用 caddy 反向代理，本示例 caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可（完全等同）。支持自动 HTTPS，即自动申请与更新证书与私钥，自动 HTTP 重定向到 HTTPS。

6、nginx 支持 HTTP/2 server 及 gRPC proxy，需要 nginx 包含 http_v2_module 和 http_ssl_module 模块。

7、nginx 支持 TLSv1.3，需要包含版本不小于 1.1.1 的 OpenSSL 软件库包和 http_ssl_module 模块。

8、若采用 nginx 反向代理，不要使用 ACME 客户端在当前服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新证书及密钥，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新证书及密钥需监听 80 或 443 端口，从而与当前应用端口冲突。
