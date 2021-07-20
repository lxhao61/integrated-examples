介绍：

本示例为 naiveproxy(caddy+forwardproxy) 与 trojan-go(caddy+caddy-trojan) 应用融合。其应用如下：

1、naiveproxy（tls由caddy提供及处理，不需配置。）

2、trojan-go（tls由caddy提供及处理，不需配置。）

注意：

1、caddy 不小于 v2.3.0 版才支持 Caddyfile 配置开启 h2c server。

1、采用本人 Releases 中的 caddy 文件才同时支持 naiveproxy(caddy+forwardproxy) 与 trojan-go(caddy+caddy-trojan) 应用。

2、Caddyfile 配置与 caddy.json 配置二选一（效果一样）。支持自动 https，即自动申请与更新证书与私钥，自动 http 重定向到 https。

3、此 trojan-go 应用完全兼容 trojan，还有自己的特色：支持 Websocket，可与一般 Trojan 流量共存；支持 CDN 流量中转(基于 WebSocket over TLS)。
