介绍：

本示例服务端是以 caddy 源码加 caddy-trojan 插件编译而成，仅一个软件就实现了 trojan-go 应用。

注意：

1、caddy 版本不小于 v2.3.0 才支持 Caddyfile 配置开启 H2C server。

2、使用本人 Releases 中编译好的 caddy 文件，可支持 H2C server、trojan-go 等应用。

3、本示例中 trojan-go 兼容原版 trojan-go，继承了其服务端核心特色：支持 trojan 应用与原版 trojan-go 的 Websocket 应用共存，支持 CDN 流量中转(基于 WebSocket over TLS)。

4、本示例 caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可（效果一样）。支持自动 HTTPS，即自动申请与更新证书与私钥，自动 HTTP 重定向到 HTTPS。
