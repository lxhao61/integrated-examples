介绍：

利用 nginx 支持 SNI 分流特性，对 Xray\v2ray（vless+tcp+tls）、trojan（trojan-go）、nginx（http/2 server） 进行 SNI 分流（四层转发），实现除 Xray\v2ray kcp 外共用443端口。nginx 同时为 Xray\v2ray（vless+tcp+tls）与 trojan（trojan-go） 提供回落服务，为 Xray\v2ray 的 grpc 进行反向代理。包括应用如下：

1、E=vless+tcp+tls（回落/分流配置，tls由自己提供。）

2、B=vless+WS+tls（tls由vless+tcp+tls提供及处理，不需配置；另可改成或添加其它WS类应用，参考反向代理WS类的单一示例。）

3、C=SS+v2ray-plugin+tls（tls由vless+tcp+tls提供及处理，不需配置。）

4、G=vless+grpc+tls（tls由nginx供及处理，不需配置；另可改成或添加vmess+grpc+tls应用，参考反向代理grpc的单一示例。）

5、A=vless+kcp+seed（可改成vmess+kcp+seed，或添加它。）

6、trojan或trojan-go（tls由自己提供。）

注意：

1、Xray 版本不小于 1.4.0 或 v2ray 版本不小于v4.36.2，才完美支持 grpc 应用。

2、采用 nginx 反向代理 gRPC，配置 nginx 时需要启用 http/2，因为 gRPC 必须使用 HTTP/2 传输数据。使用源码编译和安装，编译时需要加入 http_ssl 和 http_v2 模块。

3、因 trojan(trojan-go) 不支持 Unix Domain Socket，故 trojan（trojan-go） 不启用此项应用，从而回落部分仅端口回落及端口监听。

4、因 nginx SNI 中的 PROXY protocol（发送）是针对共用端口全部开启（全局模式），而 trojan（trojan-go） 不支持 PROXY protocol（接收与发送），故所有配置不启用此项应用。

5、nginx 支持 h2c server，但不支持 http/1.1 server 与 h2c server 共用一个端口或一个进程（Unix Domain Socket 应用），故 v2ray（vless+tcp+tls） 或 trojan（trojan-go） 的端口回落或进程回落必须分开，分别对应 http/1.1 与 h2 回落。

6、nginx 预编译程序包一般不带支持 SNI 分流协议的模块。如要使用此项协议应用，需加 stream_ssl_preread_module 模块构建自定义模板，再进行源代码编译和安装。

7、此方法采用的是 SNI 方式实现共用443端口，支持 v2ray（vless+tcp+tls）、trojan（trojan-go）、nginx（http/2 server） 完美共存，支持各自特色应用，但需多个域名（多个证书或通配符证书）来标记分流。

8、nginx 不支持 h2c proxy，故 nginx 不能实现 Xray\v2ray 的 h2c 反向代理。

9、配置1：采用端口分流、端口回落\分流、端口转发。配置2：采用进程分流（对应trojan采用端口分流）、端口回落\分流（分流vless+WS采用进程分流）、端口转发。
