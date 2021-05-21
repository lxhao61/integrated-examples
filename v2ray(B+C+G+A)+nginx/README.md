介绍：

利用 nginx 支持 SNI 分流特性，对 http/1.1 server 与 http/2 server 进行 SNI 分流（四层转发），实现 http/1.1 server 与 http/2 server 各自反向代理 WebSocket（http/1.1） 与 gRPC（http/2） 后共用443端口。包括应用如下：

1、B=vless+ws+tls（tls由nginx提供及处理，不需配置；另可改成或添加其它WS类应用，参考反向代理WS类的单一示例。）

2、C=SS+v2ray-plugin+tls（tls由nginx提供及处理，不需配置。）

3、G=vless+grpc+tls（tls由nginx提供及处理，不需配置；另可改成或添加vmess+grpc+tls应用，参考反向代理gRPC的单一示例。）

4、A=vless+kcp+seed（可改成vmess+kcp+seed，或添加它。）

注意：

1、Xray 版本不小于 1.4.0 或 v2ray 版本不小于v4.36.2，才完美支持 gRPC 应用。

2、nginx 预编译程序包一般不带支持 SNI 分流协议的模块。如要使用此项协议应用，需加 stream_ssl_preread_module 模块构建自定义模板，再进行源代码编译和安装。

3、nginx 预编译程序包可能不带支持 PROXY protocol 协议的模块。如要使用此项协议应用，需加 http_realip_module 与 stream_realip_module 两模块构建自定义模板，再进行源代码编译和安装。另编译时选取源代码版本建议不要低于1.13.11。

4、采用 nginx 反向代理 gRPC，配置 nginx 时需要启用 http/2，因为 gRPC 必须使用 http/2 传输数据。使用源码编译和安装，编译时需要加入 http_ssl 和 http_v2 模块。

5、nginx 支持 http/2 server，但不支持 http/1.1 server 与 http/2 server 共用一个端口或一个进程（Unix Domain Socket 应用），故两者都启用必须分开。采用 SNI 方式实现共用443端口，需多个域名（多个证书或通配符证书）来标记区分。

6、若系统版本过低，其对应发行版仓库自带 nginx 预编译程序包可能不支持 tls1.3；如需要支持 tls1.3，必须先升级 OpenSSl 版本大于 1.1.1，再进行 nginx 源代码编译和安装。

7、不要使用 ACME 客户端在当前服务器上申请与更新普通证书及密钥，因普通证书及密钥申请与更新需要占用或监听80端口（或443端口），从而与当前应用端口冲突。

8、配置1：采用端口分流、端口转发，且启用了 PROXY protocol。配置2：采用进程分流、进程转发（SS+v2ray-plugin采用端口转发），且启用了 PROXY protocol。
