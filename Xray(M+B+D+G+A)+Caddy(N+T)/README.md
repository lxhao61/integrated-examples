介绍：

Xray 前置（监听 443 端口），利用 VLESS+Vision+REALITY 支持转发给自己的网站及 Caddy 支持 WebSocket、H2C、gRPC 代理与 forwardproxy、caddy-trojan 插件应用，实现除 Xray 的 mKCP 应用外各应用共用 443 端口，其应用如下：

1、M=VLESS+Vision+REALITY（转发配置，REALITY 由自己启用及处理。）

2、B=VMess+WebSocket+TLS（TLS 由 Caddy 提供及处理，不需配置。）

3、D=VLESS+H2C+TLS（TLS 由 Caddy 提供及处理，不需配置。）

4、G=Shadowsocks+gRPC+TLS（TLS 由 Caddy 提供及处理，不需配置。）

5、A=VLESS+mKCP+seed

6、N=NaiveProxy（基于 Caddy 的改进版 forwardproxy 插件实现，TLS 由 Caddy 提供及处理，不需配置。）

7、T=Trojan-Go（基于 Caddy 的 caddy-trojan 插件实现，TLS 由 Caddy 提供及处理，不需配置。）

注意：

1、Xray 版本不小于 v1.8.0 才支持 REALITY，其同步 uTLS（强制客户端必须使用指纹伪造）。

2、Xray 的监听地址不支持 Shadowsocks 协议使用 UDS 监听。

3、Xray 的 Shadowsocks 2022 新协议提升了性能并带有完整的重放保护。

4、Caddy 版本不小于 v2.7.0 才默认支持 PROXY protocol 接收。若 Caddy 版本小于 v2.7.0 需加 caddy2-proxyprotocol 插件定制编译才支持 PROXY protocol 接收。

5、Caddy 版本不小于 v2.6.0 才支持 H2C/gRPC 代理的 UDS 转发。

6、使用本人 Releases 中编译好的 Caddy 文件，可同时支持 NaiveProxy、Trojan-Go 及 PROXY protocol 接收等应用。

7、本示例 NaiveProxy 仅支持 HTTP/2 代理应用，即 HTTPS 协议传输。

8、本示例 Trojan-Go 仅推荐使用 Trojan 应用（不使用 WebSocket 应用）：因为已有同类 WebSocket 应用，且其 WebSocket 应用不支持 WebSocket 0-RTT 与多路复用等；另外还可使用 [Trojan+WebSocket+TLS](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(Trojan%2BWebSocket)%2BNginx%5CCaddy) 应用替代，性能及兼容性更好。客户端推荐选择 Xray 客户端，支持使用指纹伪造。

9、本示例所需 TLS 证书由 Caddy（内置 ACME 客户端） 提供，实现 TLS 证书自动申请及更新。

10、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol。配置2：使用 UDS 连接（对应 Shadowsocks+gRPC+TLS 除外），且启用了 PROXY protocol。
