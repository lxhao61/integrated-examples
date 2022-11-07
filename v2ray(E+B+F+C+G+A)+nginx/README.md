介绍：

利用 Nginx 支持 SNI 分流特性，对 vless+tcp+tls 或 vless+tcp+xtls、trojan+tcp+tls 或 trojan+tcp+xtls、HTTP/2 server 进行 SNI 分流（四层转发），实现除 V2Ray 或 Xray 的 mKCP 应用外共用 443 端口。其中 vless+tcp+tls 或 vless+tcp+xtls、trojan+tcp+tls 或 trojan+tcp+xtls 为 WebSocket（WS） 提供分流转发；Nginx 同时为 vless+tcp+tls 或 vless+tcp+xtls 与 trojan+tcp+tls 或 trojan+tcp+xtls 提供回落服务，为 V2Ray 或 Xray 的 gRPC 提供反向代理，其应用如下：

1、E=vless+tcp+tls/xtls（回落/分流配置，TLS/XTLS由自己提供及处理。）

2、B=vmess+ws+tls（TLS由vless+tcp+tls/xtls提供及处理，不需配置。）

3、F=trojan+tcp+tls/xtls（回落/分流配置，TLS/XTLS由自己提供及处理。）

4、C=trojan+ws+tls（TLS由trojan+tcp+tls/xtls提供及处理，不需配置。）

5、G=shadowsocks+grpc+tls（TLS由nginx提供及处理，不需配置。）

6、A=vless+kcp+seed

注意：

1、Nginx 支持 SNI 分流，需要 Nginx 包含 stream_core_module 和 stream_ssl_preread_module 模块。

2、采用 SNI 方式实现共用 443 端口，支持各自特色应用，但需多个域名来标记分流。

3、Xray 或 V2Ray 的监听地址不支持 Shadowsocks（SS） 协议使用 UDS 监听。

4、Xray 版本不小于 v1.5.1 才完美支持 TLS 模式下 Trojan 协议。V2Ray 版本不小于 v4.43.0 才完美支持 Trojan 协议。

5、Nginx 支持 HTTP/2 server、gRPC proxy 及 H2C server，需要 Nginx 包含 http_v2_module 和 http_ssl_module 模块。

6、Nginx 支持 TLSv1.3，需要包含版本不小于 1.1.1 的 OpenSSL 软件库包和 http_ssl_module 模块。

7、Nginx 支持 HTTP 功能块接收 PROXY protocol，需要 Nginx 包含 http_realip_module 模块。

8、Nginx 支持 H2C server，但不支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程；故回落分成 http/1.1 回落与 h2 回落分别对应 Nginx 的 HTTP/1.1 server 与 H2C server。

9、不要使用 ACME 客户端在当前服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书需监听 80 或 443 端口，从而与当前应用端口冲突。

10、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol。配置2：使用 UDS 连接（对应 shadowsocks+grpc+tls 除外），且启用了 PROXY protocol。

11、本示例 F 兼容原版 Trojan 应用，F+C 组合等同于 Trojan-Go 应用；即可使用 Trojan 客户端 或 Trojan-Go 客户端对应连接。
