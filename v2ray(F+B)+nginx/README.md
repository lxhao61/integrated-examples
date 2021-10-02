介绍：

Xray 或 v2ray 前置（监听 443 端口），利用 trojan+tcp+xtls 或 trojan+tcp+tls 强大的回落/分流 WebSocket（WS） 特性，实现与 WebSocket（WS） 类应用共用 443 端口。其应用如下：

1、F=trojan+tcp+xtls/tls（回落/分流配置，TLS由自己提供及处理。）

2、B=vless+ws+tls（TLS由trojan+tcp+xtls/tls提供及处理，不需配置。另可改、可增其它WS类应用，参考对应的服务端单一应用配置示例。）

注意：

1、v2ray 版本不小于 v4.42.3 才完美支持 trojan 协议（修复了 fallback alpn 无效问题）。

2、nginx 支持 H2C server，需要 nginx 包含 http_v2_module 模块。

3、nginx 支持 HTTP 功能块接收 PROXY protocol，需要 nginx 包含 http_realip_module 模块。

4、nginx 支持 H2C server，但不支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程（Unix Domain Socket 应用）；故回落配置就必须分成 http/1.1 回落与 h2 回落两部分，以便分别对应 nginx 的 HTTP/1.1 server 与 H2C server。

5、不要使用 ACME 客户端在当前服务器上申请与更新普通证书及密钥，因普通证书及密钥申请与更新需监听 80 端口（或 443 端口），从而与当前应用端口冲突。

6、配置1：采用端口回落/分流。配置2：采用进程回落/分流。配置3：采用进程回落/分流，且启用了 PROXY protocol。

7、因 v2ray 带来的 bug，无论 v2ray 还是 Xray 的 trojan+tcp+tls 应用都不支持 http/1.1 回落与 h2 回落分开；故若使用 trojan+tcp+tls 回落 nginx，且分流 WebSocket（WS），必须删除本示例中 h2 连接及回落配置，保留 http/1.1 连接及回落配置即可。
