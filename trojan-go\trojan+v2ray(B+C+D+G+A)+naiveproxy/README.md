介绍：

trojan-go 或 trojan 前置（监听 443 端口），利用 trojan-go 或 trojan 回落特性与 caddy 为 WebSocket（WS）、H2C、gRPC 提供反向代理、为 naiveproxy 提供正向代理，实现除 v2ray 或 Xray 的 KCP 应用外共用 443 端口。其应用如下：

1、trojan-go或trojan（回落配置，TLS由自己提供及处理。）

2、B=vless+ws+tls（TLS由trojan-go或trojan提供及处理，不需配置。另可改、可增其它WS类应用，参考对应的服务端单一应用配置示例。）

3、C=shadowsocks+xray-plugin/v2ray-plugin+tls（TLS由trojan-go或trojan提供及处理，不需配置。）

4、D=vless+h2c+tls（TLS由trojan-go或trojan提供及处理，不需配置。另可改、可增其它H2C类应用，参考对应的服务端单一应用配置示例。）

5、G=vless+grpc+tls（TLS由trojan-go或trojan提供及处理，不需配置。另可改、可增其它gRPC类应用，参考对应的服务端单一应用配置示例。）

6、A=vless+kcp+seed（可改成vmess+kcp+seed，或添加它。）

7、naiveproxy（基于caddy的改进版forwardproxy插件实现，TLS由trojan-go或trojan提供及处理，不需配置。）

注意：

1、因 trojan-go 或 trojan 不支持 Unix Domain Socket，故回落仅端口回落。

2、因 trojan-go 或 trojan 不支持 PROXY protocol，故回落不能启用此项应用。

3、trojan-go 完全兼容 trojan，服务端还有自己的特色：支持 trojan 应用与自己的 WebSocket 应用共存；支持 CDN 流量中转(基于 WebSocket over TLS)；支持使用 AEAD 对 trojan 协议流量进行二次加密(基于 Shadowsocks AEAD)。

4、Xray 版本不小于 v1.4.0 或 v2ray 版本不小于v4.36.2，才支持 gRPC 传输方式。

5、caddy 版本不小于 v2.2.0-rc.1 才支持 H2C proxy，即支持 Xray 或 v2ray 的 H2C（gRPC） 反向代理。

6、caddy 版本不小于 v2.3.0 才支持 Caddyfile 配置开启 H2C server。

7、caddy 支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程（Unix Domain Socket 应用）。

8、使用本人 Releases 中编译好的 caddy 文件，可同时支持 H2C server、H2C proxy、naiveproxy 等应用。

9、本示例中 naiveproxy 仅支持 HTTP/2 代理应用，即 HTTPS 协议传输。

10、本示例 caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可（完全等效）。若使用 caddy 申请证书及密钥推荐使用 json 格式配置，优化更好。

11、不要使用第三方 ACME 客户端在当前服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新证书及密钥，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新证书及密钥需监听 80 或 443 端口，从而与当前应用端口冲突。
