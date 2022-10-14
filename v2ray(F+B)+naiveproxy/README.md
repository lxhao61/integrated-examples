介绍：

v2ray 或 Xray 前置（监听 443 端口），利用 trojan+tcp+tls 或 trojan+tcp+xtls 强大的回落/分流 WebSocket（WS）特性及 caddy 为 naiveproxy 提供正向代理，实现除 v2ray 或 Xray 的 KCP 应用外共用 443 端口。其应用如下：

1、F=trojan+tcp+tls/xtls（回落/分流配置，TLS/XTLS由自己提供及处理。）

2、B=vless+ws+tls（TLS由trojan+tcp+tls/xtls提供及处理，不需配置；另可改成或添加其它WS类应用，参考对应的服务端单一应用配置示例。）

3、naiveproxy（基于caddy的改进版forwardproxy插件实现，TLS由trojan+tcp+tls/xtls提供及处理，不需配置。）

注意：

1、v2ray 版本不小于 v4.31.0 才支持 trojan 协议。

2、caddy 支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程。

3、使用本人 Releases 中编译好的 caddy 文件，可同时支持 H2C server、naiveproxy 及接收 PROXY protocol 等应用。

4、本示例中 naiveproxy 仅支持 HTTP/2 代理应用，即 HTTPS 协议传输。

5、Xray 所需 SSL/TLS 证书推荐使用 caddy 自动申请，配合 Xray 支持自动热重载 SSL/TLS 证书，可实现 Xray 所需 SSL/TLS 证书更新全自动化。

6、不要使用第三方 ACME 客户端在当前服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 SSL/TLS 证书，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 SSL/TLS 证书需监听 80 或 443 端口，从而与当前应用端口冲突。

7、配置1：采用端口回落/分流。配置2：采用进程回落/分流。配置3：采用进程回落/分流，且启用了 PROXY protocol。

8、若上 vless+ws+tls 改为 trojan+ws+tls，本示例中 v2ray 或 Xray 的两个组合应用即可实现兼容 trojan-go 应用，即可使用 trojan-go 客户端连接。
