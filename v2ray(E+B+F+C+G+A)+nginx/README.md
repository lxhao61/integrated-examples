介绍：

利用 nginx 支持 SNI 分流特性，对 Xray\v2ray（vless+tcp+tls）、Xray\v2ray（trojan+tcp+tls）、nginx（HTTP/2 server） 进行 SNI 分流（四层转发），实现除 Xray\v2ray 的 KCP 应用外共用443端口。nginx 同时为 Xray\v2ray（vless+tcp+tls）与 Xray\v2ray（trojan+tcp+tls） 提供回落服务，为 Xray\v2ray 的 gRPC 进行反向代理。包括应用如下：

1、E=vless+tcp+tls（回落/分流配置，TLS由自己提供及处理。）

2、B=vless+ws+tls（TLS由vless+tcp+tls提供及处理，不需配置；另可改成或添加其它WS类应用，参考对应的服务端单一应用配置示例。）

3、F=trojan+tcp+tls（回落/分流配置，TLS由自己提供及处理。）

4、C=SS+v2ray-plugin+tls（TLS由trojan+tcp+tls提供及处理，不需配置；另可添加其它WS类应用，参考对应的服务端单一应用配置示例。）

5、G=vless+grpc+tls（TLS由nginx提供及处理，不需配置；另可改成或添加其它gRPC类应用，参考对应的服务端单一应用配置示例。）

6、A=vless+kcp+seed（可改成vmess+kcp+seed，或添加它。）

注意：

1、v2ray 版本不小于 v4.31.0 才支持 trojan 协议。

2、Xray 版本不小于 v1.4.0 或 v2ray 版本不小于v4.36.2，才支持 gRPC 传输方式。

3、nginx 支持 SNI 分流，需要 nginx 包含 stream_core_module 和 stream_ssl_preread_module 模块。

4、nginx 支持 HTTP/2 server、gRPC proxy 及 H2C server，需要 nginx 包含 http_v2_module 和 http_ssl_module 模块。

5、nginx 支持 TLSv1.3，需要 nginx 包含版本大于 1.1.1 的 OpenSSl 库和 http_ssl_module 模块。

6、nginx 支持 PROXY protocol 接收，需要 nginx 包含 http_realip_module 及 stream_realip_module（可选）模块。

7、nginx 支持 H2C server，但不支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程（Unix Domain Socket 应用）；故回落配置就必须分成 http/1.1 回落与 h2 回落两部分，以便分别对应 nginx 的 HTTP/1.1 server 与 H2C server。

8、本示例采用的是 SNI 方式实现共用 443 端口，支持 Xray\v2ray（vless+tcp+tls）、Xray\v2ray（trojan+tcp+tls）、nginx（HTTP/2 server） 完美共存，支持 vless+tcp+tls 与 trojan-tcp-tls 各自 xtls 应用，但需多个域名来标记分流。

9、不要使用 ACME 客户端在当前服务器上申请与更新普通证书及密钥，因普通证书及密钥申请与更新需要占用或监听80端口（或443端口），从而与当前应用端口冲突。

10、配置1：采用端口分流、端口回落\分流、端口转发。配置2：采用进程分流、进程回落\分流、进程转发。配置3：采用进程分流、进程回落\分流、进程转发，且启用了 PROXY protocol。

11、因 v2ray 的 bug，trojan+tcp+tls 应用无法支持 h2 回落，故若使用 v2ray 的 trojan+tcp+tls 应用需删除所有 h2 连接及回落，保留 http/1.1 连接及回落即可。
