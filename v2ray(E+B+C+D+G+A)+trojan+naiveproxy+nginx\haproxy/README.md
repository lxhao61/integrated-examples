介绍：

此示例包括 v2ray（Xray）、naiveproxy（caddy）、trojan（trojan-go）应用。利用 haproxy 或 nginx 支持 SNI 分流特性，对 v2ray（vless-tcp-tls）、naiveproxy（caddy）、trojan（trojan-go）进行 SNI 分流（四层转发），实现除 v2ray（Xray） kcp 外共用443端口。caddy 同时为 v2ray（vless-tcp-tls）与 trojan（trojan-go）提供 web 回落服务，为 v2ray（Xray） 的 h2c 与 grpc 进行反向代理，为 naiveproxy 提供正向代理。包括应用如下：

1、E=vless-tcp-tls（tls由自己提供。）

2、B=vless-ws-tls（tls由vless-tcp-tls提供及处理，不需配置；另可改成或添加其它ws类应用，参考反向代理ws类的单一示例。）

3、C=SS+v2ray-plugin（tls由trojan-tcp-tls提供及处理，不需配置。）

4、D=vless-h2c-tls（tls由naiveproxy提供及处理，不需配置；另可改成或添加vmess-h2c-tls应用，参考反向代理h2的单一示例。）

5、G=vless-grpc-tls（tls由naiveproxy提供及处理，不需配置；另可改成或添加vmess-grpc-tls应用，参考反向代理grpc的单一示例。）

6、A=vless-kcp-seed（可改成vmess-kcp-seed，或添加它。）

7、naiveproxy （tls由自己提供。）

注意：

1、Xray 版本不小于 1.4.0 或 v2ray 版本不小于v4.36.2，才完美支持 grpc 应用。

2、caddy 等于或大于 v2.2.0-rc.1 版才支持 h2c proxy，即支持 v2ray（Xray） 的 h2c 反向代理。

3、caddy 等于或大于 v2.3.0 版才支持 Caddyfile 配置开启 h2c server。

4、caddy 支持 http/1.1 server 与 h2c server 共用一个端口或一个进程（Unix Domain Socket 应用）。

5、caddy 发行版不支持 PROXY protocol（接收）。如要支持 PROXY protocol 需选 caddy2-proxyprotocol 插件定制编译，或下载本人 github 中编译好的 caddy 来使用即可。

6、本示例中 naiveproxy(caddy) 的 naive_Caddyfile 配置虽然可用，但会产生很多报错日志（暂不能解决）。

7、使用本人 github 中编译好的 caddy2 文件，才可同时支持 naiveproxy、h2c server、h2c proxy 及 PROXY protocol 等应用。

8、nginx 预编译程序包一般不带支持 SNI 分流协议的模块。如要使用此项协议应用，需加 stream_ssl_preread_module 模块构建自定义模板，再进行源代码编译和安装。

9、因 trojan(trojan-go) 不支持 Unix Domain Socket，故 trojan(trojan-go) 不启用此项应用，从而回落部分仅端口回落及端口监听。

10、因 trojan(trojan-go) 不支持 PROXY protocol（接收与发送），故 trojan(trojan-go) 不启用此项应用，从而回落部分不启用 PROXY protocol（接收与发送）。另外 nginx SNI 中的 PROXY protocol 发送是针对共用端口全局模式，故配置3不再使用 nginx。

11、此方法采用的是 SNI 方式实现共用443端口，支持 v2ray（vless-ws-tls）、naiveproxy（caddy）、trojan（trojan-go）完美共存，支持各自特色应用，但需多个域名（多个证书或通配符证书）来标记分流。

12、配置1：端口转发、端口回落\分流及 haproxy 或 nginx SNI 的端口分流，没有启用 PROXY protocol。配置2：进程转发、端口回落\分流及 haproxy 或 nginx SNI 的进程分流（trojan除外），没有启用 PROXY protocol。配置3：进程转发、端口回落\分流及 haproxy SNI 的进程分流（trojan除外），启用了 PROXY protocol（回落部分除外）。

13、若采用配置2、且使用 nginx SNI 来分流的，又想 naiveproxy 开启 http/3 代理支持，可参考配置1。nginx 添加 udp 代理。naiveproxy 把进程转发改成端口转发，且 naiveproxy http/3 开启。

14、若除了实现最多应用的科学上网、还需提供实际网站服务，推荐本示例、网站服务可由 nginx 或 caddy 提供服务；否则推荐采用 v2ray(complete+h2c)+naiveproxy+trojan 示例。
