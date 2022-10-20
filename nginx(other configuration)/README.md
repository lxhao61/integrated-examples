nginx SNI 分流的配置方法

此方法可以解决 Xray 或 v2ray 应用与网站应用（原网站不想做回落网站，或 nginx、caddy 等有多个网站应用。）共用443端口问题。

注意：

1、nginx 支持 SNI 分流，需要 nginx 包含 stream_core_module 和 stream_ssl_preread_module 模块。

2、nginx 支持 HTTP/2 server，需要 nginx 包含 http_v2_module 和 http_ssl_module 模块。

3、nginx 支持 TLSv1.3，需要 nginx 包含版本大于 1.1.1 的 OpenSSl 库和 http_ssl_module 模块。

4、nginx 支持 HTTP 功能块接收 PROXY protocol，需要 nginx 包含 http_realip_module 模块。

5、1_SNI_nginx.conf 采用 Local Loopback 连接，实现 nginx SNI 的端口分流。

6、2_SNI_nginx.conf 采用 UDS 连接，实现 nginx SNI 的进程分流。

7、也可以用 haproxy SNI、caddy SNI 等分流来解决问题（相同方法）。但若已采用 nginx 来做回落 WEB 服务器，不推荐另外增加 haproxy SNI 等分流来解决；若采用非 nginx 来做回落 WEB 服务器，推荐使用 nginx SNI、haproxy SNI、caddy SNI 等分流解决。haproxy SNI 配置示例参考用 haproxy SNI 分流的 haproxy 配置示例，caddy SNI 配置示例参考‘caddy(other configuration)’中 caddy SNI 分流的配置方法。
