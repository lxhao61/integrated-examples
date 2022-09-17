介绍：

利用 caddy 支持 SNI 分流特性，对 vless+tcp+tls 或 vless+tcp+xtls、trojan-go 或 trojan、HTTPS server 进行 SNI 分流（四层转发），实现除 v2ray 或 Xray 的 KCP 应用外共用 443 端口。其中 vless+tcp+tls 或 vless+tcp+xtls 为 WebSocket（WS） 提供分流转发；caddy 同时为 vless+tcp+tls 或 vless+tcp+xtls 与 trojan-go 或 trojan 提供回落服务，为 v2ray 或 Xray 的 H2C 与 gRPC 进行反向代理，为 naiveproxy 提供正向代理。包括应用如下：

1、E=vless+tcp+tls/xtls（回落/分流配置，TLS/XTLS由自己提供及处理。）

2、B=vless+ws+tls（TLS由vless+tcp+tls/xtls提供及处理，不需配置。另可改、可增其它WS类应用，参考对应的服务端单一应用配置示例。）

3、C=shadowsocks+xray-plugin/v2ray-plugin+tls（TLS由vless+tcp+tls/xtls提供及处理，不需配置。）

4、D=vless+h2c+tls（TLS由caddy提供及处理，不需配置。另可改、可增其它H2C类应用，参考对应的服务端单一应用配置示例。）

5、G=vless+grpc+tls（TLS由caddy提供及处理，不需配置。另可改、可增其它gRPC类应用，参考对应的服务端单一应用配置示例。）

6、A=vless+kcp+seed（可改成vmess+kcp+seed，或添加它。）

7、naiveproxy（基于caddy的改进版forwardproxy插件实现，TLS由caddy提供及处理。）

8、trojan-go或trojan（TLS由自己提供及处理。）

注意：

1、caddy 加 caddy-l4 插件定制编译的才可以实现 SNI 分流，目前仅支持使用 json 配置（不支持 Caddyfile 配置）。

2、采用 SNI 方式实现共用 443 端口，支持各自特色应用，但需多个域名来标记分流。

3、Xray 版本不小于 v1.4.0 或 v2ray 版本不小于 v4.36.2 才支持 gRPC 传输方式。

4、因 trojan-go 或 trojan 不支持 Unix Domain Socket（UDS） 监听接收与回落转发，故 caddy SNI 分流 trojan-go 或 trojan 仅启用端口转发；故与 trojan-go 或 trojan 共用 WEB 服务的 vless+tcp+xtls 或 vless+tcp+tls 回落也仅端口回落，即全部端口回落。

5、因 trojan-go 或 trojan 不支持 PROXY protocol，故 caddy SNI 分流 trojan-go 或 trojan 不启用此项应用；故与 trojan-go 或 trojan 共用 WEB 服务的 vless+tcp+xtls 或 vless+tcp+tls 回落也不启用此项应用，即全部回落不启用此项应用。

6、trojan-go 完全兼容 trojan，服务端还有自己的特色：支持 trojan 应用与自己的 WebSocket 应用共存；支持 CDN 流量中转(基于 WebSocket over TLS)；支持使用 AEAD 对 trojan 协议流量进行二次加密(基于 Shadowsocks AEAD)。

7、caddy 版本不小于 v2.2.0 才支持 H2C proxy，即支持 Xray 或 v2ray 的 H2C（gRPC） 反向代理。caddy 版本不小于 v2.6.0 才支持 H2C proxy 的 Unix Domain Socket（UDS） 转发。

8、caddy 支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程。

9、使用本人 Releases 中编译好的 caddy 文件，可同时支持 SNI 分流、H2C server、H2C proxy、naiveproxy 及 PROXY protocol 等应用。

10、本示例中 naiveproxy 仅支持 HTTP/2 代理应用，即 HTTPS 协议传输。

11、Xray 所需 SSL/TLS 证书推荐使用 caddy 自动申请，配合 Xray 支持自动热重载 SSL/TLS 证书，可实现 Xray 所需 SSL/TLS 证书更新全自动化。

12、不要使用第三方 ACME 客户端在当前服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 SSL/TLS 证书，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 SSL/TLS 证书需监听 80 或 443 端口，从而与当前应用端口冲突。

13、配置1：采用端口分流、端口回落/分流、端口转发。配置2：采用进程分流（trojan-go/trojan 除外）、端口回落/分流（vless+ws+tls 除外）、进程转发。配置3：采用进程分流（trojan-go/trojan 除外）、端口回落/分流（vless+ws+tls 除外）、进程转发，且启用了 PROXY protocol（全部回落除外）。

14、若有实际网站服务推荐采用 [v2ray(E+B+C+D+G+A)+trojan+naiveproxy+nginx\haproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BC%2BD%2BG%2BA)%2Btrojan%2Bnaiveproxy%2Bnginx%5Chaproxy) 示例，否则 caddy 的压力可能过大。
