介绍：

Xray 前置（监听 443 端口），利用 VLESS+Vision+REALITY 回落 VLESS+H2C（套娃），实现 VLESS+Vision+REALITY 与 VLESS+H2C+REALITY 应用共用 443 端口，其应用如下：

1、M=VLESS+Vision+REALITY（回落与转发配置，REALITY 所需 TLS 由外部网站提供。）

2、K=VLESS+H2C+REALITY（REALITY 由 VLESS+Vision+REALITY 启用及处理，不需配置。）

注意：

1、Xray 版本不小于 v1.8.0 才支持 REALITY。

2、VLESS+H2C+REALITY 虽然因为使用 HTTP/2 传输方式（自带多路复用）减轻了 TLS in TLS 特征，但是因为无法完全去除；故本示例仅推荐目标网站使用外部的才可使用。

3、目标网站使用外部的，其网站最低要求：国外网站、域名非跳转、支持 TLSv1.3 与 HTTP/2，是否符合要求可用 [SSL Server Test](https://www.ssllabs.com/ssltest/) 检查。

4、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol。配置2：使用 UDS 连接，且启用了 PROXY protocol。
