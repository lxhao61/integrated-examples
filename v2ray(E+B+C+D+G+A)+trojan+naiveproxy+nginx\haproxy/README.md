介绍：

此示例包括 Xray\v2ray、naiveproxy（caddy）、trojan（trojan-go）应用。利用 haproxy 或 nginx 支持 SNI 分流特性，对 Xray\v2ray（vless+tcp+tls）、naiveproxy（caddy）、trojan（trojan-go）进行 SNI 分流（四层转发），实现除 Xray\v2ray kcp 外共用443端口。caddy 同时为 Xray\v2ray（vless+tcp+tls）与 trojan（trojan-go）提供 web 回落服务，为 Xray\v2ray 的 h2c 与 grpc 进行反向代理，为 naiveproxy 提供正向代理。包括应用如下：

1、E=vless+tcp+tls（回落/分流配置，tls由自己提供。）

2、B=vless+WS+tls（tls由vless+tcp+tls提供及处理，不需配置；另可改成或添加其它WS类应用，参考反向代理WS类的单一示例。）

3、C=SS+v2ray-plugin+tls（tls由vless+tcp+tls提供及处理，不需配置。）

4、D=vless+h2c+tls（tls由caddy提供及处理，不需配置；另可改成或添加vmess+h2c+tls应用，参考反向代理h2的单一示例。）

5、G=vless+grpc+tls（tls由caddy提供及处理，不需配置；另可改成或添加vmess+grpc+tls应用，参考反向代理grpc的单一示例。）

6、A=vless+kcp+seed（可改成vmess+kcp+seed，或添加它。）

7、naiveproxy （tls由caddy提供。）

8、trojan或trojan-go（tls由自己提供。）

注意：

1、Xray 版本不小于 1.4.0 或 v2ray 版本不小于v4.36.2，才完美支持 grpc 应用。

2、caddy 等于或大于 v2.2.0-rc.1 版才支持 h2c proxy，即支持 Xray\v2ray 的 h2c（grpc） 反向代理。

3、caddy 等于或大于 v2.3.0 版才支持 Caddyfile 配置开启 h2c server。

4、caddy 支持 http/1.1 server 与 h2c server 共用一个端口或一个进程（Unix Domain Socket 应用）。

5、caddy 发行版不支持 PROXY protocol（接收）。如要支持 PROXY protocol 需选 caddy2-proxyprotocol 插件定制编译，或下载本人 github 中编译好的 caddy 来使用即可。

6、本示例中 naiveproxy(caddy) 的 naive_Caddyfile 配置虽然可用，但会产生很多报错日志（暂不能解决）。

7、使用本人 github 中编译好的 caddy 文件，才可同时支持 naiveproxy、h2c server、h2c proxy 及 PROXY protocol 等应用。

8、nginx 预编译程序包一般不带支持 SNI 分流协议的模块。如要使用此项协议应用，需加 stream_ssl_preread_module 模块构建自定义模板，再进行源代码编译和安装。

9、因 trojan(trojan-go) 不支持 Unix Domain Socket，故 trojan(trojan-go) 不启用此项应用，从而回落部分仅端口回落及端口监听。

10、因 trojan(trojan-go) 不支持 PROXY protocol（接收与发送），故 trojan(trojan-go) 不启用此项应用，从而回落部分不启用 PROXY protocol（接收与发送）。另外 nginx SNI 中的 PROXY protocol 发送是针对共用端口全局模式，故配置3不再使用 nginx。

11、此方法采用的是 SNI 方式实现共用443端口，支持 Xray\v2ray（vless+tcp+tls）、naiveproxy（caddy）、trojan（trojan-go）完美共存，支持各自特色应用，但需多个域名（多个证书或通配符证书）来标记分流。

12、配置1：采用端口转发、端口回落\分流、端口分流，没有启用 PROXY protocol。配置2：采用进程转发、端口回落\分流、进程分流（对应trojan除外），没有启用 PROXY protocol。配置3：采用进程转发、端口回落\分流、进程分流（对应trojan除外），启用了 PROXY protocol（端口回落除外）。

13、若采用配置2、且使用 nginx SNI 来分流的，又想 naiveproxy 开启 http/3 代理支持，可参考配置1。nginx 添加 udp 代理。naiveproxy 把进程转发改成端口转发，且 naiveproxy http/3 开启。

14、若除了实现最多应用的科学上网、还需提供实际网站服务，推荐本示例、网站服务可由 nginx 或 caddy 提供服务；否则推荐采用 [v2ray(E+B+C+D+G+A)+trojan+naiveproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BC%2BD%2BG%2BA)%2Btrojan%2Bnaiveproxy) 示例。
