介绍：

Xray 前置（监听 443 端口），利用 VLESS+Vision+TLS 回落给 Caddy 处理，Caddy 为 XHTTP 提供反向代理，实现除 Xray 的 mKCP 应用外各应用共用 TCP 443 端口，其应用如下：

1、E=VLESS+Vision+TLS（回落/分流配置，TLS 由自己启用及处理。）

2、H=VLESS+XHTTP+TLS（反代配置，TLS 由 E 启用及处理或由 Caddy 提供及处理。）

3、A=VLESS+mKCP+seed

注意：

1、Xray 版本不小于 v24.11.30 才支持完全体 XHTTP，其 XHTTP 传输方式实现了真正的上下行分离（见客户端配置示例），给 GFW 针对单个连接的分析带来了麻烦。

2、Caddy 支持 H2C server 与 HTTP/1.1 server 共用一个端口或一个进程。

3、Caddy 版本不小于 v2.9.0 才支持 HTTP/3 转 H2C 反向代理。

4、本示例所需 TLS 证书由 Caddy（内置 ACME 客户端） 提供，实现 TLS 证书自动申请及更新。

5、本示例中 H 支持 HTTP/3 传输。若想要由 Caddy 处理的 HTTP/3 应用高速传输，建议[增加服务端系统的 UDP 缓冲区大小](https://github.com/quic-go/quic-go/wiki/UDP-Buffer-Sizes)。

6、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol。配置2：使用 UDS 连接，且启用了 PROXY protocol。
