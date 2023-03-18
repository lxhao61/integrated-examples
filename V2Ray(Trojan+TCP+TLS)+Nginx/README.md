介绍：

本示例配置为 Trojan+TCP+TLS 应用。Xray 或 V2Ray 服务端前置（监听 443 端口）处理来自墙内的 HTTPS 请求，如果是合法的 Xray 或 V2Ray 客户端请求，那么为该请求提供服务（科学上网）；否则将已解除 TLS 的流量请求回落（转发）给 Nginx，由 Nginx 为其提供 WEB 服务。

原理：

默认流程：Xray/V2Ray client <---- TCP+TLS（HTTP/2或HTTPS） ----> Xray/V2Ray server  
回落流程：WEB client <--------------- HTTP/2或HTTPS ---------------> Xray/V2Ray server <-- H2C或HTTP/1.1 --> Nginx（WEB server）

注意：

1、V2Ray 版本不小于 v4.43.0 才完美支持 Trojan 协议。

2、Nginx 支持 H2C server 需要 Nginx 包含 http_v2_module 模块。

3、Nginx 支持 HTTP 功能块接收 PROXY protocol 需要 Nginx 包含 http_realip_module 模块。

4、Nginx 支持 H2C server，但不支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程；故回落分成 http/1.1 回落与 h2 回落分别对应 Nginx 的 HTTP/1.1 server 与 H2C server。

5、不要使用 ACME 客户端在采用本示例的服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书需监听 80 或 443 端口，从而与当前应用端口冲突。

6、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol。配置2：使用 UDS 连接，且启用了 PROXY protocol。

7、本示例兼容原版 Trojan 应用，即可使用 Trojan 客户端 或 Trojan-Go 客户端对应连接。
