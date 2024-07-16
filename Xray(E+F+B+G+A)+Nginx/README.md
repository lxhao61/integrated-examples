介绍：

利用 Nginx 支持 SNI 分流特性，对 VLESS+Vision+TLS、Trojan+TCP+TLS、HTTP/2 server 进行 SNI 分流（四层转发），实现除 Xray 的 mKCP 应用外各应用共用 443 端口。其中 Nginx 同时为 VLESS+Vision+TLS 与 Trojan+TCP+TLS 提供 WEB 服务（回落应用），为 Xray 的 WebSocket、gRPC 提供反向代理，其应用如下：

1、E=VLESS+Vision+TLS（回落/分流配置，TLS 由自己启用及处理。）

2、F=Trojan+TCP+TLS（回落/分流配置，TLS 由自己启用及处理。）

3、B=VMess+WebSocket+TLS（TLS 由 Nginx 启用及处理，不需配置。）

4、G=Shadowsocks+gRPC+TLS（TLS 由 Trojan+TCP+TLS 或 Nginx 启用及处理，不需配置。）

5、A=VLESS+mKCP+seed

注意：

1、Nginx 支持 SNI 分流需要 Nginx 包含 stream_core_module 和 stream_ssl_preread_module 模块构建。

2、Xray 版本不小于 v1.7.2 才完美支持 VLESS 协议的 XTLS Vision 应用。

3、Xray 的监听地址不支持 Shadowsocks 协议使用 UDS 监听。

4、Xray 的 Shadowsocks 2022 新协议提升了性能并带有完整的重放保护。

5、Nginx 支持 HTTP/2 server 及 H2C server 需要 Nginx 包含 http_ssl_module 与 http_v2_module 模块构建。

6、Nginx 版本不小于 v1.25.1 才支持 H2C server 与 HTTP/1.1 server 共用一个端口或一个进程。若 Nginx 版本小于 v1.25.1，回落必须分成 h2 回落与 http/1.1 回落分别对应 Nginx 的 H2C server 与 HTTP/1.1 server。

7、Nginx 支持对请求标头的 PROXY 协议处理需要 Nginx 包含 http_realip_module 模块构建。

8、不要使用 ACME 客户端在采用本示例的服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书需监听 80 或 443 端口，从而与当前应用端口冲突。

9、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol。配置2：使用 UDS 连接（对应 Shadowsocks+gRPC+TLS 除外），且启用了 PROXY protocol。

10、本示例 F 兼容原版 Trojan 的服务端应用，即可使用 Trojan 或 Trojan-Go 客户端连接。
