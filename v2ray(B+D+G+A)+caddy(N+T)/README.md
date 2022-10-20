介绍：

利用 caddy 支持 WebSocket（WS）、H2C、gRPC 代理及 naiveproxy 与 trojan-go 代理，实现除 Xray 或 v2ray 的 mKCP 应用外，WebSocket（WS）、H2C、gRPC 类反向代理应用及 naiveproxy 与 trojan-go 正向代理应用共用443端口。包括应用如下：

1、B=vmess+ws+tls（TLS由caddy提供及处理，不需配置。）

2、D=vless+h2c+tls（TLS由caddy提供及处理，不需配置。）

3、G=shadowsocks+grpc+tls（TLS由caddy提供及处理，不需配置。）

4、A=vless+kcp+seed

5、naiveproxy（基于caddy的改进版forwardproxy插件实现，TLS由caddy提供及处理。）

6、trojan-go（基于caddy的caddy-trojan插件实现，TLS由caddy提供及处理。）

注意：

1、Xray 或 v2ray 的监听地址不支持 shadowsocks（SS） 协议使用 UDS 监听。

2、Xray 版本不小于 v1.4.0 或 v2ray 版本不小于 v4.36.2 才支持 gRPC 传输方式。

3、caddy 版本不小于 v2.2.0 才支持 H2C proxy，即支持 Xray 或 v2ray 的 H2C（gRPC） 反向代理。caddy 版本不小于 v2.6.0 才支持 H2C proxy 的 UDS 转发。

4、使用本人 Releases 中编译好的 caddy 文件，可同时支持 H2C proxy、trojan-go、naiveproxy 等应用。

5、本示例中 naiveproxy 除了支持 HTTP/2 代理应用，还同时支持 HTTP/3 代理应用，即 QUIC 协议传输。

6、本示例中 trojan-go 兼容原版 trojan-go，继承了其服务端核心特色：支持 trojan 应用与 trojan-go 的 WebSocket 应用共存；支持 CDN 流量中转(基于 WebSocket over TLS)。

7、本示例 caddy 支持自动 HTTPS，即自动申请与更新 SSL/TLS 证书，自动 HTTP 重定向到 HTTPS。

8、配置1：使用 Local Loopback 连接。配置2：使用 UDS 连接（对应 shadowsocks+grpc+tls 除外，使用 Local Loopback 连接。）。
