介绍：

利用 caddy 支持 SNI 分流特性，对 vless+tcp+tls 或 vless+tcp+xtls、trojan-go 或 trojan、HTTPS server 进行 SNI 分流（四层转发），实现除 v2ray 或 Xray 的 mKCP 应用外共用 443 端口。其中 vless+tcp+tls 或 vless+tcp+xtls 为 WebSocket（WS） 提供分流转发；caddy 同时为 vless+tcp+tls 或 vless+tcp+xtls 与 trojan-go 或 trojan 提供回落服务，为 v2ray 或 Xray 的 H2C 与 gRPC 进行反向代理，为 naiveproxy 提供正向代理。包括应用如下：

1、E=vless+tcp+tls/xtls（回落/分流配置，TLS/XTLS由自己提供及处理。）

2、B=vmess+ws+tls（TLS由vless+tcp+tls/xtls提供及处理，不需配置。）

3、D=vless+h2c+tls（TLS由caddy提供及处理，不需配置。）

4、G=shadowsocks+grpc+tls（TLS由caddy提供及处理，不需配置。）

5、A=vless+kcp+seed

6、naiveproxy（基于caddy的改进版forwardproxy插件实现，TLS由caddy提供及处理。）

7、trojan-go或trojan（TLS由自己提供及处理。）

注意：

1、caddy 加 caddy-l4 插件定制编译的才可以实现 SNI 分流，目前仅支持使用 json 配置（不支持 Caddyfile 配置）。

2、采用 SNI 方式实现共用 443 端口，支持各自特色应用，但需多个域名来标记分流。

3、Xray 或 v2ray 的监听地址不支持 shadowsocks（SS） 协议使用 UDS 监听。

4、Xray 版本不小于 v1.4.0 或 v2ray 版本不小于 v4.36.2 才支持 gRPC 传输方式。

5、因 trojan-go 或 trojan 不支持 UDS，故 caddy SNI 分流 trojan-go 或 trojan 使用 Local Loopback 连接；故与 trojan-go 或 trojan 共用 WEB 服务的 vless+tcp+xtls 或 vless+tcp+tls 回落也不能使用 UDS 连接，即全部回落使用 Local Loopback 连接。

6、因 trojan-go 或 trojan 不支持 PROXY protocol，故 caddy SNI 分流 trojan-go 或 trojan 不启用 PROXY protocol；故与 trojan-go 或 trojan 共用 WEB 服务的 vless+tcp+xtls 或 vless+tcp+tls 回落也不能启用 PROXY protocol，即全部回落不启用 PROXY protocol。

7、trojan-go 完全兼容 trojan，服务端还有自己的特色：支持 trojan 应用与自己的 WebSocket 应用共存；支持 CDN 流量中转(基于 WebSocket over TLS)；支持使用 AEAD 对 trojan 协议流量进行二次加密(基于 Shadowsocks AEAD)。

8、caddy 版本不小于 v2.2.0 才支持 H2C proxy，即支持 Xray 或 v2ray 的 H2C（gRPC） 反向代理。caddy 版本不小于 v2.6.0 才支持 H2C proxy 的 UDS 转发。

9、caddy 支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程。

10、使用本人 Releases 中编译好的 caddy 文件，可同时支持 SNI 分流、H2C server、H2C proxy、naiveproxy 及 PROXY protocol 等应用。

11、本示例中 naiveproxy 仅支持 HTTP/2 代理应用，即 HTTPS 协议传输。

12、本示例中 V2Ray 或 Xray 与 Trojan-Go 或 Trojan 所需 TLS 证书由 Caddy 提供，实现 TLS 证书自动申请及更新，且同步 V2Ray 或 Trojan-Go 或 Trojan 重载 TLS 证书或 Xray 自动热重载 TLS 证书。

13、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol（全部回落除外）。配置2：使用混合连接（能 UDS 连接的全部 UDS 连接），且启用了 PROXY protocol（全部回落除外）。

14、若有实际网站服务推荐采用 [v2ray(E+B+D+G+A)+trojan+caddy(N)+nginx\haproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BD%2BG%2BA)%2Btrojan%2Bcaddy(N)%2Bnginx%5Chaproxy) 示例，否则 caddy 的压力可能过大。
