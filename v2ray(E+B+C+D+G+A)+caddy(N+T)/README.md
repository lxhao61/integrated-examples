介绍：

Xray\v2ray 前置（监听443端口），利用 vless+tcp+tls 强大的回落/分流特性，实现除 Xray\v2ray kcp 外共用443端口。vless+tcp+tls 以 h2 或 http/1.1 自适应协商连接，分流 WebSocket（WS） 连接，其它连接回落给 caddy；caddy 再处理：反向代理 Xray\v2ray 的 WebSocket（WS）、 h2c 及 gRPC，正向代理 naiveproxy 及 trojan-go。包括应用如下：

1、E=vless+tcp+tls（回落/分流配置，tls由自己提供及处理。）

2、B=vless+ws+tls（tls由vless+tcp+tls提供及处理，不需配置；另可改成或添加其它WS类应用，参考对应的服务端单一应用配置示例。）

3、C=SS+v2ray-plugin+tls（tls由vless+tcp+tls提供及处理，不需配置。）

4、D=vless+h2c+tls（tls由vless+tcp+tls提供及处理，不需配置；另可改成或添加其它h2c类应用，参考对应的服务端单一应用配置示例。）

5、G=vless+grpc+tls（tls由vless+tcp+tls提供及处理，不需配置；另可改成或添加其它gRPC类应用，参考对应的服务端单一应用配置示例。）

6、A=vless+kcp+seed（可改成vmess+kcp+seed，或添加它。）

7、naiveproxy（基于caddy的forwardproxy插件实现，tls由vless+tcp+tls提供及处理，不需配置。）

8、trojan-go（基于caddy的caddy-trojan插件实现，tls由vless+tcp+tls提供及处理，不需配置。）

注意：

1、Xray 版本不小于 1.4.0 或 v2ray 版本不小于v4.36.2，才完美支持 gRPC 应用。

2、caddy 不小于 v2.2.0-rc.1 版才支持 h2c proxy，即支持 Xray\v2ray 的 h2c（gRPC） 反向代理。

3、caddy 不小于 v2.3.0 版才支持 Caddyfile 配置开启 h2c server。

4、caddy 支持 http/1.1 server 与 h2c server 共用一个端口或一个进程（Unix Domain Socket 应用）。

5、使用本人 Releases 中编译好的 caddy 文件，可同时支持 h2c server、h2c proxy、naiveproxy、trojan-go 及 PROXY protocol 等应用。

6、本示例的 trojan-go 应用（服务端）完全兼容原版 trojan，还有自己的特色：支持同时提供原版 trojan 应用与原版 trojan-go 的 Websocket 应用；支持 CDN 流量中转(基于 WebSocket over TLS)。

7、本示例中 caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可。若使用 caddy 申请证书及密钥，推荐使用 json 格式配置，优化更好。

8、本示例配置不要使用非 caddy（自带 ACME 客户端） 的 ACME 客户端在当前服务器上申请与更新普通证书及密钥，因普通证书及密钥申请与更新需占用或监听80端口（或443端口），从而与当前应用端口冲突。

9、Xray 所需证书及密钥推荐使用 caddy 申请，配合 Xray（版本必须不低于v1.3.0）自动重载证书及密钥（OCSP Stapling），可实现证书及密钥申请与更新全自动化。

10、配置1：采用端口回落\分流、端口转发。配置2：采用进程回落\分流、端口转发。配置3：采用进程回落\分流、端口转发，且启用了 PROXY protocol。
