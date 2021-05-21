介绍：

此配置包括 Xray\v2ray、naiveproxy（caddy）应用。利用 caddy 支持 SNI 分流特性，对 Xray\v2ray（vless+tcp+tls）、Xray\v2ray（trojan+tcp+tls）、naiveproxy（caddy）进行 SNI 分流（四层转发），实现除 Xray\v2ray kcp 外共用443端口。caddy 同时为 Xray\v2ray（vless+tcp+tls）与 Xray\v2ray（trojan+tcp+tls） 提供回落服务，为 Xray\v2ray 的 h2c 与 gRPC 进行反向代理，为 naiveproxy 提供正向代理。包括应用如下：

1、E=vless+tcp+tls（回落/分流配置，tls由自己提供。）

2、B=vless+ws+tls（tls由vless+tcp+tls提供及处理，不需配置；另可改成或添加其它WS类应用，参考反向代理WS类的单一示例。）

3、F=trojan+tcp+tls（回落/分流配置，tls由自己提供。）

4、C=SS+v2ray-plugin+tls（tls由trojan+tcp+tls提供及处理，不需配置。）

5、D=vless+h2c+tls（tls由caddy提供及处理，不需配置；另可改成或添加vmess+h2c+tls应用，参考反向代理h2c的单一示例。）

6、G=vless+grpc+tls（tls由caddy提供及处理，不需配置；另可改成或添加vmess+grpc+tls应用，参考反向代理gRPC的单一示例。）

7、A=vless+kcp+seed（可改成vmess+kcp+seed，或添加它。）

8、naiveproxy（tls由caddy提供。）

注意：

1、Xray 版本不小于 1.4.0 或 v2ray 版本不小于v4.36.2，才完美支持 gRPC 应用。

2、caddy 加 caddy-l4 插件定制编译的才可以实现 SNI 分流，目前仅支持使用 json 配置。特别提醒：采用改进的 caddy-l4 插件定制编译的才同时支持 PROXY protocol（发送），且可以对进程或端口分别开启 PROXY protocol（发送）。

3、caddy 等于或大于 v2.2.0-rc.1 版才支持 h2c proxy，即支持 Xray\v2ray 的 h2c（gRPC） 反向代理。

4、caddy 支持 http/1.1 server 与 h2c server 共用一个端口或一个进程（Unix Domain Socket 应用）。

5、caddy 发行版不支持 PROXY protocol（接收）。如要支持 PROXY protocol 需选 caddy2-proxyprotocol 插件定制编译，或下载本人 github 中编译好的 caddy 来使用即可。

6、使用本人 github 中编译好的 caddy 文件，才可同时支持 naiveproxy、h2c server、h2c proxy、SNI 分流及 PROXY protocol 等应用。

7、此方法采用的是 SNI 方式实现共用443端口，支持 Xray\v2ray（vless+tcp+tls）、Xray\v2ray（trojan+tcp+tls）、naiveproxy（caddy）完美共存，支持各自特色应用，但需多个域名（多个证书或通配符证书）来标记分流。

8、不要使用非 caddy（自带 ACME 客户端） 的 ACME 客户端在当前服务器上申请与更新普通证书及密钥，因普通证书及密钥申请与更新需占用或监听80端口（或443端口），从而与当前应用端口冲突。

9、Xray 所需证书及密钥推荐使用 caddy 申请，配合 Xray（版本必须不低于v1.3.0）自动重载证书及密钥（OCSP Stapling），可实现证书及密钥申请与更新全自动化。

10、配置1：采用端口分流、端口回落\分流、端口转发。配置2：采用进程分流、进程回落\分流、端口转发。配置3：采用进程分流、进程回落\分流、端口转发，且启用了 PROXY protocol。

11、若有实际网站服务推荐采用 [v2ray(E+B+F+C+D+G+A)+naiveproxy+nginx\haproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BF%2BC%2BD%2BG%2BA)%2Bnaiveproxy%2Bnginx%5Chaproxy) 示例，否则 caddy（naiveproxy）压力过大。
