介绍：

本示例配置包含 vless+tcp+tls 或 vless+tcp+xtls 与 trojan+tcp+tls 或 trojan+tcp+xtls 应用。v2ray 或 Xray 服务端前置（监听 443 端口）处理来自墙内的 HTTPS 请求，如果是合法的 v2ray 或 Xray 客户端请求，那么为该请求提供服务（科学上网）；否则将已解除 TLS/XTLS 的流量请求回落（转发）给 caddy，由 caddy 为其提供 WEB 服务。

原理：

默认流程：v2ray/Xray client <------ TCP+TLS（HTTPS） ------> v2ray/Xray server  
回落流程：WEB client <----------------- HTTPS ----------------> v2ray/Xray server <-- 回落 --> caddy（WEB server）

其中 trojan+tcp+tls 或 trojan+tcp+xtls 应用还实现了兼容原版 trojan，即可使用 trojan 客户端 或 trojan-go 客户端连接。

注意：

1、v2ray 版本不小于 v4.31.0 才支持 trojan 协议。

2、caddy 版本不小于 v2.3.0 才支持 Caddyfile 配置开启 H2C server。

3、caddy 支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程。

4、caddy 发行版不支持接收 PROXY protocol。如要支持接收 PROXY protocol 需选 caddy2-proxyprotocol 插件定制编译，或下载本人 Releases 中编译好的 caddy 来使用即可。

5、Xray 所需 SSL/TLS 证书推荐使用 caddy 自动申请，配合 Xray 支持自动热重载 SSL/TLS 证书，可实现 Xray 所需 SSL/TLS 证书更新全自动化。

6、本示例 caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可（完全等效）。若使用 caddy 自动申请 SSL/TLS 证书推荐使用 json 格式配置，优化更好。

7、不要使用第三方 ACME 客户端在当前服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 SSL/TLS 证书，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 SSL/TLS 证书需监听 80 或 443 端口，从而与当前应用端口冲突。

8、配置1：采用端口回落。配置2：采用进程回落。配置3：采用进程回落，且启用了 PROXY protocol。
