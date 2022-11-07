介绍：

利用 Nginx 或 HAProxy 支持 SNI 分流特性，对 vless+tcp+tls 或 vless+tcp+xtls、HTTPS server 进行 SNI 分流（四层转发），实现除 V2Ray 或 Xray 的 mKCP 应用外共用 443 端口。其中 vless+tcp+tls 或 vless+tcp+xtls 为 WebSocket（WS） 提供分流转发；Caddy 为 vless+tcp+tls 或 vless+tcp+xtls 提供回落服务，为 V2Ray 或 Xray 的 H2C 与 gRPC 进行反向代理，为 forwardproxy 与 caddy-trojan 插件提供正向代理，其应用如下：

1、E=vless+tcp+tls/xtls（回落/分流配置，TLS/XTLS由自己提供及处理。）

2、B=vmess+ws+tls（TLS由vless+tcp+tls/xtls提供及处理，不需配置。）

3、D=vless+h2c+tls（TLS由Caddy提供及处理，不需配置。）

4、G=shadowsocks+grpc+tls（TLS由Caddy提供及处理，不需配置。）

5、A=vless+kcp+seed

6、NaïveProxy（基于Caddy的改进版forwardproxy插件实现，TLS由Caddy提供及处理。）

7、Trojan-Go（基于Caddy的caddy-trojan插件实现，TLS由Caddy提供及处理。）

注意：

1、Nginx 支持 SNI 分流，需要 Nginx 包含 stream_core_module 和 stream_ssl_preread_module 模块。

2、采用 SNI 方式实现共用 443 端口，支持各自特色应用，但需多个域名来标记分流。

3、Xray 或 V2Ray 的监听地址不支持 Shadowsocks（SS） 协议使用 UDS 监听。

4、Xray 版本不小于 v1.4.0 或 V2Ray 版本不小于 v4.36.2 才支持 gRPC 传输方式。

5、Caddy 版本不小于 v2.2.0 才支持 H2C proxy，即支持 Xray 或 V2Ray 的 H2C（gRPC） 反向代理。Caddy 版本不小于 v2.6.0 才支持 H2C proxy 的 UDS 转发。

6、Caddy 版本不小于 v2.3.0 才支持 Caddyfile 配置开启 H2C server。

7、Caddy 支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程。

8、使用本人 Releases 中编译好的 Caddy 文件，可同时支持 H2C server、H2C proxy、Trojan-Go、NaïveProxy 及接收 PROXY protocol 等应用。

9、本示例中 Trojan-Go 兼容原版 Trojan-Go，继承了其服务端核心特色：支持 Trojan 应用与 Trojan-Go 的 WebSocket 应用共存；支持 CDN 流量中转(基于 WebSocket over TLS)。

10、本示例中 V2Ray 或 Xray 所需 TLS 证书由 Caddy（内置 ACME 客户端） 提供，实现 TLS 证书自动申请及更新。

11、V2Ray 不支持‘证书热更新’功能，即 V2Ray 不会自动识别 TLS 证书更新并重载 TLS 证书，之前可使用通用办法解决，现在可选择 Caddy 的专属办法解决了。

1）、Linux 类系统使用 Crontab 指令定时重启 V2Ray 来重载更新后的 TLS 证书，其它系统使用类似命令/工具来定时重启 V2Ray 来重载更新后的 TLS 证书。（通用办法）

2）、使用 Caddy 的 events 应用配置实现 TLS 证书自动更新后就执行重启 V2Ray 来重载更新后的 TLS 证书（类似 acme.sh 的 reloadcmd 参数应用），详见 ‘caddy(other configuration) （Caddy的特殊应用配置方法。）’中对应介绍及对应配置示例。（专属办法）

12、本示例 Caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可（完全等效）。推荐使用 json 格式配置（无嵌套），优化好。

13、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol。配置2：使用 UDS 连接（对应 shadowsocks+grpc+tls 除外），且启用了 PROXY protocol。

14、若采用配置2、且使用 Nginx SNI 来分流的，想 NaïveProxy 同时开启 HTTP/3 代理支持，可参考配置1。方法：Nginx 中添加对应 HTTPS server 的定向 UDP 转发配置，对应 HTTPS server 的进程转发改为端口转发；Caddy 中对应 HTTPS server 的进程监听改为端口监听，HTTPS server 开启 HTTP/3 支持。

15、若 NaïveProxy 使用 HTTP/3 代理应用，即 QUIC 协议传输，建议增加 [UDP 接收缓冲区大小](https://github.com/lucas-clemente/quic-go/wiki/UDP-Receive-Buffer-Size)。

16、若除了实现最多应用的科学上网、还需提供实际网站服务，推荐本示例（实际网站服务可由 Nginx 或 Caddy 提供服务）；否则推荐采用 [v2ray(E+B+D+G+A)+caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BD%2BG%2BA)%2Bcaddy(N%2BT)) 示例。
