nginx SNI 分流的配置方法

此方法可以解决 Xray\v2ray 应用与网站应用（原网站不想做回落网站，或 nginx\caddy 等有多个网站应用。）共用443端口问题。

注意：

1、nginx 预编译程序包一般不带支持 SNI 分流协议的模块。如要使用此项协议应用，需加 stream_ssl_preread_module 模块构建自定义模板，再进行源代码编译和安装。

2、nginx 预编译程序包可能不带支持 PROXY protocol 协议的模块。如要使用此项协议应用，需加 http_realip_module 与 stream_realip_module 两模块构建自定义模板，再进行源代码编译和安装。另编译时选取源代码版本建议不要低于1.13.11。

3、若系统版本过低，其对应发行版仓库自带 nginx 预编译程序包可能不支持 tls1.3；如需要支持 tls1.3，必须先升级 OpenSSl 版本大于 1.1.1，再进行 nginx 源代码编译和安装。

4、1_SNI_nginx.conf 采用 Local Loopback 连接，实现 nginx SNI 的端口分流。端口分流配置虽然效率稍低，但可适用任意系统服务器。

5、2_SNI_nginx.conf 采用 Unix Domain Socket 连接，实现 nginx SNI 的进程分流。进程分流配置效率高，但在 Windows 10 Build 17036 之前版本不可用。

6、本示例的省略部分各自参考启用 nginx SNI 分流的配置示例。

7、相关示例已配置 nginx SNI 分流共用端口，此配置仅备份及参考等。

8、也可以用 haproxy SNI、caddy SNI 等分流来解决问题（相同方法）。但若已采用 nginx 来做回落 web 服务器，不推荐另外增加 haproxy SNI 等分流来解决；若采用非 nginx 来做回落 web 服务器，推荐使用 nginx SNI、haproxy SNI、caddy SNI 等分流解决。haproxy SNI 配置示例参考示例中用 haproxy SNI 分流的 haproxy 配置，caddy SNI 配置示例参考‘caddy(other configuration)’中 caddy SNI 分流的配置方法。
