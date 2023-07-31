介绍：

Xray 前置（监听 443 端口），利用 VLESS+Vision+REALITY 回落 VLESS+H2C（套娃），实现 VLESS+Vision+REALITY 与 VLESS+H2C+REALITY 应用共用 443 端口，其应用如下：

1、M=VLESS+Vision+REALITY（回落与转发配置，REALITY 由自己启用及处理。）

2、K=VLESS+H2C+REALITY（REALITY 由 VLESS+Vision+REALITY 启用及处理，不需配置。）

注意：

1、Xray 版本不小于 v1.8.0 才支持 REALITY，其同步 uTLS（强制客户端必须使用指纹伪造）。

2、目标网站使用外部的，其网站最低要求：国外网站、域名非跳转、支持 TLSv1.3 与 HTTP/2，是否符合要求可用 [SSL Server Test](https://www.ssllabs.com/ssltest/) 检查。

3、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol。配置2：使用 UDS 连接，且启用了 PROXY protocol。
