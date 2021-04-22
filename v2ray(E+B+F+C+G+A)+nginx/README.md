介绍：

利用 nginx 支持 SNI 分流特性，对 Xray\v2ray（vless+tcp+tls）、Xray\v2ray（trojan+tcp+tls）、nginx（http/2 server） 进行 SNI 分流（四层转发），实现除 Xray\v2ray kcp 外共用443端口。nginx 同时为 Xray\v2ray（vless+tcp+tls）与 Xray\v2ray（trojan+tcp+tls） 提供回落服务，为 Xray\v2ray 的 gRPC 进行反向代理。包括应用如下：

1、E=vless+tcp+tls（回落/分流配置，tls由自己提供。）

2、B=vless+WS+tls（tls由vless+tcp+tls提供及处理，不需配置；另可改成或添加其它WS类应用，参考反向代理WS类的单一示例。）

3、F=trojan+tcp+tls（回落/分流配置，tls由自己提供。）

4、C=SS+v2ray-plugin+tls（tls由trojan+tcp+tls提供及处理，不需配置。）

5、G=vless+grpc+tls（tls由nginx提供及处理，不需配置；另可改成或添加vmess+grpc+tls应用，参考反向代理gRPC的单一示例。）

6、A=vless+kcp+seed（可改成vmess+kcp+seed，或添加它。）

注意：

1、Xray 版本不小于 1.4.0 或 v2ray 版本不小于v4.36.2，才完美支持 gRPC 应用。

2、采用 nginx 反向代理 gRPC，配置 nginx 时需要启用 http/2，因为 gRPC 必须使用 http/2 传输数据。使用源码编译和安装，编译时需要加入 http_ssl 和 http_v2 模块。

3、nginx 支持 h2c server，但不支持 http/1.1 server 与 h2c server 共用一个端口或一个进程（Unix Domain Socket 应用），故 Xray\v2ray（vless+tcp+tls） 与 Xray\v2ray（trojan+tcp+tls） 应用中的 http/1.1 与 h2 回落端口或进程须分开，分别对应。

4、nginx 预编译程序包一般不带支持 SNI 分流协议的模块。如要使用此项协议应用，需加 stream_ssl_preread_module 模块构建自定义模板，再进行源代码编译和安装。

5、nginx 预编译程序包可能不带支持 PROXY protocol 协议的模块。如要使用此项协议应用，需加 http_realip_module 与 stream_realip_module 两模块构建自定义模板，再进行源代码编译和安装。另编译时选取源代码版本建议不要低于1.13.11。

6、此方法采用的是 SNI 方式实现共用 443 端口，支持 Xray\v2ray（vless+tcp+tls）、Xray\v2ray（trojan+tcp+tls）、nginx（http/2 server） 完美共存，支持 vless+tcp+tls 与 trojan-tcp-tls 各自 xtls 应用，但需多个域名（多个证书或通配符证书）来标记分流。

7、配置1：采用端口分流、端口回落\分流、端口转发。配置2：采用进程分流、进程回落\分流、进程转发。配置3：采用进程分流、进程回落\分流、进程转发，且启用了 PROXY protocol。
