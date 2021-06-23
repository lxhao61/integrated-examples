介绍：

此配置包括 Xray\v2ray、naiveproxy（caddy）应用。利用 nginx 或 haproxy 支持 SNI 分流特性，对 Xray\v2ray（vless+tcp+tls）、Xray\v2ray（trojan+tcp+tls）、naiveproxy（caddy） 进行 SNI 分流（四层转发），实现除 Xray\v2ray kcp 外共用443端口。另外 caddy 为 Xray\v2ray（vless+tcp+tls） 与 Xray\v2ray（trojan+tcp+tls） 提供回落服务，为 Xray\v2ray 的 h2c 与 gRPC 进行反向代理，为 naiveproxy 提供正向代理。包括应用如下：

1、E=vless+tcp+tls（回落/分流配置，tls由自己提供。）

2、B=vless+ws+tls（tls由vless+tcp+tls提供及处理，不需配置；另可改成或添加其它WS类应用，参考对应的服务端单一应用配置示例。）

3、F=trojan+tcp+tls（回落/分流配置，tls由自己提供。）

4、C=SS+v2ray-plugin+tls（tls由trojan+tcp+tls提供及处理，不需配置。）

5、D=vless+h2c+tls（tls由caddy提供及处理，不需配置；另可改成或添加其它h2c类应用，参考对应的服务端单一应用配置示例。）

6、G=vless+grpc+tls（tls由caddy提供及处理，不需配置；另可改成或添加其它gRPC类应用，参考对应的服务端单一应用配置示例。）

7、A=vless+kcp+seed（可改成vmess+kcp+seed，或添加它。）

8、naiveproxy（tls由caddy提供。）

注意：

1、Xray 版本不小于 1.4.0 或 v2ray 版本不小于v4.36.2，才完美支持 gRPC 应用。

2、caddy 不小于 v2.2.0-rc.1 版才支持 h2c proxy，即支持 Xray\v2ray 的 h2c（gRPC） 反向代理。

3、caddy 不小于 v2.3.0 版才支持 Caddyfile 配置开启 h2c server。

4、caddy 支持 http/1.1 server 与 h2c server 共用一个端口或一个进程（Unix Domain Socket 应用）。

5、caddy 发行版不支持 PROXY protocol（接收）。如要支持 PROXY protocol 需选 caddy2-proxyprotocol 插件定制编译，或下载本人 github 中编译好的 caddy 来使用即可。

6、使用本人 github 中编译好的 caddy 文件，才可同时支持 naiveproxy、h2c server、h2c proxy 及 PROXY protocol 等应用。

7、nginx 预编译程序包一般不带支持 SNI 分流协议的模块。如要使用此项协议应用，需加 stream_ssl_preread_module 模块构建自定义模板，再进行源代码编译和安装。

8、nginx 预编译程序包可能不带支持 PROXY protocol 协议的模块。如要使用此项协议应用，需加 http_realip_module 与 stream_realip_module 两模块构建自定义模板，再进行源代码编译和安装。另编译时选取源代码版本建议不要低于1.13.11。

9、此方法采用的是 SNI 方式实现共用443端口，支持 Xray\v2ray（vless+tcp+tls）、Xray\v2ray（trojan+tcp+tls）、naiveproxy（caddy）完美共存，支持各自特色应用，但需多个域名（多个证书或通配符证书）来标记分流。

10、本示例中 caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可。

11、不要使用非 caddy（自带 ACME 客户端） 的 ACME 客户端在当前服务器上申请与更新普通证书及密钥，因普通证书及密钥申请与更新需占用或监听80端口（或443端口），从而与当前应用端口冲突。

12、Xray 所需证书及密钥推荐使用 caddy 申请，配合 Xray（版本必须不低于v1.3.0）自动重载证书及密钥（OCSP Stapling），可实现证书及密钥申请与更新全自动化。

13、配置1：采用端口分流、端口回落\分流、端口转发。配置2：采用进程分流、进程回落\分流、端口转发。配置3：采用进程分流、进程回落\分流、端口转发，且启用了 PROXY protocol。

14、若采用配置2/配置3、且使用 nginx SNI 来分流的，想 naiveproxy 开启 http/3 代理支持，可参考配置1。方法：nginx 添加定向 UDP 转发；caddy 与 nginx 中对应 https 部分的进程转发改为端口转发，且 caddy 的 http/3 开启。

15、若除了实现最多应用的科学上网、还需提供实际网站服务，推荐本示例、网站服务可由 nginx 或 caddy 提供服务；否则推荐采用 [v2ray(E+B+F+C+D+G+A)+naiveproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BF%2BC%2BD%2BG%2BA)%2Bnaiveproxy) 示例。
