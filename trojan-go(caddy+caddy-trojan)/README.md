介绍：

本示例中 trojan-go 服务端是以 caddy 源码加 caddy-trojan 插件编译而成，仅一个软件就实现了 trojan-go 应用。

注意：

1、caddy 不小于 v2.3.0 版才支持 Caddyfile 配置开启 h2c server。

2、本示例中 caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可（效果一样）。支持自动 https，即自动申请与更新证书与私钥，自动 http 重定向到 https。

3、本示例中 trojan-go 服务端完全兼容 trojan，还有自己的特色：支持 Websocket，可与一般 Trojan 流量共存；支持 CDN 流量中转(基于 WebSocket over TLS)。
