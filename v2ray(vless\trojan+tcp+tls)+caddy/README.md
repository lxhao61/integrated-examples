介绍：

本示例配置包含 vless+tcp+tls 或 vless+tcp+xtls 与 trojan+tcp+tls 或 trojan+tcp+xtls 应用。v2ray 或 Xray 服务端前置（监听 443 端口）处理来自墙内的 HTTPS 请求，如果是合法的 v2ray 或 Xray 客户端请求，那么为该请求提供服务（科学上网）；否则将已解除 TLS/XTLS 的流量请求回落（转发）给 caddy，由 caddy 为其提供 WEB 服务。

原理：

默认流程：v2ray/Xray client <---- TCP+TLS（HTTP/2或HTTPS） ----> v2ray/Xray server  
回落流程：WEB client <--------------- HTTP/2或HTTPS --------------> v2ray/Xray server <-- H2C或HTTP/1.1 --> caddy（WEB server）

其中 trojan+tcp+tls 或 trojan+tcp+xtls 应用还实现了兼容原版 trojan，即可使用 trojan 客户端 或 trojan-go 客户端连接。

注意：

1、v2ray 版本不小于 v4.31.0 才支持 trojan 协议。

2、caddy 支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程。

3、caddy 发行版不支持接收 PROXY protocol。如要支持接收 PROXY protocol 需选 caddy2-proxyprotocol 插件定制编译，或下载本人 Releases 中编译好的 caddy 来使用即可。

4、从acme申请的普通TLS证书在“/home/tls/certificates/acme-v02.api.letsencrypt.org-directory/xx.yy”目录中；xx.yy为域名，根据域名变化。从zerossl申请的普通TLS证书在“/home/tls/certificates/acme.zerossl.com-v2-dv90/xx.yy”目录中；xx.yy为域名，根据域名变化。

5、通配符TLS证书申请配置，详见“caddy(other configuration) （caddy的特殊应用配置方法。）”。

6、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol。配置2：使用 UDS 连接，且启用了 PROXY protocol。
