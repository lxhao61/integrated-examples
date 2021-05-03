介绍：

Xray\v2ray 前置（监听443端口），利用 trojan+tcp+tls 强大的回落/分流特性，实现了共用443端口。trojan+tcp+tls 以 h2 或 http/1.1 自适应协商连接，分流 WebSocket（WS） 连接，非 Xray\v2ray 的连接回落给 caddy；若有 naiveproxy 就进行正向代理。其应用如下：

1、F=trojan+tcp+tls（回落/分流配置，tls由自己提供。）

2、B=vless+ws+tls（tls由trojan+tcp+tls提供及处理，不需配置；另可改成或添加其它WS类应用，参考反向代理WS类的单一示例。）

3、naiveproxy（带有forwardproxy插件的caddy才支持naiveproxy应用，否则仅上边应用。tls由trojan+tcp+tls提供及处理，不需配置。）

注意：

1、v2ray v4.31.0 版本及以后才支持 trojan 协议。

2、caddy 等于或大于 v2.3.0 版才支持 Caddyfile 配置开启 h2c server。

3、caddy 支持 http/1.1 server 与 h2c server 共用一个端口或一个进程（Unix Domain Socket 应用）。

4、caddy 发行版不支持 PROXY protocol（接收）。如要支持 PROXY protocol 需选 caddy2-proxyprotocol 插件定制编译，或下载本人 github 中编译好的 caddy 来使用即可。

5、本示例中 caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可。推荐使用 json 格式配置，可能配置优化更好。

6、使用本人 github 中编译好的 caddy 文件，才同时支持 h2c server、naiveproxy 及 PROXY protocol 等应用。

7、配置1：采用端口回落\分流。配置2：采用进程回落\分流。配置3：采用进程回落\分流，且启用了 PROXY protocol。

8、可以使用 caddy 以 DNS API 方式申请证书与私钥，实现自动申请与更新证书与私钥，详见 [caddy(other configuration)](https://github.com/lxhao61/integrated-examples/tree/main/caddy(other%20configuration)) （caddy的特殊应用配置方法。）。
