介绍：

利用 nginx 或 haproxy 支持 SNI 分流特性，对 Xray\v2ray（vless+tcp+tls）、Xray\v2ray（trojan+tcp+tls）、caddy（HTTPS server） 进行 SNI 分流（四层转发），实现除 Xray\v2ray 的 KCP 应用外共用443端口。另外 caddy 为 Xray\v2ray（vless+tcp+tls） 与 Xray\v2ray（trojan+tcp+tls） 提供回落服务，为 Xray\v2ray 的 H2C 与 gRPC 进行反向代理，为 naiveproxy 提供正向代理。包括应用如下：

1、E=vless+tcp+tls（回落/分流配置，TLS由自己提供及处理。）

2、B=vless+ws+tls（TLS由vless+tcp+tls提供及处理，不需配置；另可改成或添加其它WS类应用，参考对应的服务端单一应用配置示例。）

3、F=trojan+tcp+tls（回落/分流配置，TLS由自己提供及处理。）

4、C=SS+v2ray-plugin+tls（TLS由trojan+tcp+tls提供及处理，不需配置；另可添加其它WS类应用，参考对应的服务端单一应用配置示例。）

5、D=vless+h2c+tls（TLS由caddy提供及处理，不需配置；另可改成或添加其它H2C类应用，参考对应的服务端单一应用配置示例。）

6、G=vless+grpc+tls（TLS由caddy提供及处理，不需配置；另可改成或添加其它gRPC类应用，参考对应的服务端单一应用配置示例。）

7、A=vless+kcp+seed（可改成vmess+kcp+seed，或添加它。）

8、naiveproxy（带有forwardproxy插件的caddy才支持naiveproxy应用，否则仅上边应用。TLS由caddy提供及处理。）

注意：

1、v2ray 版本不小于 v4.31.0 才支持 trojan 协议。

2、Xray 版本不小于 v1.4.0 或 v2ray 版本不小于v4.36.2，才支持 gRPC 传输方式。

3、caddy 版本不小于 v2.2.0-rc.1 才支持 H2C proxy，即支持 Xray\v2ray 的 H2C（gRPC） 反向代理。

4、caddy 版本不小于 v2.3.0 才支持 Caddyfile 配置开启 H2C server。

5、caddy 支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程（Unix Domain Socket 应用）。

6、使用本人 Releases 中编译好的 caddy 文件，可同时支持 H2C server、H2C proxy、naiveproxy 及 PROXY protocol 接收等应用。

7、本示例 caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可。

8、nginx 支持 SNI 分流，需要 nginx 包含 stream_core_module 和 stream_ssl_preread_module 模块。

9、本示例采用的是 SNI 方式实现共用443端口，支持 Xray\v2ray（vless+tcp+tls）、Xray\v2ray（trojan+tcp+tls）、caddy（HTTPS server） 完美共存，支持各自特色应用，但需多个域名来标记分流。

10、不要使用非 caddy（自带 ACME 客户端）的 ACME 客户端在当前服务器上申请与更新普通证书及密钥，因普通证书及密钥申请与更新需占用或监听80端口（或443端口），从而与当前应用端口冲突。

11、Xray 所需证书及密钥推荐使用 caddy 申请，配合 Xray（版本必须不低于v1.3.0）自动重载证书及密钥（OCSP Stapling），可实现证书及密钥申请与更新全自动化。

12、配置1：采用端口分流、端口回落\分流、端口转发。配置2：采用进程分流、进程回落\分流、端口转发。配置3：采用进程分流、进程回落\分流、端口转发，且启用了 PROXY protocol。

13、若采用配置2/配置3、且使用 nginx SNI 来分流的，想 naiveproxy 同时开启 HTTP/3 代理支持，可参考配置1。方法：nginx 中添加对应 HTTPS server 的定向 UDP 转发配置，对应 HTTPS server 的进程转发改为端口转发；caddy 中对应 HTTPS server 的进程监听改为端口监听，HTTPS server 开启 HTTP/3 支持。

14、若除了实现最多应用的科学上网、还需提供实际网站服务，推荐本示例（实际网站服务可由 nginx 或 caddy 提供服务）；否则推荐采用 [v2ray(E+B+F+C+D+G+A)+naiveproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BF%2BC%2BD%2BG%2BA)%2Bnaiveproxy) 示例。
