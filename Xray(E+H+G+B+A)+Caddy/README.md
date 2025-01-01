介绍：

Xray 前置（监听 443 端口），利用 VLESS+Vision+TLS 回落/分流特点先分流出 HTTPUpgrade 应用，其余的回落给 Caddy 处理，Caddy 为 XHTTP、gRPC 提供反向代理，实现除 Xray 的 mKCP 应用外各应用共用 443 端口，其应用如下：

1、E=VLESS+Vision+TLS（回落/分流配置，TLS 由自己启用及处理。）

2、H=VLESS+XHTTP+TLS（反代配置，TLS 由 VLESS+Vision+TLS 启用及处理。）

3、G=Shadowsocks+gRPC+TLS（反代配置，TLS 由 VLESS+Vision+TLS 启用及处理。）

4、B=VMess+HTTPUpgrade+TLS（分流配置，TLS 由 VLESS+Vision+TLS 启用及处理。）

5、A=VLESS+mKCP+seed

注意：

1、Xray 的监听地址不支持 Shadowsocks 协议使用 UDS 监听。

2、Xray 版本不小于 v24.11.30 才支持完全体 XHTTP，其 XHTTP 传输方式实现了真正的上下行分离（见客户端配置示例），给 GFW 针对单个连接的分析带来了麻烦。

3、Caddy 支持 H2C server 与 HTTP/1.1 server 共用一个端口或一个进程。

4、Caddy 版本不小于 v2.6.0 才支持 H2C 反向代理的 UDS 转发。

5、Caddy 版本不小于 v2.7.0 才默认支持 PROXY protocol 接收。若 Caddy 版本小于 v2.7.0 需加 caddy2-proxyprotocol 插件定制编译才支持 PROXY protocol 接收。

6、本示例所需 TLS 证书由 Caddy（内置 ACME 客户端） 提供，实现 TLS 证书自动申请及更新。

7、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol。配置2：使用 UDS 连接（对应 Shadowsocks+gRPC+TLS 除外），且启用了 PROXY protocol。
