介绍：

利用 Nginx 或 Caddy 支持 gRPC 反向代理实现 V2Ray 或 Xray 的 Shadowsocks+gRPC+TLS 应用，TLS 由 Nginx 启用及处理或由 Caddy 提供及处理。

原理：

默认流程：WEB client <-------- HTTP/2（H2C+TLS） --------> Nginx/Caddy（WEB server）  
反代流程：V2Ray/Xray client <---------- gRPC+TLS ----------> Nginx/Caddy <-- gRPC --> V2Ray/Xray server

注意：

1、SS 为 shadowsocks 简写。

2、V2Ray 或 Xray 的监听地址不支持 Shadowsocks 协议使用 UDS 监听。

3、V2Ray 版本不小于 v4.37.0 才支持 Shadowsocks 启用 IV 检查功能，可使某些 IV 重放攻击更加困难。

4、Xray 版本不小于 v1.7.0 才完美支持 Shadowsocks 2022 新协议，提升了性能并带有完整的重放保护。

5、Nginx 支持 HTTP/2 server 需要 Nginx 包含 http_ssl_module 与 http_v2_module 模块构建。

6、若选用 Nginx 实现应用，不要使用 ACME 客户端在采用本示例的服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书需监听 80 或 443 端口，从而与当前应用端口冲突。

7、Caddy 版本不小于 v2.2.0 才支持 H2C 反向代理。

8、若选用 Caddy 实现应用，本示例 Caddy 支持自动 HTTPS，即自动申请与更新 TLS 证书，自动 HTTP 重定向到 HTTPS。

9、本示例兼容原版 Shadowsocks 加 v2ray-plugin 或 xray-plugin 插件的 grpc-tls 模式服务端应用，即客户端可使用 Shadowsocks 加 v2ray-plugin 或 xray-plugin 插件连接。
