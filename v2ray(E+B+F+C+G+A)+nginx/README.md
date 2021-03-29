介绍：

利用 nginx 支持 SNI 分流特性，对 v2ray（vless+tcp+tls）、v2ray（trojan+tcp+tls）、nginx（http/2 server） 进行 SNI 分流（四层转发），实现除 v2ray kcp 外共用443端口。nginx 同时为 v2ray（vless+tcp+tls）与 v2ray（trojan+tcp+tls） 提供回落服务，为 v2ray（Xray） 的 grpc 进行反向代理。包括应用如下：

1、E=vless+tcp+tls（tls由自己提供。）

2、B=vless+WS+tls（tls由vless+tcp+tls提供及处理，不需配置；另可改成或添加其它WS类应用，参考反向代理WS类的单一示例。）

3、F=trojan+tcp+tls（tls由自己提供。）

4、C=SS+v2ray-plugin+tls（tls由trojan+tcp+tls提供及处理，不需配置。）

5、G=vless+grpc+tls（tls由nginx提供及处理，不需配置；另可改成或添加vmess+grpc+tls应用，参考反向代理grpc的单一示例。）

6、A=vless+kcp+seed（可改成vmess+kcp+seed，或添加它。）

注意：

1、Xray 版本不小于 1.4.0 或 v2ray 版本不小于v4.36.2，才完美支持 grpc 应用。

2、nginx 支持 h2c server，但不支持 http/1.1 server 与 h2c server 共用一个端口或一个进程（Unix Domain Socket 应用），故 v2ray（vless+tcp+tls） 或 v2ray（trojan+tcp+tls） 的端口回落或进程回落必须分开，分别对应 http/1.1 与 h2 回落。

3、nginx 不支持 h2c proxy，故 nginx 不能实现 v2ray 的 h2c（http/2）反向代理。

4、nginx 预编译程序包一般不带支持 SNI 分流协议的模块。如要使用此项协议应用，需加 stream_ssl_preread_module 模块构建自定义模板，再进行源代码编译和安装。

5、nginx 预编译程序包可能不带支持 PROXY protocol 协议的模块。如要使用此项协议应用，需加 http_realip_module 与 stream_realip_module 两模块构建自定义模板，再进行源代码编译和安装。另编译时选取源代码版本建议不要低于1.13.11。

6、此方法采用的是 SNI 方式实现共用 443 端口，支持 v2ray（vless+tcp+tls）、v2ray（trojan+tcp+tls）、nginx（http/2 server） 完美共存，支持 vless+tcp+tls 与 trojan-tcp-tls 各自 xtls 应用，但需多个域名（多个证书或通配符证书）来标记分流。

7、配置1：端口转发、端口回落\分流及 nginx SNI 的端口分流，没有启用 PROXY protocol。配置2：进程转发、进程回落\分流及 nginx SNI 的进程分流，没有启用 PROXY protocol。配置3：进程转发、进程回落\分流及 nginx SNI 的进程分流，启用了 PROXY protocol。
