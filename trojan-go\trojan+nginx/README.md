介绍：

本示例配置为 trojan-go 或 trojan 应用。trojan-go 或 trojan 服务端前置（监听 443 端口）处理来自墙内的 HTTPS 请求，如果是合法的 trojan-go 或 trojan 客户端请求，那么为该请求提供服务（科学上网）；否则将已解除 TLS 的流量请求回落（转发）给 nginx，由 nginx 为其提供 WEB 服务。

原理：

默认流程：trojan-go/trojan client <-- TCP+TLS（HTTP/2或HTTPS） --> trojan-go/trojan server  
回落流程：WEB client <---------------- HTTP/2或HTTPS ---------------> trojan-go/trojan server <-- H2C或HTTP/1.1 --> nginx（WEB server）

注意：

1、因 trojan-go 或 trojan 不支持 Unix Domain Socket（UDS） 回落转发，故回落仅端口回落。

2、因 trojan-go 或 trojan 不支持 PROXY protocol，故回落不启用此项应用。

3、trojan-go 完全兼容 trojan，服务端还有自己的特色：支持 trojan 应用与自己的 WebSocket 应用共存；支持 CDN 流量中转(基于 WebSocket over TLS)；支持使用 AEAD 对 trojan 协议流量进行二次加密(基于 Shadowsocks AEAD)。

4、nginx 支持 H2C server，需要 nginx 包含 http_v2_module 模块。

5、nginx 支持 H2C server，但不支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程；故回落分成 http/1.1 回落与 h2 回落分别对应 nginx 的 HTTP/1.1 server 与 H2C server。

6、因 trojan-go 目前不支持 http/1.1 回落与 h2 回落分开，故 trojan-go 开启 Websocket 支持后只选 http/1.1 连接及 http/1.1 回落。

7、不要使用 ACME 客户端在当前服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 SSL/TLS 证书，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 SSL/TLS 证书需监听 80 或 443 端口，从而与当前应用端口冲突。
