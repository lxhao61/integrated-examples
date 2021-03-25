一、回落终极部署/套娃方式（配置1/配置2/配置3）

v2ray（Xray） 前置（监听443端口），vless-tcp-tls 以 h2 或 http/1.1 自适应协商连接，分流 ws（WebSocket）连接，回落给 trojan-tcp，trojan-tcp 处理后再回落给 caddy。其应用如下：

1、vless-tcp-tls（回落/分流配置。）

2、vless-ws-tls（tls由vless-tcp-tls提供及处理，不需配置；另可改成或添加其它ws类应用，参考反向代理ws类的单一示例。）

3、trojan-tcp-tls（tls由vless-tcp-tls提供及处理，不需配置。）

注意：

1、v2ray v4.31.0 版本及以后才支持 trojan 协议。

2、caddy 等于或大于 v2.3.0 版才支持 Caddyfile 配置开启 h2c server。

3、caddy 支持 http/1.1 server 与 h2c server 共用一个端口或一个进程（Unix Domain Socket 应用）。

4、caddy 发行版不支持 PROXY protocol（接收）。如要支持 PROXY protocol 需选 caddy2-proxyprotocol 插件定制编译，或下载本人 github 中编译好的 caddy 来使用即可。

5、本示例中 caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可（效果一样）。

6、此方法采用的是套娃方式实现共用443端口，支持 vless-tcp-tls 与 trojan-tcp-tls 完美共存，且仅需要一个域名及普通证书即可搞定，但 vless-tcp-tls 不支持 xtls 应用。

7、配置1：端口转发、端口回落\分流，没有启用 PROXY protocol。配置2：进程转发、进程回落\分流，没有启用 PROXY protocol。配置3：进程转发、进程回落\分流，启用了 PROXY protocol。

二、caddy2 SNI 分流共用443端口（配置4/配置5/配置6）

利用 caddy 支持 SNI 分流特性，对 vless-tcp-tls 与 trojan-tcp-tls 进行 SNI 分流（四层转发），实现共用443端口。vless-tcp-tls 以 h2 或 http/1.1 自适应协商连接，分流 ws（WebSocket）连接，非 v2ray（Xray） 的 web 连接回落给 caddy。trojan-tcp-tls 也以 h2 或 http/1.1 自适应协商连接，非 v2ray（Xray） 的 web 连接也回落给 caddy。v2ray（Xray） 包括应用如下：

1、vless-tcp-tls（回落/分流配置。）

2、vless-ws-tls（tls由vless-tcp-tls提供及处理，不需配置；另可改成或添加其它ws类应用，参考反向代理ws类的单一示例。）

3、trojan-tcp-tls（回落配置。）

注意：

1、v2ray v4.31.0 版本及以后才支持 trojan 协议。

2、caddy 加 caddy-l4 插件定制编译的才可以实现 SNI 分流，目前仅支持使用 json 配置。特别提醒：采用改进的 caddy-l4 插件定制编译的才同时支持 PROXY protocol（发送），且可以对进程或端口分别开启 PROXY protocol（发送）。

3、caddy 支持 http/1.1 server 与 h2c server 共用一个端口或一个进程（Unix Domain Socket 应用）。

4、caddy 发行版不支持 PROXY protocol（接收）。如要支持 PROXY protocol 需选 caddy2-proxyprotocol 插件定制编译，或下载本人 github 中编译好的 caddy 来使用即可。

5、使用本人 github 中编译好的 caddy 文件，才可同时支持 SNI 分流、h2c server及 PROXY protocol 等应用。

6、此方法采用的是 SNI 方式实现共用443端口，支持 vless-tcp-tls 与 trojan-tcp-tls 完美共存，支持各自 xtls 应用，但需多个域名（多个证书或通配符证书）来标记分流。

7、配置4：端口转发、端口回落\分流及 caddy SNI 的端口分流，没有启用 PROXY protocol。配置5：进程转发、进程回落\分流及 caddy SNI 的进程分流，没有启用 PROXY protocol。配置6：进程转发、进程回落\分流及 caddy SNI 的进程分流，启用了 PROXY protocol。
