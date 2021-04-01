介绍：

本项示例包括 vless+tcp+tls 与 trojan+tcp+tls 两种应用，实现了 Xray\v2ray 前置（监听443端口），以 h2 或 http/1.1 自适应协商连接，非 Xray\v2ray 的 web 连接回落给 caddy（即解除 tls 后的 web 连接转给 caddy 处理）。

原理图： Xray\v2ray client <------ tcp+tls ------> Xray\v2ray server <- web回落 -> caddy

其中 trojan+tcp+tls 还实现了兼容 trojan，即可直接使用 trojan 客户端连接。  

注意：

1、v2ray v4.31.0 版本及以后才支持 trojan 协议。

2、caddy 等于或大于 v2.3.0 版才支持 Caddyfile 配置开启 h2c server。

3、caddy 支持 http/1.1 server 与 h2c server 共用一个端口或一个进程（Unix Domain Socket 应用）。

4、caddy 发行版不支持 PROXY protocol（接收）。如要支持 PROXY protocol 需选 caddy2-proxyprotocol 插件定制编译，或下载本人 github 中编译好的 caddy 来使用即可。

5、本示例中 caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可（效果一样）。

6、配置1：端口回落，没有启用 PROXY protocol。配置2：进程回落，没有启用 PROXY protocol。配置3：进程回落，启用了 PROXY protocol。
