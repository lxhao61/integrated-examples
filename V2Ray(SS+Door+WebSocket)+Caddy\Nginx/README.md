介绍：

1、本示例配置采用 Xray 或 V2Ray 自带 Shadowsocks（简称SS） 应用加 Dokodemo-Door 的 WebSocket 应用（等同 xray-plugin 或 v2ray-plugin 插件的 websocket 模式，简记为Door+WebSocket。） 组合，直接实现原版 Shadowsocks（简称SS） 加 xray-plugin 或 v2ray-plugin 插件的 websocket 模式服务端应用。

2、利用 Caddy 或 Nginx 支持 WebSocket（WS） 代理实现等同原版 Shadowsocks（简称SS） 加 xray-plugin 或 v2ray-plugin 插件的 websocket-tls 模式服务端应用，TLS 由 Caddy 提供及处理或由 Nginx 启用及处理。

原理：

默认流程：WEB client <-------- HTTPS（HTTP/1.1+TLS） -------> Caddy/Nginx（WEB server）  
反代流程：Shadowsocks client <------- WebSocket+TLS --------> Caddy/Nginx <-- WebSocket --> Xray/V2Ray server

注意：

1、Xray 或 V2Ray 的监听地址不支持 Dokodemo-Door 协议使用 UDS 监听。

2、v2ray_UDS_config.json 采用 UDS 实现 Shadowsocks（简称SS） 应用与 Dokodemo-Door 的 WebSocket 应用连接；v2ray_LLb_config.json 采用 Local Loopback 实现 Shadowsocks（简称SS） 应用与 Dokodemo-Door 的 WebSocket 应用连接，根据情况二选一即可。

3、本示例 Shadowsocks（简称SS） 加 xray-plugin 或 v2ray-plugin 插件的 websocket-tls 模式服务端应用不等同 Xray 或 V2Ray 的 [Shadowsocks+WebSocket+TLS](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(SS%2BWebSocket)%2BCaddy%5CNginx) 应用，两者不兼容。

4、若采用 Caddy 反向代理，本示例 Caddy 支持自动 HTTPS，即自动申请与更新 TLS 证书，自动 HTTP 重定向到 HTTPS。

5、Nginx 支持 HTTPS server 及 WebSocket proxy 需要 Nginx 包含 http_ssl_module 模块及 OpenSSL 库。

6、若采用 Nginx 反向代理，不要使用 ACME 客户端在采用本示例的服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书需监听 80 或 443 端口，从而与当前应用端口冲突。
