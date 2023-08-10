介绍：

Xray 前置（监听 443 端口），利用 VLESS+Vision+TLS 回落/分流 WebSocket 特点及 Caddy 为 gRPC 提供反向代理，实现除 Xray 的 mKCP 应用外各应用共用 443 端口，其应用如下：

1、E=VLESS+Vision+TLS（回落/分流配置，TLS 由自己启用及处理。）

2、B=VMess+WebSocket+TLS（TLS 由 VLESS+Vision+TLS 启用及处理，不需配置。）

3、G=Shadowsocks+gRPC+TLS（TLS 由 VLESS+Vision+TLS 启用及处理，不需配置。）

4、A=VLESS+mKCP+seed

注意：

1、Xray 版本不小于 v1.7.2 才完美支持 VLESS 协议的 XTLS Vision 应用。

2、Xray 的监听地址不支持 Shadowsocks 协议使用 UDS 监听。

3、Xray 的 Shadowsocks 2022 新协议提升了性能并带有完整的重放保护。

4、Caddy 支持 H2C server 与 HTTP/1.1 server 共用一个端口或一个进程。

5、Caddy 版本不小于 v2.7.0 才默认支持 PROXY protocol 接收。若 Caddy 版本小于 v2.7.0 需加 caddy2-proxyprotocol 插件定制编译才支持 PROXY protocol 接收。

6、Caddy 版本不小于 v2.6.0 才支持 H2C/gRPC 代理的 UDS 转发。

7、本示例所需 TLS 证书由 Caddy（内置 ACME 客户端） 提供，实现 TLS 证书自动申请及更新。

8、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol。配置2：使用 UDS 连接（对应 Shadowsocks+gRPC+TLS 除外），且启用了 PROXY protocol。
