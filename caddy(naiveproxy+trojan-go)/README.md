介绍：

此示例包括 naiveproxy 与 trojan-go 应用。naiveproxy 服务端是以 caddy 源码加 forwardproxy 插件编译而成，基于 http/2 或 http/3 代理实现科学上网；此 trojan-go 服务端是以 caddy 源码加 caddy-trojan 插件编译而成，实现了 trojan-go 应用（科学上网）。
其应用如下：

1、trojan-go（带有caddy-trojan插件的caddy可支持trojan-go应用。tls由caddy提供及处理，不需配置。）

2、naiveproxy（带有forwardproxy插件的caddy才支持naiveproxy应用。tls由caddy提供及处理，不需配置。）

注意：

1、caddy 不小于 v2.3.0 版才支持 Caddyfile 配置开启 h2c server。

1、如采用本人 Releases 文件的 caddy（naiveproxy 服务端）支持 http/3 应用，即 quic 协议传输。

2、Caddyfile 配置与 caddy.json 配置二选一（效果一样）。支持自动 https，即自动申请与更新证书与私钥，自动 http 重定向到 https。

3、此 trojan-go 应用完全兼容 trojan，还有自己的特色：支持 Websocket，可与一般 Trojan 流量共存；支持 CDN 流量中转(基于 WebSocket over TLS)。
