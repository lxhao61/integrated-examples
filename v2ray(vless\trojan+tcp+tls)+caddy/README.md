介绍：

本示例配置包含 vless+tcp+tls 或 vless+tcp+xtls 与 trojan+tcp+tls 或 trojan+tcp+xtls 应用。V2Ray 或 Xray 服务端前置（监听 443 端口）处理来自墙内的 HTTPS 请求，如果是合法的 V2Ray 或 Xray 客户端请求，那么为该请求提供服务（科学上网）；否则将已解除 TLS/XTLS 的流量请求回落（转发）给 Caddy，由 Caddy 为其提供 WEB 服务。

原理：

默认流程：V2Ray/Xray client <---- TCP+TLS（HTTP/2或HTTPS） ----> V2Ray/Xray server  
回落流程：WEB client <--------------- HTTP/2或HTTPS --------------> V2Ray/Xray server <-- H2C或HTTP/1.1 --> Caddy（WEB server）

其中 trojan+tcp+tls 或 trojan+tcp+xtls 应用还实现了兼容原版 Trojan，即可使用 Trojan 客户端 或 Trojan-Go 客户端连接。

注意：

1、V2Ray 版本不小于 v4.31.0 才支持 Trojan 协议。

2、Caddy 支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程。

3、Caddy 发行版不支持接收 PROXY protocol。如要支持接收 PROXY protocol 需选 caddy2-proxyprotocol 插件定制编译，或下载本人 Releases 中编译好的 Caddy 来使用即可。

4、本示例中 V2Ray 或 Xray 所需 TLS 证书由 Caddy 提供，实现 TLS 证书自动申请及更新，且同步 V2Ray 重载 TLS 证书或 Xray 自动热重载 TLS 证书。

5、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol。配置2：使用 UDS 连接，且启用了 PROXY protocol。
