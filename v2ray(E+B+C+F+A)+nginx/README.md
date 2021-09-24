介绍：

Xray 或 v2ray 前置（监听 443 端口），利用 vless+tcp+xtls 或 vless+tcp+tls 强大的回落/分流 WebSocket（WS） 特性及套娃 trojan+tcp 后回落 nginx，实现除 Xray 或 v2ray 的 KCP 应用外共用 443 端口。其应用如下：

1、E=vless+tcp+xtls/tls（回落/分流配置，TLS由自己提供及处理。）

2、B=vless+ws+tls（TLS由vless+tcp+xtls/tls提供及处理，不需配置。另可改、可增其它WS类应用，参考对应的服务端单一应用配置示例。）

3、C=SS+v2ray-plugin+tls（TLS由vless+tcp+xtls/tls提供及处理，不需配置。）

4、F=trojan+tcp+tls（TLS由vless+tcp+xtls/tls提供及处理，不需配置。）

5、A=vless+kcp+seed（可改成vmess+kcp+seed，或添加它。）

注意：

1、v2ray 版本不小于 v4.31.0 才支持 trojan 协议。

2、nginx 支持 H2C server，需要 nginx 包含 http_v2_module 模块。

3、nginx 支持 HTTP 功能块接收 PROXY protocol，需要 nginx 包含 http_realip_module 模块。

4、nginx 支持 H2C server，但不支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程（Unix Domain Socket 应用）；故回落配置就必须分成 http/1.1 回落与 h2 回落两部分，以便分别对应 nginx 的 HTTP/1.1 server 与 H2C server。

5、采用套娃方式实现共用 443 端口，仅需要一个域名及普通证书即可搞定，但套娃 trojan+tcp 不支持 XTLS 应用。

6、不要使用 ACME 客户端在当前服务器上申请与更新普通证书及密钥，因普通证书及密钥申请与更新需监听 80 端口（或 443 端口），从而与当前应用端口冲突。

7、配置1：采用端口回落/分流、端口转发。配置2：采用进程回落/分流、端口转发。配置3：采用进程回落/分流、端口转发，且启用了 PROXY protocol。

8、套娃不支持 http/1.1 回落与 h2 回落分开（即 fallbacks 中 "alpn" 无效）；故使用套娃 trojan+tcp 回落 nginx，仅使用 h2 连接及回落配置。
