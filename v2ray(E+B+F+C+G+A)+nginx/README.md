介绍：

利用 nginx 支持 SNI 分流特性，对 vless+tcp+xtls 或 vless+tcp+tls、trojan+tcp+xtls 或 trojan+tcp+tls、HTTP/2 server 进行 SNI 分流（四层转发），实现除 Xray 或 v2ray 的 KCP 应用外共用 443 端口。其中 vless+tcp+xtls 或 vless+tcp+tls、trojan+tcp+xtls 或 trojan+tcp+tls 为 WebSocket（WS） 提供分流转发；nginx 同时为 vless+tcp+xtls 或 vless+tcp+tls 与 trojan+tcp+xtls 或 trojan+tcp+tls 提供回落服务，为 Xray 或 v2ray 的 gRPC 提供反向代理。包括应用如下：

1、E=vless+tcp+xtls/tls（回落/分流配置，TLS由自己提供及处理。）

2、B=vless+ws+tls（TLS由vless+tcp+xtls/tls提供及处理，不需配置。另可改、可增其它WS类应用，参考对应的服务端单一应用配置示例。）

3、F=trojan+tcp+xtls/tls（回落/分流配置，TLS由自己提供及处理。）

4、C=SS+v2ray-plugin+tls（TLS由trojan+tcp+xtls/tls提供及处理，不需配置。另可改、可增其它WS类应用，参考对应的服务端单一应用配置示例。）

5、G=vless+grpc+tls（TLS由nginx提供及处理，不需配置。另可改、可增其它gRPC类应用，参考对应的服务端单一应用配置示例。）

6、A=vless+kcp+seed（可改成vmess+kcp+seed，或添加它。）

注意：

1、v2ray 版本不小于 v4.31.0 才支持 trojan 协议。

2、Xray 版本不小于 v1.4.0 或 v2ray 版本不小于v4.36.2，才支持 gRPC 传输方式。

3、nginx 支持 SNI 分流，需要 nginx 包含 stream_core_module 和 stream_ssl_preread_module 模块。

4、nginx 支持 HTTP/2 server、gRPC proxy 及 H2C server，需要 nginx 包含 http_v2_module 和 http_ssl_module 模块。

5、nginx 支持 TLSv1.3，需要 nginx 包含版本大于 1.1.1 的 OpenSSl 库和 http_ssl_module 模块。

6、nginx 支持 HTTP 功能接收 PROXY protocol，需要 nginx 包含 http_realip_module 模块。

7、nginx 支持 H2C server，但不支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程（Unix Domain Socket 应用）；故回落配置就必须分成 http/1.1 回落与 h2 回落两部分，以便分别对应 nginx 的 HTTP/1.1 server 与 H2C server。

8、采用 SNI 方式实现共用 443 端口，支持各自特色应用，但需多个域名来标记分流。

9、不要使用 ACME 客户端在当前服务器上申请与更新普通证书及密钥，因普通证书及密钥申请与更新需监听 80 端口（或 443 端口），从而与当前应用端口冲突。

10、配置1：采用端口分流、端口回落/分流、端口转发。配置2：采用进程分流、进程回落/分流、进程转发。配置3：采用进程分流、进程回落/分流、进程转发，且启用了 PROXY protocol。

11、因 v2ray 带来的 bug，无论 v2ray 还是 Xray 的 trojan+tcp+tls 应用都不支持 http/1.1 回落与 h2 回落分开；故若使用 trojan+tcp+tls 回落 nginx，且分流 WebSocket（WS），必须删除本示例中 h2 连接及回落配置，保留 http/1.1 连接及回落配置即可。
