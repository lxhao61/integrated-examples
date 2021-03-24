介绍：

v2ray（Xray） 前置（监听443端口），利用 trojan-tcp-tls 强大的回落/分流特性，实现除 v2ray（Xray） kcp 外共用443端口。trojan-tcp-tls 以 h2 或 http/1.1 自适应协商连接，分流 ws（WebSocket）连接，其它连接回落给 caddy；caddy 再处理，对 h2c 与 grpc 进行反向代理，若有 naiveproxy 就进行正向代理。包括应用如下：

1、trojan-tcp-tls（回落/分流配置。）

2、vless-ws-tls（tls由trojan-tcp-tls提供及处理，不需配置；另可改成或添加其它ws类应用，参考反向代理ws类的单一示例。）

3、SS- v2ray-plugin-tls（tls由trojan-tcp-tls提供及处理，不需配置。）

4、vless-h2c-tls（tls由trojan-tcp-tls提供及处理，不需配置；另可改成或添加vmess-h2c-tls应用，参考反向代理h2c的单一示例。）

5、vless-grpc-tls（tls由trojan-tcp-tls提供及处理，不需配置；另可改成或添加vmess-grpc-tls应用，参考反向代理grpc的单一示例。）

6、vless-kcp-seed（可改成vmess-kcp-seed，或添加它。）

7、naiveproxy （带有forwardproxy插件的caddy才支持naiveproxy应用，否则仅上边应用。tls由trojan-tcp-tls提供及处理，不需配置。）

注意：

1、Xray 版本不小于 1.4.0 或 v2ray 版本不小于v4.36.2，才完美支持 grpc 应用。

2、caddy 等于或大于 v2.2.0-rc.1 版才支持 h2c proxy，即支持 v2ray（Xray） 的 h2c（gRPC） 反向代理。

3、caddy 等于或大于 v2.3.0 版才支持 Caddyfile 配置开启 h2c server。

4、caddy 支持 http/1.1 server 与 h2c server 共用一个端口或一个进程（Unix Domain Socket 应用）。

5、caddy 发行版不支持 PROXY protocol（接收）。如要支持 PROXY protocol 需选 caddy2-proxyprotocol 插件定制编译，或下载本人 github 中编译好的 caddy 来使用即可。

6、本示例中 caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可，但目前 naive_Caddyfile 配置虽然可用，但会产生很多报错日志（暂不能解决）。

7、使用本人 github 中编译好的 caddy 文件，才可同时支持 h2c server、h2c proxy、naiveproxy 及 PROXY protocol 等应用。

8、支持 ws（WebSocket）与 grpc 的 CDN 加速。

9、配置1：端口转发、端口回落\分流，没有启用 PROXY protocol。配置2：进程转发、进程回落\分流，没有启用 PROXY protocol。配置3：进程转发、进程回落\分流，启用了 PROXY protocol。
