介绍：

利用 Caddy 支持 WebSocket、H2C、gRPC 代理与 forwardproxy、caddy-trojan 插件应用，实现除 Xray 或 V2Ray 的 mKCP 应用外，WebSocket、H2C、gRPC 三种类型的反向代理应用与 forwardproxy、caddy-trojan 插件应用共用443端口，其应用如下：

1、B=VMess+WebSocket+TLS（TLS由Caddy提供及处理，不需配置。）

2、D=VLESS+H2C+TLS（TLS由Caddy提供及处理，不需配置。）

3、G=Shadowsocks+gRPC+TLS（TLS由Caddy提供及处理，不需配置。）

4、A=VLESS+mKCP+seed

5、N=NaiveProxy（基于Caddy的改进版forwardproxy插件实现，TLS由Caddy提供及处理。）

6、T=Trojan-Go（基于Caddy的caddy-trojan插件实现，TLS由Caddy提供及处理。）

注意：

1、Xray 或 V2Ray 的监听地址不支持 Shadowsocks（简称SS） 协议使用 UDS 监听。

2、Xray 版本不小于 v1.4.0 或 v2ray 版本不小于 v4.36.2 才支持 gRPC 传输方式。

3、Caddy 版本不小于 v2.2.0 才支持 H2C proxy，即支持 Xray 或 V2Ray 的 H2C（gRPC） 反向代理。Caddy 版本不小于 v2.6.0 才支持 H2C proxy 的 UDS 转发。

4、使用本人 Releases 中编译好的 Caddy 文件，可同时支持 H2C proxy、Trojan-Go、NaiveProxy 等应用。

5、本示例中 NaiveProxy 除了支持 HTTP/2 代理应用，还同时支持 HTTP/3 代理应用，即 QUIC 协议传输。

6、若 NaiveProxy 使用 HTTP/3 代理应用，即 QUIC 协议传输，建议增加 [UDP 接收缓冲区大小](https://github.com/lucas-clemente/quic-go/wiki/UDP-Receive-Buffer-Size)。

7、本示例中 Trojan-Go 兼容原版 Trojan-Go，继承了其服务端核心特色：支持 Trojan 应用与 Trojan-Go 的 WebSocket 应用共存；支持 CDN 流量中转(基于 WebSocket over TLS)。

8、本示例 Caddy 支持自动 HTTPS，即自动申请与更新 TLS 证书，自动 HTTP 重定向到 HTTPS。

9、配置1：使用 Local Loopback 连接。配置2：使用 UDS 连接（对应 Shadowsocks+gRPC+TLS 除外）。
