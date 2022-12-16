介绍：

本示例配置为 Trojan-Go 或 Trojan 与 NaiveProxy 应用。Trojan-Go 或 Trojan 服务端前置（监听 443 端口）处理来自墙内的 HTTPS 请求，如果是合法的 Trojan-Go 或 Trojan 客户端请求，那么为该请求提供服务（科学上网）；否则将已解除 TLS 的流量请求回落（转发）给 Caddy，由 Caddy 为其提供 WEB 服务，若 Caddy 发现是 NaiveProxy 流量就进行正向代理。其应用如下：

1、Trojan-Go或Trojan（回落配置，TLS由自己启用及处理。）

2、NaiveProxy（基于Caddy的改进版forwardproxy插件实现，TLS由Trojan-Go或Trojan启用及处理，不需配置。）

原理：

默认流程：Trojan-Go/Trojan client <-- HTTP/2或HTTPS --> Trojan-Go/Trojan server  
回落流程：WEB client <--------- HTTP/2或HTTPS --------> Trojan-Go/Trojan server <-- H2C或HTTP/1.1 --> Caddy（WEB server/NaiveProxy）

注意：

1、因 Trojan-Go 或 Trojan 不支持 UDS，故回落仅使用 Local Loopback 连接。

2、因 Trojan-Go 或 Trojan 不支持 PROXY protocol，故回落不启用 PROXY protocol。

3、Trojan-Go 完全兼容 Trojan，服务端还有自己的特色：支持 Trojan 应用与自己的 WebSocket 应用共存；支持 CDN 流量中转(基于 WebSocket over TLS)；支持使用 AEAD 对 Trojan 协议流量进行二次加密(基于 Shadowsocks AEAD)。

4、Caddy 支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程。

5、使用本人 Releases 中编译好的 Caddy 文件，可支持 H2C server、NaiveProxy 等应用。

6、本示例中 NaiveProxy 仅支持 HTTP/2 代理应用，即 HTTPS 协议传输。

7、本示例所需 TLS 证书由 Caddy（内置 ACME 客户端） 提供，实现 TLS 证书自动申请及更新。

8、Trojan-Go、Trojan 不支持‘证书热更新’功能，即 Trojan-Go、Trojan 不会自动识别 TLS 证书更新并重载 TLS 证书，可使用如下方法之一解决。

1）、Linux 类系统使用 Crontab 指令定时重启 Trojan-Go 或 Trojan 来重载更新后的 TLS 证书，其它系统使用类似命令/工具来定时重启 Trojan-Go 或 Trojan 来重载更新后的 TLS 证书。（通用办法）

2）、使用 caddy-events-exec 插件应用实现 TLS 证书自动更新后就执行重启 Trojan-Go 或 Trojan 来重载更新后的 TLS 证书，详见 ‘Caddy(Other Configuration) （Caddy的特殊应用配置方法。）’中对应介绍及对应配置示例。（专属办法）
