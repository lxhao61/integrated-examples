介绍：

V2Ray 或 Xray 前置（监听 443 端口），利用 vless+tcp+tls 或 vless+tcp+xtls 强大的回落及分流 WebSocket（WS） 特性、套娃 trojan+tcp 后回落 Caddy，实现除 V2Ray 或 Xray 的 mKCP 应用外共用 443 端口。其应用如下：

1、E=vless+tcp+tls/xtls（回落/分流配置，TLS/XTLS由自己提供及处理。）

2、C=trojan+ws+tls（TLS由vless+tcp+tls/xtls提供及处理，不需配置。）

3、F=trojan+tcp+tls（TLS由vless+tcp+tls/xtls提供及处理，不需配置。）

4、A=vless+kcp+seed

注意：

1、采用套娃方式实现共用 443 端口，仅需要一个域名及普通证书即可搞定，但套娃不支持 XTLS 应用。

2、V2Ray 版本不小于 v4.31.0 才支持 Trojan 协议。

3、Caddy 支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程。

4、Caddy 发行版不支持接收 PROXY protocol。如要支持接收 PROXY protocol 需选 caddy2-proxyprotocol 插件定制编译，或下载本人 Releases 中编译好的 Caddy 来使用即可。

5、本示例中 V2Ray 或 Xray 所需 TLS 证书由 Caddy 提供，实现 TLS 证书自动申请及更新，且同步 V2Ray 重载 TLS 证书或 Xray 自动热重载 TLS 证书。

6、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol。配置2：使用 UDS 连接，且启用了 PROXY protocol。

7、本示例 F 兼容原版 Trojan 应用，F+C 组合等同于 Trojan-Go 应用；即可使用 Trojan 客户端 或 Trojan-Go 客户端对应连接。
