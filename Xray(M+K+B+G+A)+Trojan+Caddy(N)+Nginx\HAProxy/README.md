介绍：

利用 Nginx 或 HAProxy 支持 SNI 分流特性，对 VLESS+Vision+REALITY、Trojan-Go或Trojan、HTTPS server 进行 SNI 分流（四层转发），实现除 Xray 的 mKCP 应用外共用 443 端口。其中 VLESS+Vision+REALITY 回落（套娃） VLESS+H2C；Caddy 为 Trojan-Go或Trojan 提供回落服务，为 Xray 的 WebSocket 与 gRPC 进行反向代理，为 forwardproxy 插件提供正向代理，其应用如下：

1、M=VLESS+Vision+REALITY（回落与转发配置，REALITY由自己启用及处理。）

2、K=VLESS+H2C+REALITY（REALITY由VLESS+Vision+REALITY启用及处理，不需配置。）

3、B=VMess+WebSocket+TLS（TLS由Caddy提供及处理，不需配置。）

4、G=Shadowsocks+gRPC+TLS（TLS由Caddy提供及处理，不需配置。）

5、A=VLESS+mKCP+seed

6、N=NaiveProxy（基于Caddy的改进版forwardproxy插件实现，TLS由Caddy提供及处理，不需配置。）

7、Trojan-Go或Trojan（TLS由自己启用及处理。）

注意：

1、Nginx 支持 SNI 分流需要 Nginx 包含 stream_core_module 和 stream_ssl_preread_module 模块。

2、采用 SNI 方式实现共用 443 端口，支持各自特色应用，但需多个域名来标记分流。

3、Xray 版本不小于 v1.8.0 才支持 REALITY 及同步 uTLS（强制客户端必须使用指纹伪造）。

4、Xray 的监听地址不支持 Shadowsocks（简称SS） 协议使用 UDS 监听。

5、因 Trojan-Go 或 Trojan 不支持 UDS，故 Nginx 或 HAProxy SNI 分流到 Trojan-Go 或 Trojan 使用 Local Loopback 连接；故回落到 WEB 服务也使用 Local Loopback 连接。

6、因 Trojan-Go 或 Trojan 不支持 PROXY protocol，故 Nginx SNI 分流启用 PROXY protocol 须特殊处理（具体见配置示例），或 HAProxy SNI 分流到 Trojan-Go 或 Trojan 不启用 PROXY protocol 发送；故提供回落的 WEB 服务也不启用 PROXY protocol 接收。

7、Trojan-Go 完全兼容 Trojan，服务端还有自己的特色：支持 Trojan 应用与自己的 WebSocket 应用共存；支持 CDN 流量中转(基于 WebSocket over TLS)；支持使用 AEAD 对 Trojan 协议流量进行二次加密(基于 Shadowsocks AEAD)。

8、Caddy 版本不小于 v2.2.0 才支持 H2C proxy，即支持 Xray 的 H2C（gRPC） 反向代理。Caddy 版本不小于 v2.6.0 才支持 H2C proxy 的 UDS 转发。

9、Caddy 版本不小于 v2.3.0 才支持 Caddyfile 配置开启 H2C server。

10、Caddy 支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程。

11、使用本人 Releases 中编译好的 Caddy 文件，可同时支持 H2C server、H2C proxy、NaiveProxy 及接收 PROXY protocol 等应用。

12、本示例所需 TLS 证书由 Caddy（内置 ACME 客户端） 提供，实现 TLS 证书自动申请及更新。

13、本示例 Caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可（完全等效）。推荐使用 json 格式配置（无嵌套），优化好。

14、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol（全部回落除外）。配置2：使用混合连接（能 UDS 连接的全部 UDS 连接），且启用了 PROXY protocol（全部回落除外）。

15、若采用配置2、且使用 Nginx SNI 来分流的，想 NaiveProxy 同时开启 HTTP/3 代理支持，可参考配置1。方法：Nginx 中添加对应 HTTPS server 的定向 UDP 转发配置，对应 HTTPS server 的进程转发改为端口转发；Caddy 中对应 HTTPS server 的进程监听改为端口监听，HTTPS server 开启 HTTP/3 支持。

16、若 NaiveProxy 使用 HTTP/3 代理应用，即 QUIC 协议传输，建议增加 [UDP 接收缓冲区大小](https://github.com/lucas-clemente/quic-go/wiki/UDP-Receive-Buffer-Size)。

17、若仅实现科学上网、且不需要 NaiveProxy 支持 HTTP/3 代理应用，推荐采用 [Xray(M+K+B+G+A)+Trojan+Caddy(N)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M%2BK%2BB%2BG%2BA)%2BTrojan%2BCaddy(N)) 示例。
