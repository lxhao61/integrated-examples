nginx SNI 分流的配置方法

此方法可以解决 Xray\v2ray 应用与网站应用（原网站不想做回落网站，或 nginx\caddy 等有多个网站应用。）共用443端口问题。

注意：

1、nginx 支持 SNI 分流，需 nginx 加入了 stream_ssl_preread_module 模块编译。

2、nginx 支持 HTTP/2，需 nginx 加入了 http_ssl_module 和 http_v2_module 模块编译。

3、nginx 支持 TLSv1.3，需使用 OpenSSl 版本大于 1.1.1 编译。

4、nginx 支持 PROXY protocol 接收，需 nginx 加入了 http_realip_module 及 stream_realip_module（可选）模块编译。另 nginx 编译时选取源代码版本不要低于 1.13.11。

5、1_SNI_nginx.conf 采用 Local Loopback 连接，实现 nginx SNI 的端口分流。端口分流配置虽然效率稍低，但可适用任意系统服务器。

6、2_SNI_nginx.conf 采用 Unix Domain Socket 连接，实现 nginx SNI 的进程分流。进程分流配置效率高，但在 Windows 10 Build 17036 之前版本不可用。

7、本示例的省略部分各自参考启用 nginx SNI 分流的配置示例。

8、相关示例已配置 nginx SNI 分流共用端口，此配置仅备份及参考等。

9、也可以用 haproxy SNI、caddy SNI 等分流来解决问题（相同方法）。但若已采用 nginx 来做回落 WEB 服务器，不推荐另外增加 haproxy SNI 等分流来解决；若采用非 nginx 来做回落 WEB 服务器，推荐使用 nginx SNI、haproxy SNI、caddy SNI 等分流解决。haproxy SNI 配置示例参考示例中用 haproxy SNI 分流的 haproxy 配置，caddy SNI 配置示例参考‘caddy(other configuration)’中 caddy SNI 分流的配置方法。
