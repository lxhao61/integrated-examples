介绍：

本示例包括 naiveproxy、trojan-go 应用。服务端以 caddy 源码加 forwardproxy 插件、caddy-trojan 插件编译而成，基于各自插件代理实现科学上网。其应用如下：

1、naiveproxy（基于forwardproxy插件实现，tls由caddy提供及处理。）

2、trojan-go（基于caddy-trojan插件实现，tls由caddy提供及处理。）

注意：

1、caddy 不小于 v2.3.0 版才支持 Caddyfile 配置开启 h2c server。

2、使用本人 Releases 中编译好的 caddy 文件，可同时支持 naiveproxy、trojan-go、h2c server 等应用。

3、本示例的 naiveproxy 支持 http/3 代理应用，即 QUIC 协议传输。

4、本示例的 trojan-go 应用（服务端）兼容原版 trojan-go，继承了其服务端核心特色：支持原版 trojan 应用与原版 trojan-go 的 Websocket 应用共存；支持 CDN 流量中转(基于 WebSocket over TLS)。

5、本示例中 caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可（效果一样）。支持自动 https，即自动申请与更新证书与私钥，自动 http 重定向到 https。
