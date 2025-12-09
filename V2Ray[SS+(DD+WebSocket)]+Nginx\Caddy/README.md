介绍：

1、本示例配置采用 V2Ray 或 Xray 自带 Shadowsocks 应用加 Dokodemo-Door 的 WebSocket 应用（等同 v2ray-plugin 或 xray-plugin 插件的 websocket 模式，简记为 DD+WebSocket。） 组合，直接实现原版 Shadowsocks 加 v2ray-plugin 或 xray-plugin 插件的 websocket 模式服务端应用。

2、利用 Nginx 或 Caddy 支持 WebSocket 反向代理实现等同原版 Shadowsocks 加 v2ray-plugin 或 xray-plugin 插件的 websocket-tls 模式服务端应用，TLS 由 Nginx 启用及处理或由 Caddy 提供及处理。

原理：

默认流程：Web client <--------------- HTTP/1.1+TLS --------------> Nginx/Caddy（Web server）  
反代流程：Shadowsocks client（加插件） <-- WebSocket+TLS --> Nginx/Caddy <-- WebSocket --> V2Ray/Xray server

注意：

1、SS 为 Shadowsocks 简写，DD 为 Dokodemo-Door 简写。

2、V2Ray 版本不小于 v4.37.0 才支持 Shadowsocks 启用 IV 检查功能，可使某些 IV 重放攻击更加困难。

3、Xray 版本不小于 v1.7.0 才完美支持 Shadowsocks 2022 新协议，提升了性能并带有完整的重放保护。

4、Nginx 支持 HTTPS server 需要 Nginx 包含 http_ssl_module 模块构建。

5、若选用 Nginx 实现应用，ACME 客户端在采用本示例的服务器上以 HTTP-01 验证方式申请与更新 TLS 证书时、建议使用 Nginx 模式来避免端口冲突。

6、若选用 Caddy 实现应用，本示例 Caddy 支持自动 HTTPS，即自动申请与更新 TLS 证书，自动 HTTP 重定向到 HTTPS。

7、本示例 Shadowsocks 加 v2ray-plugin 或 xray-plugin 插件的 websocket-tls 模式服务端应用不等同 V2Ray 或 Xray 的 Shadowsocks+WebSocket+TLS 应用，两者不兼容。
