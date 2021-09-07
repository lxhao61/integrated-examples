介绍：

利用 caddy 或 nginx 支持 WebSocket（WS）反向代理，实现 socks+ws+tls 与 shadowsocks+ws+tls 两种反向代理应用，TLS 由 caddy 或 nginx 提供及处理。

原理：

默认流程：WEB client <-------- HTTPS（HTTP/1.1+TLS） -------> caddy\nginx（WEB server）  
匹配流程：Xray\v2ray client <--------- WebSocket+TLS ---------> caddy\nginx <-- WebSocket --> Xray\v2ray server

注意：

1、SS 为 shadowsocks 简写。

2、若采用 caddy 反向代理，本示例 caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可（效果一样）。支持自动 HTTPS，即自动申请与更新证书与私钥，自动 HTTP 重定向到 HTTPS。

3、nginx 支持 TLSv1.3，需要 nginx 包含 http_ssl_module 模块和版本大于 1.1.1 的 OpenSSl 库。

4、若采用 nginx 反向代理，本示例配置不要使用 ACME 客户端在当前服务器上申请与更新普通证书及密钥，因普通证书及密钥申请与更新需要占用或监听80端口（或443端口），从而与当前应用端口冲突。
