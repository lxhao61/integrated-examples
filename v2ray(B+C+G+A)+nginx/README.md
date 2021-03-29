介绍：

因 nginx 不支持 http/1.1 server 与 h2 server 共用一个端口或一个进程（Unix Domain Socket 应用），利用 nginx 支持 SNI 分流特性，对 http/1.1 server 与 h2 server 进行 SNI 分流（四层转发），实现 WebSocket（http/1.1） 的反向代理与 gRPC（h2c） 的反向代理共用443端口。包括应用如下：

1、B=vless+ws+tls（tls由nginx提供及处理，不需配置；另可改成或添加其它ws类应用，参考反向代理ws类的单一示例。）

2、C=SS+v2ray-plugin+tls（tls由nginx提供及处理，不需配置。）

3、G=vless+grpc+tls（tls由nginx提供及处理，不需配置；另可改成或添加vmess+grpc+tls应用，参考反向代理grpc的单一示例。）

4、A=vless+kcp+seed（可改成vmess+kcp+seed，或添加它。）

注意：

1、Xray 版本不小于 1.4.0 或 v2ray 版本不小于v4.36.2，才完美支持 gRPC（gRPC是基于HTTP/2标准设计）应用。

2、若系统版本过低，其对应发行版仓库自带 nginx 预编译程序包可能不支持 tls1.3；如需要支持 tls1.3，必须先升级 OpenSSl 版本大于 1.1.1，再进行 nginx 源代码编译和安装。

3、nginx 预编译程序包一般不带支持 SNI 分流协议的模块。如要使用此项协议应用，需加 stream_ssl_preread_module 模块构建自定义模板，再进行源代码编译和安装。

4、nginx 预编译程序包可能不带支持 PROXY protocol 协议的模块。如要使用此项协议应用，需加 http_realip_module 与 stream_realip_module 两模块构建自定义模板，再进行源代码编译和安装。另编译时选取源代码版本建议不要低于1.13.11。

5、nginx 支持 h2c server，但不支持 http/1.1 server 与 h2 server 共用一个端口或一个进程（Unix Domain Socket 应用），故两者都启用必须分开。采用 SNI 方式实现共用443端口，需多个域名（多个证书或通配符证书）来标记区分。

6、nginx 不支持 h2c proxy，故 nginx 不能实现 v2ray（Xray） 的 h2c（http/2）反向代理。

7、配置1：nginx SNI 的端口分流及启用了 PROXY protocol，端口转发。配置2：nginx SNI 的进程分流及启用了 PROXY protocol；vless+ws+tls应用进程转发，其它端口转发。
