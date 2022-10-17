介绍：

本示例服务端是以 caddy 源码加 caddy-trojan 插件编译而成，仅一个软件就实现了原版 trojan-go（服务端） 加伪装网站应用。

注意：

1、使用本人 Releases 中编译好的 caddy 文件，可支持 H2C server、trojan-go 等应用。

2、本示例中 trojan-go 兼容原版 trojan-go，继承了其服务端核心特色：支持 trojan 应用与 trojan-go 的 WebSocket 应用共存，支持 CDN 流量中转(基于 WebSocket over TLS)。

3、本示例 caddy 支持自动 HTTPS，即自动申请与更新 SSL/TLS 证书，自动 HTTP 重定向到 HTTPS。
