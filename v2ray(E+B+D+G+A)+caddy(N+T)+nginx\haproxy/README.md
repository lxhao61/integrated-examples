介绍：

利用 nginx 或 haproxy 支持 SNI 分流特性，对 vless+tcp+tls 或 vless+tcp+xtls、HTTPS server 进行 SNI 分流（四层转发），实现除 v2ray 或 Xray 的 KCP 应用外共用 443 端口。其中 vless+tcp+tls 或 vless+tcp+xtls 为 WebSocket（WS） 提供分流转发；caddy 为 vless+tcp+tls 或 vless+tcp+xtls 提供回落服务，为 v2ray 或 Xray 的 H2C 与 gRPC 进行反向代理，为 naiveproxy 与 trojan-go 提供正向代理。包括应用如下：

1、E=vless+tcp+tls/xtls（回落/分流配置，TLS/XTLS由自己提供及处理。）

2、B=vmess+ws+tls（TLS由vless+tcp+tls/xtls提供及处理，不需配置。）

3、D=vless+h2c+tls（TLS由caddy提供及处理，不需配置。）

4、G=shadowsocks+grpc+tls（TLS由caddy提供及处理，不需配置。）

5、A=vless+kcp+seed

6、naiveproxy（基于caddy的改进版forwardproxy插件实现，TLS由caddy提供及处理。）

7、trojan-go（基于caddy的caddy-trojan插件实现，TLS由caddy提供及处理。）

注意：

1、nginx 支持 SNI 分流，需要 nginx 包含 stream_core_module 和 stream_ssl_preread_module 模块。

2、采用 SNI 方式实现共用 443 端口，支持各自特色应用，但需多个域名来标记分流。

3、Xray 或 v2ray 的监听地址不支持 shadowsocks（SS） 协议使用 UDS 监听。

4、Xray 版本不小于 v1.4.0 或 v2ray 版本不小于 v4.36.2 才支持 gRPC 传输方式。

5、caddy 版本不小于 v2.2.0 才支持 H2C proxy，即支持 Xray 或 v2ray 的 H2C（gRPC） 反向代理。caddy 版本不小于 v2.6.0 才支持 H2C proxy 的 UDS 转发。

6、caddy 版本不小于 v2.3.0 才支持 Caddyfile 配置开启 H2C server。

7、caddy 支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程。

8、使用本人 Releases 中编译好的 caddy 文件，可同时支持 H2C server、H2C proxy、trojan-go、naiveproxy 及接收 PROXY protocol 等应用。

9、本示例中 trojan-go 兼容原版 trojan-go，继承了其服务端核心特色：支持 trojan 应用与 trojan-go 的 WebSocket 应用共存；支持 CDN 流量中转(基于 WebSocket over TLS)。

10、Xray 所需 SSL/TLS 证书推荐使用 caddy 自动申请，配合 Xray 支持自动热重载 SSL/TLS 证书，可实现 Xray 所需 SSL/TLS 证书更新全自动化。

11、本示例 caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可（完全等效）。推荐使用 json 格式配置（无嵌套），优化好。

12、不要使用第三方 ACME 客户端在当前服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 SSL/TLS 证书，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 SSL/TLS 证书需监听 80 或 443 端口，从而与当前应用端口冲突。

13、配置1：采用端口分流、端口回落/分流、端口转发，且启用了 PROXY protocol。配置2：采用进程分流、进程回落/分流、进程转发，且启用了 PROXY protocol。

14、若采用配置2、且使用 nginx SNI 来分流的，想 naiveproxy 同时开启 HTTP/3 代理支持，可参考配置1。方法：nginx 中添加对应 HTTPS server 的定向 UDP 转发配置，对应 HTTPS server 的进程转发改为端口转发；caddy 中对应 HTTPS server 的进程监听改为端口监听，HTTPS server 开启 HTTP/3 支持。

15、若除了实现最多应用的科学上网、还需提供实际网站服务，推荐本示例（实际网站服务可由 nginx 或 caddy 提供服务）；否则推荐采用 [v2ray(E+B+D+G+A)+caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BD%2BG%2BA)%2Bcaddy(N%2BT)) 示例。
