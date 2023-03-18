介绍：

利用 Nginx 支持 SNI 分流特性，对 VLESS+TCP+TLS、Trojan-Go 或 Trojan、HTTP/2 server 进行 SNI 分流（四层转发），实现除 Xray 或 V2Ray 的 mKCP 应用外共用 443 端口。其中 VLESS+TCP+TLS 为 WebSocket 提供分流转发；Nginx 同时为 VLESS+TCP+TLS 与 Trojan-Go 或 Trojan 提供回落服务，为 Xray 或 V2Ray 的 gRPC 提供反向代理，其应用如下：

1、E=VLESS+TCP+TLS（回落/分流配置，TLS由自己启用及处理。）

2、B=VMess+WebSocket+TLS（TLS由VLESS+TCP+TLS启用及处理，不需配置。）

3、G=Shadowsocks+gRPC+TLS（TLS由Nginx启用及处理，不需配置。）

4、A=VLESS+mKCP+seed

5、Trojan-Go或Trojan（TLS由自己启用及处理。）

注意：

1、Nginx 支持 SNI 分流需要 Nginx 包含 stream_core_module 和 stream_ssl_preread_module 模块。

2、采用 SNI 方式实现共用 443 端口，支持各自特色应用，但需多个域名来标记分流。

3、Xray 或 V2Ray 的监听地址不支持 Shadowsocks（简称SS） 协议使用 UDS 监听。

4、Xray 版本不小于 v1.4.0 或 V2Ray 版本不小于 v4.36.2 才支持 gRPC 传输方式。

5、因 Trojan-Go 或 Trojan 不支持 UDS，故 Nginx SNI 分流 Trojan-Go 或 Trojan 使用 Local Loopback 连接；故与 Trojan-Go 或 Trojan 共用 WEB 服务的 VLESS+TCP+TLS 回落也不能使用 UDS 连接，即全部回落使用 Local Loopback 连接。

6、因 Trojan-Go 或 Trojan 不支持 PROXY protocol，故 Nginx SNI 分流启用 PROXY protocol 须特殊处理（具体见配置示例）；故与 Trojan-Go 或 Trojan 共用 WEB 服务的 VLESS+TCP+TLS 回落也不能启用 PROXY protocol，即全部回落不启用 PROXY protocol。

7、Trojan-Go 完全兼容 Trojan，服务端还有自己的特色：支持 Trojan 应用与自己的 WebSocket 应用共存；支持 CDN 流量中转(基于 WebSocket over TLS)；支持使用 AEAD 对 Trojan 协议流量进行二次加密(基于 Shadowsocks AEAD)。

8、Nginx 支持 H2C server、HTTP/2 server 及 gRPC proxy 需要 Nginx 包含 http_ssl_module 与 http_v2_module 模块及 OpenSSL 库。

9、Nginx 支持 HTTP 功能块接收 PROXY protocol 需要 Nginx 包含 http_realip_module 模块。

10、Nginx 支持 H2C server，但不支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程；故回落分成 http/1.1 回落与 h2 回落分别对应 Nginx 的 HTTP/1.1 server 与 H2C server。

11、因 Trojan-Go 目前不支持 http/1.1 回落与 h2 回落分开，故 Trojan-Go 开启 Websocket 支持后只选 http/1.1 连接及 http/1.1 回落。

12、不要使用 ACME 客户端在采用本示例的服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书需监听 80 或 443 端口，从而与当前应用端口冲突。

13、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol（全部回落除外）。配置2：使用混合连接（能 UDS 连接的全部 UDS 连接），且启用了 PROXY protocol（全部回落除外）。
