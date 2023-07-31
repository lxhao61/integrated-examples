介绍：

1、本示例配置采用 V2Ray 或 Xray 自带 Shadowsocks 应用加 Dokodemo-Door 的 WebSocket 应用（等同 v2ray-plugin 或 xray-plugin 插件的 websocket 模式，简记为 Door+WebSocket。） 组合，直接实现原版 Shadowsocks 加 v2ray-plugin 或 xray-plugin 插件的 websocket 模式服务端应用。

2、利用 Nginx 或 Caddy 支持 WebSocket 代理实现等同原版 Shadowsocks 加 v2ray-plugin 或 xray-plugin 插件的 websocket-tls 模式服务端应用，TLS 由 Nginx 启用及处理或由 Caddy 提供及处理。

原理：

默认流程：WEB client <-------- HTTPS（HTTP/1.1+TLS） -------> Nginx/Caddy（WEB server）  
反代流程：Shadowsocks client <------- WebSocket+TLS --------> Nginx/Caddy <-- WebSocket --> V2Ray/Xray server

注意：

1、SS 为 shadowsocks 简写。

2、V2Ray 或 Xray 的监听地址不支持 Dokodemo-Door 协议使用 UDS 监听。

3、Nginx 支持 HTTPS server 需要 Nginx 包含 http_ssl_module 模块等。

4、Nginx 支持请求标头还原为真实客户端地址需要 Nginx 包含 http_realip_module 模块。

5、若选用 Nginx 实现应用，不要使用 ACME 客户端在采用本示例的服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书需监听 80 或 443 端口，从而与当前应用端口冲突。

6、若选用 Caddy 实现应用，本示例 Caddy 支持自动 HTTPS，即自动申请与更新 TLS 证书，自动 HTTP 重定向到 HTTPS。

7、配置 v2ray_LLb_config.json 采用 Local Loopback 实现 Shadowsocks 应用与 Dokodemo-Door 的 WebSocket 应用连接，配置 v2ray_UDS_config.json 采用 UDS 实现 Shadowsocks 应用与 Dokodemo-Door 的 WebSocket 应用连接；根据情况二选一即可。

8、本示例 Shadowsocks 加 v2ray-plugin 或 xray-plugin 插件的 websocket-tls 模式服务端应用不等同 V2Ray 或 Xray 的 Shadowsocks+WebSocket+TLS 应用，两者不兼容。
