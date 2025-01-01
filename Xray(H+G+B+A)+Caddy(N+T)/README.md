介绍：

利用 Caddy 支持 XHTTP、gRPC、HTTPUpgrade 反向代理与 forwardproxy、caddy-trojan 插件应用，实现除 Xray 的 mKCP 应用外各应用共用 443 端口，其应用如下：

1、H=VLESS+XHTTP+TLS（反代配置，TLS 由 Caddy 提供及处理。）

2、G=Shadowsocks+gRPC+TLS（反代配置，TLS 由 Caddy 提供及处理。）

3、B=VMess+HTTPUpgrade+TLS（反代配置，TLS 由 Caddy 提供及处理。）

4、A=VLESS+mKCP+seed

5、N=NaiveProxy（基于 Caddy 的改进版 forwardproxy 插件实现，TLS 由 Caddy 提供及处理。）

6、T=Trojan-Go（基于 Caddy 的 caddy-trojan 插件实现，TLS 由 Caddy 提供及处理。）

注意：

1、Xray 的监听地址不支持 Shadowsocks 协议使用 UDS 监听。

2、Xray 版本不小于 v24.11.30 才支持完全体 XHTTP，其 XHTTP 传输方式实现了真正的上下行分离（见客户端配置示例），给 GFW 针对单个连接的分析带来了麻烦。

3、Caddy 版本不小于 v2.6.0 才支持 H2C 反向代理的 UDS 转发。

4、使用本人 Releases 中编译好的 Caddy 文件，可同时支持 NaiveProxy、Trojan-Go 等应用。

5、本示例 Caddy 支持自动 HTTPS，即自动申请与更新 TLS 证书，自动 HTTP 重定向到 HTTPS。

6、本示例 T 仅推荐使用 Trojan 应用（不使用 WebSocket 应用）：因为已有升级 HTTPUpgrade 应用，且其 WebSocket 应用不支持 WebSocket 0-RTT 与多路复用；另外还可加 [Trojan+WebSocket+TLS](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(Trojan%2BWebSocket)%2BNginx%5CCaddy) 应用替代，性能及兼容性更好。客户端推荐选用 Xray 客户端，支持指纹伪造。

7、本示例 H、N 均支持 HTTP/3 传输。若想要由 Caddy 处理的 HTTP/3 应用高速传输，建议[增加服务端系统的 UDP 缓冲区大小](https://github.com/quic-go/quic-go/wiki/UDP-Buffer-Sizes)。

8、配置1：使用 Local Loopback 连接。配置2：使用 UDS 连接（对应 Shadowsocks+gRPC+TLS 除外）。
