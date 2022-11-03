介绍：

本示例配置为 Trojan-Go 或 Trojan 与 NaïveProxy 应用。Trojan-Go 或 Trojan 服务端前置（监听 443 端口）处理来自墙内的 HTTPS 请求，如果是合法的 Trojan-Go 或 Trojan 客户端请求，那么为该请求提供服务（科学上网）；否则将已解除 TLS 的流量请求回落（转发）给 Caddy，由 Caddy 为其提供 WEB 服务，若 Caddy 发现是 NaïveProxy 流量就进行正向代理。其应用如下：

1、Trojan-Go或Trojan（回落配置，TLS由Caddy提供及处理。）

2、NaïveProxy（基于Caddy的改进版forwardproxy插件实现，TLS由Trojan-Go或Trojan处理，不需配置。）

原理：

默认流程：Trojan-Go/Trojan client <------ HTTP/2或HTTPS ------> Trojan-Go/Trojan server  
回落流程：WEB client <------------- HTTP/2或HTTPS ------------> Trojan-Go/Trojan server <-- H2C或HTTP/1.1 --> Caddy（WEB server）

注意：

1、因 Trojan-Go 或 Trojan 不支持 UDS，故回落仅使用 Local Loopback 连接。

2、因 Trojan-Go 或 Trojan 不支持 PROXY protocol，故回落不启用 PROXY protocol。

3、Trojan-Go 完全兼容 Trojan，服务端还有自己的特色：支持 Trojan 应用与自己的 WebSocket 应用共存；支持 CDN 流量中转(基于 WebSocket over TLS)；支持使用 AEAD 对 Trojan 协议流量进行二次加密(基于 Shadowsocks AEAD)。

4、Caddy 支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程。

5、使用本人 Releases 中编译好的 Caddy 文件，可支持 H2C server、NaïveProxy 等应用。

6、本示例的 NaïveProxy 仅支持 HTTP/2 代理应用，即 HTTPS 协议传输。

7、本示例的 Trojan-Go 或 Trojan 所需 TLS 证书由 Caddy 提供，实现证书自动申请及更新，且 Trojan-Go 或 Trojan 同步重载更新证书。
