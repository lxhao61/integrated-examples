介绍：

利用 caddy 支持 SNI 分流特性，对 vless+tcp+tls 或 vless+tcp+xtls、trojan+tcp+tls 或 trojan+tcp+xtls、HTTPS server 进行 SNI 分流（四层转发），实现除 v2ray 或 Xray 的 mKCP 应用外共用 443 端口。其中 vless+tcp+tls 或 vless+tcp+xtls、trojan+tcp+tls 或 trojan+tcp+xtls 为 WebSocket（WS） 提供分流转发；caddy 同时为 vless+tcp+tls 或 vless+tcp+xtls 与 trojan+tcp+tls 或 trojan+tcp+xtls 提供回落服务，为 v2ray 或 Xray 的 H2C 与 gRPC 进行反向代理，为 naiveproxy 提供正向代理。包括应用如下：

1、E=vless+tcp+tls/xtls（回落/分流配置，TLS/XTLS由自己提供及处理。）

2、B=vmess+ws+tls（TLS由vless+tcp+tls/xtls提供及处理，不需配置。）

3、F=trojan+tcp+tls/xtls（回落/分流配置，TLS/XTLS由自己提供及处理。）

4、C=trojan+ws+tls（TLS由trojan+tcp+tls/xtls提供及处理，不需配置。）

5、D=vless+h2c+tls（TLS由caddy提供及处理，不需配置。）

6、G=shadowsocks+grpc+tls（TLS由caddy提供及处理，不需配置。）

7、A=vless+kcp+seed

8、naiveproxy（基于caddy的改进版forwardproxy插件实现，TLS由caddy提供及处理。）

注意：

1、caddy 加 caddy-l4 插件定制编译的才可以实现 SNI 分流，目前仅支持使用 json 配置（不支持 Caddyfile 配置）。

2、采用 SNI 方式实现共用 443 端口，支持各自特色应用，但需多个域名来标记分流。

3、Xray 或 v2ray 的监听地址不支持 shadowsocks（SS） 协议使用 UDS 监听。

4、Xray 版本不小于 v1.4.0 或 v2ray 版本不小于 v4.36.2 才支持 gRPC 传输方式。

5、caddy 版本不小于 v2.2.0 才支持 H2C proxy，即支持 Xray 或 v2ray 的 H2C（gRPC） 反向代理。caddy 版本不小于 v2.6.0 才支持 H2C proxy 的 UDS 转发。

6、caddy 支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程。

7、使用本人 Releases 中编译好的 caddy 文件，可同时支持SNI 分流、H2C server、H2C proxy、naiveproxy 及 PROXY protocol 等应用。

8、本示例中 naiveproxy 仅支持 HTTP/2 代理应用，即 HTTPS 协议传输。

9、Xray 所需 SSL/TLS 证书推荐使用 caddy 自动申请，配合 Xray 支持自动热重载 SSL/TLS 证书，可实现 Xray 所需 SSL/TLS 证书更新全自动化。

10、不要使用第三方 ACME 客户端在当前服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 SSL/TLS 证书，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 SSL/TLS 证书需监听 80 或 443 端口，从而与当前应用端口冲突。

11、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol。配置2：使用 UDS 连接（对应 shadowsocks+grpc+tls 除外，使用 Local Loopback 连接。），且启用了 PROXY protocol。

12、若有实际网站服务推荐采用 [v2ray(E+B+F+C+D+G+A)+caddy(N)+nginx\haproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BF%2BC%2BD%2BG%2BA)%2Bcaddy(N)%2Bnginx%5Chaproxy) 示例，否则 caddy 的压力可能过大。

13、本示例 F 兼容原版 trojan 应用，F+C 组合等同于 trojan-go 应用；即可使用 trojan 客户端 或 trojan-go 客户端对应连接。
