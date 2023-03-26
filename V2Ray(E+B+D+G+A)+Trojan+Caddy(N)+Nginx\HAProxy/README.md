介绍：

利用 Nginx 或 HAProxy 支持 SNI 分流特性，对 VLESS+TCP+TLS、Trojan-Go 或 Trojan、HTTPS server 进行 SNI 分流（四层转发），实现除 Xray 或 V2Ray 的 mKCP 应用外共用 443 端口。其中 VLESS+TCP+TLS 为 WebSocket 提供分流转发；Caddy 为 VLESS+TCP+TLS 与 Trojan-Go 或 Trojan 提供回落服务，为 Xray 或 V2Ray 的 H2C 与 gRPC 进行反向代理，为 forwardproxy 插件提供正向代理，其应用如下：

1、E=VLESS+TCP+TLS（回落/分流配置，TLS由自己启用及处理。）

2、B=VMess+WebSocket+TLS（TLS由VLESS+TCP+TLS启用及处理，不需配置。）

3、D=VLESS+H2C+TLS（TLS由Caddy提供及处理，不需配置。）

4、G=Shadowsocks+gRPC+TLS（TLS由Caddy提供及处理，不需配置。）

5、A=VLESS+mKCP+seed

6、N=NaiveProxy（基于Caddy的改进版forwardproxy插件实现，TLS由Caddy提供及处理。）

7、Trojan-Go或Trojan（TLS由自己启用及处理。）

注意：

1、Nginx 支持 SNI 分流需要 Nginx 包含 stream_core_module 和 stream_ssl_preread_module 模块。

2、采用 SNI 方式实现共用 443 端口，支持各自特色应用，但需多个域名来标记分流。

3、Xray 或 V2Ray 的监听地址不支持 Shadowsocks（简称SS） 协议使用 UDS 监听。

4、Xray 版本不小于 v1.4.0 或 V2Ray 版本不小于 v4.36.2 才支持 gRPC 传输方式。

5、因 Trojan-Go 或 Trojan 不支持 UDS，故 Nginx 或 HAProxy SNI 分流到 Trojan-Go 或 Trojan 使用 Local Loopback 连接；故与 Trojan-Go 或 Trojan 共用 WEB 服务的 VLESS+TCP+TLS 回落不能使用 UDS 连接，即全部回落也使用 Local Loopback 连接。

6、因 Trojan-Go 或 Trojan 不支持 PROXY protocol，故 Nginx SNI 分流启用 PROXY protocol 须特殊处理（具体见配置示例），或 HAProxy SNI 分流到 Trojan-Go 或 Trojan 不启用 PROXY protocol 发送；故与 Trojan-Go 或 Trojan 共用 WEB 服务的 VLESS+TCP+TLS 回落不能启用 PROXY protocol 发送，即全部回落也不启用 PROXY protocol。

7、Trojan-Go 完全兼容 Trojan，服务端还有自己的特色：支持 Trojan 应用与自己的 WebSocket 应用共存；支持 CDN 流量中转(基于 WebSocket over TLS)；支持使用 AEAD 对 Trojan 协议流量进行二次加密(基于 Shadowsocks AEAD)。

8、Caddy 版本不小于 v2.2.0 才支持 H2C proxy，即支持 Xray 或 V2Ray 的 H2C（gRPC） 反向代理。Caddy 版本不小于 v2.6.0 才支持 H2C proxy 的 UDS 转发。

9、Caddy 版本不小于 v2.3.0 才支持 Caddyfile 配置开启 H2C server。

10、Caddy 支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程。

11、使用本人 Releases 中编译好的 Caddy 文件，可同时支持 H2C server、H2C proxy、NaiveProxy 及接收 PROXY protocol 等应用。

12、本示例所需 TLS 证书由 Caddy（内置 ACME 客户端） 提供，实现 TLS 证书自动申请及更新。

13、V2Ray、Trojan-Go、Trojan 不支持‘证书热更新’功能，即 V2Ray、Trojan-Go、Trojan 不会自动识别 TLS 证书更新并重载 TLS 证书，可使用如下方法之一解决。

1）、Linux 类系统使用 Crontab 指令定时重启 V2Ray 与 Trojan-Go 或 Trojan 来重载更新后的 TLS 证书，其它系统使用类似命令/工具来定时重启 V2Ray 与 Trojan-Go 或 Trojan 来重载更新后的 TLS 证书。（通用办法）

2）、使用 caddy-events-exec 插件应用实现 TLS 证书自动更新后就执行重启 V2Ray 与 Trojan-Go 或 Trojan 来重载更新后的 TLS 证书，详见 ‘Caddy(Other Configuration) （Caddy的特殊应用配置方法。）’中对应介绍及对应配置示例。（专属办法）

14、本示例 Caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可（完全等效）。推荐使用 json 格式配置（无嵌套），优化好。

15、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol（全部回落除外）。配置2：使用混合连接（能 UDS 连接的全部 UDS 连接），且启用了 PROXY protocol（全部回落除外）。

16、若采用配置2、且使用 Nginx SNI 来分流的，想 NaiveProxy 同时开启 HTTP/3 代理支持，可参考配置1。方法：Nginx 中添加对应 HTTPS server 的定向 UDP 转发配置，对应 HTTPS server 的进程转发改为端口转发；Caddy 中对应 HTTPS server 的进程监听改为端口监听，HTTPS server 开启 HTTP/3 支持。

17、若 NaiveProxy 使用 HTTP/3 代理应用，即 QUIC 协议传输，建议增加 [UDP 接收缓冲区大小](https://github.com/lucas-clemente/quic-go/wiki/UDP-Receive-Buffer-Size)。

18、若仅实现科学上网、且不需要 NaiveProxy 支持 HTTP/3 代理应用，推荐采用 [V2Ray(E+B+D+G+A)+Trojan+Caddy(N)](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(E%2BB%2BD%2BG%2BA)%2BTrojan%2BCaddy(N)) 示例。
