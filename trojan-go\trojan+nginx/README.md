介绍：

本示例配置为 trojan-go 或 trojan 应用。trojan-go 或 trojan 服务端前置（监听443端口）处理来自墙内的 HTTPS 请求，如果是合法的 trojan-go 或 trojan 客户端请求，那么为该请求提供服务（科学上网）；否则将已解除 TLS 的流量请求回落（转发）给 WEB 服务器 nginx，由 nginx 为其提供服务。

原理：

默认流程：trojan-go\trojan client <------ HTTPS ------> trojan-go\trojan server  
回落流程：WEB client <------------- HTTPS ------------> trojan-go\trojan server <-- 回落 --> nginx（WEB server）

注意：

1、nginx 支持 H2C server，需要 nginx 包含 http_v2_module 模块。

2、nginx 支持 H2C server，但不支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程（Unix Domain Socket 应用）；故回落配置就必须分成 http/1.1 回落与 h2 回落两部分，以便分别对应 nginx 的 HTTP/1.1 server 与 H2C server。

3、因 trojan-go\trojan 不支持 Unix Domain Socket，故回落仅端口回落。

4、因 trojan-go\trojan 不支持 PROXY protocol，故回落不能启用此项应用。

5、因 trojan-go 目前不支持 http/1.1 回落与 h2 回落分开，故 trojan-go 开启 Websocket 支持后只能选 http/1.1 连接及 http/1.1 回落。

6、trojan-go 完全兼容 trojan，服务端还有自己的特色：支持 trojan 应用与自己的 Websocket 应用共存；支持 CDN 流量中转(基于 WebSocket over TLS)；支持使用 AEAD 对 trojan 协议流量进行二次加密(基于 Shadowsocks AEAD)。

7、本示例配置不要使用 ACME 客户端在当前服务器上申请与更新普通证书及密钥，因普通证书及密钥申请与更新需要占用或监听80端口（或443端口），从而与当前应用端口冲突。
