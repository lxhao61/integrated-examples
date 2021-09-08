介绍：

利用 caddy 或 nginx 支持 gRPC 反向代理，实现 trojan+grpc+tls 反向代理应用，TLS 由 caddy 或 nginx 提供及处理。

原理：

默认流程：WEB client <------- HTTPS（HTTP/2）-----> caddy\nginx（WEB server）  
匹配流程：Xray\v2ray client <------- gRPC+TLS -------> caddy\nginx <-- gRPC --> Xray\v2ray server

注意：

1、Xray 版本不小于 v1.4.0 或 v2ray 版本不小于v4.36.2，才支持 gRPC 传输方式。

2、caddy 版本不小于 v2.2.0-rc.1 才支持 H2C proxy，即支持 Xray\v2ray 的 H2C（gRPC）反向代理。

3、因 caddy 实现 H2C 反向代理仅支持端口转发，故通过 caddy 实现 gRPC 反向代理也仅支持端口转发，不支持进程转发。

4、若采用 caddy 反向代理，本示例 caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可（效果一样）。支持自动 HTTPS，即自动申请与更新证书与私钥，自动 HTTP 重定向到 HTTPS。

5、nginx 支持 HTTP/2 server 及 gRPC proxy，需要 nginx 包含 http_ssl_module 和 http_v2_module 模块。

6、nginx 支持 TLSv1.3，需要 nginx 包含 http_ssl_module 模块和版本大于 1.1.1 的 OpenSSl 库。

7、若采用 nginx 反向代理，本示例配置不要使用 ACME 客户端在当前服务器上申请与更新普通证书及密钥，因普通证书及密钥申请与更新需要占用或监听80端口（或443端口），从而与当前应用端口冲突。

8、配置1：采用端口转发。配置2：采用进程转发。
