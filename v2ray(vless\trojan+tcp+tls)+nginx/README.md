介绍：

本示例配置包含 vless+tcp+tls 或 vless+tcp+xtls 与 trojan+tcp+tls 或 trojan+tcp+xtls 应用。v2ray 或 Xray 服务端前置（监听 443 端口）处理来自墙内的 HTTPS 请求，如果是合法的 v2ray 或 Xray 客户端请求，那么为该请求提供服务（科学上网）；否则将已解除 TLS/XTLS 的流量请求回落（转发）给 nginx，由 nginx 为其提供 WEB 服务。

原理：

默认流程：v2ray/Xray client <---- TCP+TLS（HTTP/2或HTTPS） ----> v2ray/Xray server  
回落流程：WEB client <---------------- HTTP/2或HTTPS --------------> v2ray/Xray server <-- H2C或HTTP/1.1 --> caddy（WEB server）

其中 trojan+tcp+tls 或 trojan+tcp+xtls 应用还实现了兼容原版 trojan，即可使用 trojan 客户端 或 trojan-go 客户端连接。

注意：

1、v2ray 版本不小于 v4.43.0 才完美支持 trojan 协议。

2、nginx 支持 H2C server，需要 nginx 包含 http_v2_module 模块。

3、nginx 支持 HTTP 功能块接收 PROXY protocol，需要 nginx 包含 http_realip_module 模块。

4、nginx 支持 H2C server，但不支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程；故回落分成 http/1.1 回落与 h2 回落分别对应 nginx 的 HTTP/1.1 server 与 H2C server。

5、不要使用 ACME 客户端在当前服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 SSL/TLS 证书，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 SSL/TLS 证书需监听 80 或 443 端口，从而与当前应用端口冲突。

6、配置1：采用端口回落。配置2：采用进程回落。配置3：采用进程回落，且启用了 PROXY protocol。
