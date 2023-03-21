介绍：

利用 Caddy 支持 SNI 分流特性，对 VLESS+Vision+REALITY、Trojan+TCP+TLS、HTTPS server 进行 SNI 分流（四层转发），实现除 Xray 的 mKCP 应用外共用 443 端口。其中 VLESS+Vision+REALITY 回落（套娃） VLESS+H2C，Trojan+TCP+TLS 为 WebSocket 提供分流转发；Caddy 同时为 Trojan+TCP+TLS 提供回落服务，为 Xray 的 WebSocket 与 gRPC 进行反向代理，为 forwardproxy 插件提供正向代理，其应用如下：

1、M=VLESS+Vision+REALITY（回落与转发配置，REALITY由自己启用及处理。）

2、K=VLESS+H2C+REALITY（REALITY由VLESS+Vision+REALITY启用及处理，不需配置。）

3、F=Trojan+TCP+TLS（回落/分流配置，TLS由自己启用及处理。）

4、C=Trojan+WebSocket+TLS（TLS由Trojan+TCP+TLS启用及处理，不需配置。）

5、B=VMess+WebSocket+TLS（TLS由Caddy提供及处理，不需配置。）

6、G=Shadowsocks+gRPC+TLS（TLS由Caddy提供及处理，不需配置。）

7、A=VLESS+mKCP+seed

8、N=NaiveProxy（基于Caddy的改进版forwardproxy插件实现，TLS由Caddy提供及处理，不需配置。）

注意：

1、Caddy 加 caddy-l4 插件定制编译的才可以实现 SNI 分流，目前仅支持使用 json 配置（不支持 Caddyfile 配置）。

2、采用 SNI 方式实现共用 443 端口，支持各自特色应用，但需多个域名来标记分流。

3、Xray 版本不小于 v1.8.0 才支持 REALITY 及同步 uTLS（强制客户端必须使用指纹伪造）。

4、Xray 的监听地址不支持 Shadowsocks（简称SS） 协议使用 UDS 监听。

5、Caddy 版本不小于 v2.2.0 才支持 H2C proxy，即支持 Xray 的 H2C（gRPC） 反向代理。Caddy 版本不小于 v2.6.0 才支持 H2C proxy 的 UDS 转发。

6、Caddy 支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程。

7、使用本人 Releases 中编译好的 Caddy 文件，可同时支持SNI 分流、H2C server、H2C proxy、NaiveProxy 及 PROXY protocol 等应用。

8、本示例中 NaiveProxy 仅支持 HTTP/2 代理应用，即 HTTPS 协议传输。

9、本示例所需 TLS 证书由 Caddy（内置 ACME 客户端） 提供，实现 TLS 证书自动申请及更新。

10、本示例 F 兼容原版 Trojan 应用，F+C 组合等同于 Trojan-Go 应用；即可使用 Trojan 客户端 或 Trojan-Go 客户端对应连接。

11、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol。配置2：使用 UDS 连接（对应 Shadowsocks+gRPC+TLS 除外），且启用了 PROXY protocol。

12、若已有 Nginx 或大型网站、或需要 NaiveProxy 支持 HTTP/3 代理应用，推荐采用 [Xray(M+K+F+C+B+G+A)+Caddy(N)+Nginx\HAProxy](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M%2BK%2BF%2BC%2BB%2BG%2BA)%2BCaddy(N)%2BNginx%5CHAProxy) 示例。
