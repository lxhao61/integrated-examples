介绍：

本示例为使用 Caddy 的 caddy-trojan 插件实现的 Trojan-Go 服务端应用。

注意：

1、使用本人 Releases 中编译好的 Caddy 文件，可支持 Trojan-Go 等应用。

2、本示例 Caddy 支持自动 HTTPS，即自动申请与更新 TLS 证书，自动 HTTP 重定向到 HTTPS。

3、本示例中 Trojan-Go 仅兼容原版服务端的核心应用：支持 Trojan 应用与 Trojan-Go 的 WebSocket 应用共存，支持 CDN 流量中转(基于 WebSocket over TLS)、其 WebSocket 应用不支持 WebSocket 0-RTT 与多路复用。

4、本示例中 Trojan-Go 虽然兼容原版服务端的核心应用，但是原版 Trojan、Trojan-Go 客户端不支持指纹伪造，故不推荐使用原版 Trojan、Trojan-Go 客户端来连接。客户端推荐选用 Xray 客户端，支持指纹伪造。
