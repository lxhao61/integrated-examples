介绍：

此配置包括 v2ray（Xray）、naiveproxy（caddy）应用。利用 caddy 支持 SNI 分流特性，对 v2ray（vless-tcp-tls）、v2ray（trojan-tcp-tls）、naiveproxy（caddy）进行 SNI 分流（四层转发），实现除 v2ray（Xray） kcp 外共用443端口。caddy 同时为 v2ray（vless-tcp-tls）与 v2ray（trojan-tcp-tls） 提供回落服务，为 v2ray（Xray） 的 h2c 与 grpc 进行反向代理，为 naiveproxy 提供正向代理。包括应用如下：

1、E=vless-tcp-tls（tls由自己提供。）

2、B=vless-ws-tls（tls由vless-tcp-tls提供及处理，不需配置；另可改成或添加其它ws类应用，参考反向代理ws类的单一示例。）

3、F=trojan-tcp-tls（tls由自己提供。）

4、C=SS- v2ray-plugin -tls（tls由trojan-tcp-tls提供及处理，不需配置。）

5、D=vless-h2c-tls（tls由naiveproxy提供及处理，不需配置；另可改成或添加vmess-h2c-tls应用，参考反向代理h2的单一示例。）

6、G=vless-grpc-tls（tls由naiveproxy提供及处理，不需配置；另可改成或添加vmess-grpc-tls应用，参考反向代理grpc的单一示例。）

7、A=vless-kcp-seed（可改成vmess-kcp-seed，或添加它。）

8、naiveproxy （tls由自己提供。）

注意：

1、Xray 版本不小于 1.4.0 或 v2ray 版本不小于v4.36.2，才完美支持 grpc 应用。

2、caddy 加 caddy-l4 插件定制编译的才可以实现 SNI 分流，目前仅支持使用 json 配置。特别提醒：采用改进的 caddy-l4 插件定制编译的才同时支持 PROXY protocol（发送），且可以对进程或端口分别开启 PROXY protocol（发送）。

3、caddy 等于或大于 v2.2.0-rc.1 版才支持 h2c proxy，即支持 v2ray（Xray） 的 h2c（gRPC） 反向代理。

4、caddy 支持 http/1.1 server 与 h2c server 共用一个端口或一个进程（Unix Domain Socket 应用）。

5、caddy 发行版不支持 PROXY protocol（接收）。如要支持 PROXY protocol 需选 caddy2-proxyprotocol 插件定制编译，或下载本人 github 中编译好的 caddy 来使用即可。

6、使用本人 github 中编译好的 caddy 文件，才可同时支持 naiveproxy、h2c server、h2c proxy、SNI 分流及 PROXY protocol 等应用。

7、此方法采用的是 SNI 方式实现共用443端口，支持 v2ray（vless-tcp-tls）、v2ray（trojan-tcp-tls）、naiveproxy（caddy）完美共存，支持各自特色应用，但需多个域名（多个证书或通配符证书）来标记分流。

8、配置4：端口转发、端口回落\分流及 caddy SNI 的端口分流，没有启用 PROXY protocol。配置5：进程转发、进程回落\分流及 caddy SNI 的进程分流，没有启用 PROXY protocol。配置6：进程转发、进程回落\分流及 caddy SNI 的进程分流，启用了 PROXY protocol。

9、若有实际网站服务推荐采用 v2ray(E+B+F+C+D+G+A)+naiveproxy+nginx\haproxy 示例，否则 caddy（naiveproxy）压力过大。
