介绍：

利用 nginx 支持 SNI 分流特性，对 Xray\v2ray（vless+tcp+tls）、trojan-go\trojan、nginx（HTTP/2 server） 进行 SNI 分流（四层转发），实现除 Xray\v2ray 的 KCP 应用外共用443端口。nginx 同时为 Xray\v2ray（vless+tcp+tls）与 trojan-go\trojan 提供回落服务，为 Xray\v2ray 的 gRPC 进行反向代理。包括应用如下：

1、E=vless+tcp+tls（回落/分流配置，TLS由自己提供及处理。）

2、B=vless+ws+tls（TLS由vless+tcp+tls提供及处理，不需配置；另可改成或添加其它WS类应用，参考对应的服务端单一应用配置示例。）

3、C=SS+v2ray-plugin+tls（TLS由vless+tcp+tls提供及处理，不需配置。）

4、G=vless+grpc+tls（TLS由nginx提供及处理，不需配置；另可改成或添加其它gRPC类应用，参考对应的服务端单一应用配置示例。）

5、A=vless+kcp+seed（可改成vmess+kcp+seed，或添加它。）

6、trojan-go或trojan（TLS由自己提供及处理。）

注意：

1、Xray 版本不小于 v1.4.0 或 v2ray 版本不小于v4.36.2，才支持 gRPC 传输方式。

2、采用 nginx 反向代理 gRPC，配置 nginx 时需要启用 HTTP/2，因为 gRPC 必须使用 HTTP/2 传输数据。使用源码编译和安装，编译时需要加入 http_ssl 和 http_v2 模块。

3、nginx 支持 H2C server，但不支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程（Unix Domain Socket 应用）；故回落配置就必须分成 http/1.1 回落与 h2 回落两部分，以便分别对应 nginx 的 HTTP/1.1 server 与 H2C server。

4、nginx 预编译程序包可能不带支持 PROXY protocol 协议的模块。如要使用此项协议应用，需加 http_realip_module 与 stream_realip_module 两模块构建自定义模板，再进行源代码编译和安装。另编译时选取源代码版本建议不要低于1.13.11。

5、nginx 预编译程序包一般不带支持 SNI 分流协议的模块。如要使用此项协议应用，需加 stream_ssl_preread_module 模块构建自定义模板，再进行源代码编译和安装。

6、本示例采用的是 SNI 方式实现共用443端口，支持 Xray\v2ray（vless+tcp+tls）、trojan-go\trojan、nginx（HTTP/2 server） 完美共存，支持各自特色应用，但需多个域名来标记分流。

7、因 trojan-go\trojan 仅支持端口监听与端口回落，故共用回落 WEB 服务的 Xray\v2ray（vless+tcp+tls）回落也仅支持端口回落，即全部回落仅支持端口回落。

8、因 trojan-go\trojan 不支持 PROXY protocol，故共用回落 WEB 服务的 Xray\v2ray（vless+tcp+tls）回落也不能启用此项应用，即全部回落不能启用此项应用。

9、因 trojan-go 目前不支持 http/1.1 回落与 h2 回落分开，故 trojan-go 开启 Websocket 支持后只能选 http/1.1 连接及 http/1.1 回落。

10、trojan-go 完全兼容原版 trojan，服务端还有自己的特色：支持原版 trojan 应用与自己的 Websocket 应用共存；支持 CDN 流量中转(基于 WebSocket over TLS)；支持使用 AEAD 对 trojan 协议流量进行二次加密(基于 Shadowsocks AEAD)。

11、本示例配置不要使用 ACME 客户端在当前服务器上申请与更新普通证书及密钥，因普通证书及密钥申请与更新需要占用或监听80端口（或443端口），从而与当前应用端口冲突。

12、配置1：采用端口分流、端口回落\分流、端口转发。配置2：采用进程分流（对应trojan-go\trojan除外）、端口回落\分流（对应vless+ws除外）、进程转发。配置3：采用进程分流、端口回落\分流（对应vless+ws除外）、进程转发，且启用了 PROXY protocol（全部回落除外）。
