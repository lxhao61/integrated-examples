介绍：

Xray 前置（监听 443 端口），利用 VLESS+Vision+REALITY 支持回落与转发给自己网站，实现各应用共用 443 端口，其应用如下：

1、M=VLESS+Vision+REALITY（回落与转发配置，REALITY由自己启用及处理。）

2、K=VLESS+H2C+REALITY（REALITY由VLESS+Vision+REALITY启用及处理，不需配置。）

3、B=VMess+WebSocket+TLS（TLS由Caddy提供及处理，不需配置。）

4、G=Shadowsocks+gRPC+TLS（TLS由Caddy提供及处理，不需配置。）

5、A=VLESS+mKCP+seed

6、N=NaiveProxy（基于Caddy的改进版forwardproxy插件实现，TLS由Caddy提供及处理，不需配置。）

7、T=Trojan-Go（基于Caddy的caddy-trojan插件实现，TLS由Caddy提供及处理，不需配置。）

注意：

1、Xray 版本不小于 v1.8.0 才支持 REALITY 及同步 uTLS（强制客户端必须使用指纹伪造）。

2、Xray 的监听地址不支持 Shadowsocks（简称SS） 协议使用 UDS 监听。

3、Caddy 版本不小于 v2.2.0 才支持 H2C proxy，即支持 Xray 的 H2C（gRPC） 反向代理。Caddy 版本不小于 v2.6.0 才支持 H2C proxy 的 UDS 转发。

4、使用本人 Releases 中编译好的 Caddy 文件，可同时支持 H2C proxy、NaiveProxy、Trojan-Go 及接收 PROXY protocol 等应用。

5、本示例中 NaiveProxy 仅支持 HTTP/2 代理应用，即 HTTPS 协议传输。

6、本示例中 Trojan-Go 兼容原版 Trojan-Go，继承了其服务端核心特色：支持 Trojan 应用与 Trojan-Go 的 WebSocket 应用共存；支持 CDN 流量中转(基于 WebSocket over TLS)。

7、本示例 Caddy 支持自动 HTTPS，即自动申请与更新 TLS 证书，自动 HTTP 重定向到 HTTPS。

8、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol。配置2：使用 UDS 连接（对应 Shadowsocks+gRPC+TLS 除外），且启用了 PROXY protocol。
