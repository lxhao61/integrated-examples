介绍：

v2ray 或 Xray 前置（监听 443 端口），利用 vless+tcp+tls 或 vless+tcp+xtls 强大的回落/分流 WebSocket（WS）特性与 caddy 为 H2C 与 gRPC 提供反向代理、为 naiveproxy 提供正向代理，实现除 v2ray 或 Xray 的 KCP 应用外共用 443 端口。其应用如下：

1、E=vless+tcp+tls/xtls（回落/分流配置，TLS/XTLS由自己提供及处理。）

2、B=vless+ws+tls（TLS由vless+tcp+tls/xtls提供及处理，不需配置。另可改、可增其它WS类应用，参考对应的服务端单一应用配置示例。）

3、C=shadowsocks+xray-plugin/v2ray-plugin+tls（TLS由vless+tcp+tls/xtls提供及处理，不需配置。）

4、D=vless+h2c+tls（TLS由vless+tcp+tls/xtls提供及处理，不需配置。另可改、可增其它H2C类应用，参考对应的服务端单一应用配置示例。）

5、G=vless+grpc+tls（TLS由vless+tcp+tls/xtls提供及处理，不需配置。另可改、可增其它gRPC类应用，参考对应的服务端单一应用配置示例。）

6、A=vless+kcp+seed（可改成vmess+kcp+seed，或添加它。）

7、naiveproxy（基于caddy的改进版forwardproxy插件实现，TLS由vless+tcp+tls/xtls提供及处理，不需配置。）

注意：

1、Xray 版本不小于 v1.4.0 或 v2ray 版本不小于 v4.36.2 才支持 gRPC 传输方式。

2、caddy 版本不小于 v2.2.0 才支持 H2C proxy，即支持 Xray 或 v2ray 的 H2C（gRPC） 反向代理。caddy 版本不小于 v2.6.0 才支持 H2C proxy 的 Unix Domain Socket（UDS） 转发。

3、caddy 版本不小于 v2.3.0 才支持 Caddyfile 配置开启 H2C server。

4、caddy 支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程。

5、使用本人 Releases 中编译好的 caddy 文件，可同时支持 H2C server、H2C proxy、naiveproxy 及接收 PROXY protocol 等应用。

6、本示例中 naiveproxy 仅支持 HTTP/2 代理应用，即 HTTPS 协议传输。

7、Xray 所需 SSL/TLS 证书推荐使用 caddy 自动申请，配合 Xray 支持自动热重载 SSL/TLS 证书，可实现 Xray 所需 SSL/TLS 证书更新全自动化。

8、本示例 caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可（完全等效）。若使用 caddy 自动申请 SSL/TLS 证书推荐使用 json 格式配置，优化更好。

9、不要使用第三方 ACME 客户端在当前服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 SSL/TLS 证书，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 SSL/TLS 证书需监听 80 或 443 端口，从而与当前应用端口冲突。

10、配置1：采用端口回落/分流、端口转发。配置2：采用进程回落/分流（shadowsocks+xray-plugin/v2ray-plugin+tls 除外）、进程转发。配置3：采用进程回落/分流（shadowsocks+xray-plugin/v2ray-plugin+tls 除外）、进程转发，且启用了 PROXY protocol。
