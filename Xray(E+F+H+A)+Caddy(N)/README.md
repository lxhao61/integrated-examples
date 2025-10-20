介绍：

利用 Caddy 支持 SNI 分流特性，对 VLESS+Vision+TLS、Trojan+RAW+TLS、HTTP/3 server 进行 SNI 分流（四层转发），实现除 Xray 的 mKCP 应用外各应用共用 TCP 443 端口。其中 Caddy 同时为 VLESS+Vision+TLS 与 Trojan+RAW+TLS 提供 Web 服务，为 Xray 的 XHTTP 提供反向代理，为 forwardproxy 插件提供正向代理，其应用如下：

1、E=VLESS+Vision+TLS（回落配置，TLS 由自己启用及处理。）

2、F=Trojan+RAW+TLS（回落配置，TLS 由自己启用及处理。）

3、H=VLESS+XHTTP+TLS（反代配置，TLS 由 Caddy 提供及处理。）

4、A=VLESS+mKCP+seed

5、N=NaiveProxy（基于 Caddy 的改进版 forwardproxy 插件实现，TLS 由 Caddy 提供及处理。）

注意：

1、Caddy 版本不小于 v2.9.1 加 caddy-l4 插件定制编译才可以实现 SNI 分流共用 TCP/UDP 端口（含定向 UDP 转发）。

2、Xray 版本不小于 v24.11.30 才支持完全体 XHTTP，其 XHTTP 传输方式实现了真正的上下行分离（见客户端配置示例），给 GFW 针对单个连接的分析带来了麻烦。

3、Caddy 支持 H2C server 与 HTTP/1.1 server 共用一个端口或一个进程。

4、使用本人 Releases 中编译好的 Caddy 文件，可同时支持 SNI 分流共用 TCP/UDP 端口（含定向 UDP 转发）、NaiveProxy 及 PROXY protocol 等应用。

5、本示例所需 TLS 证书由 Caddy（内置 ACME 客户端） 提供，实现 TLS 证书自动申请及更新。

6、本示例中 H、N 均支持 HTTP/3 传输。若想要由 Caddy 处理的 HTTP/3 应用高速传输，建议[增加服务端系统的 UDP 缓冲区大小](https://github.com/quic-go/quic-go/wiki/UDP-Buffer-Sizes)。

7、本示例中 F 虽然兼容原版 Trojan 服务端应用，但是原版 Trojan、Trojan-Go 客户端不支持指纹伪造，故不推荐使用原版 Trojan、Trojan-Go 客户端来连接。

8、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol。配置2：使用 UDS 连接（对应 HTTP/3 server 除外），且启用了 PROXY protocol。
