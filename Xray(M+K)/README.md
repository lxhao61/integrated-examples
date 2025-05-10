介绍：

Xray 前置（监听 443 端口），利用 VLESS+Vision+REALITY 回落 VLESS+XHTTP，实现 VLESS+Vision+REALITY 与 VLESS+XHTTP+REALITY 应用共用 443 端口，其应用如下：

1、M=VLESS+Vision+REALITY（转发及回落配置，REALITY 所需 TLS 由外部网站提供。）

2、K=VLESS+XHTTP+REALITY（套娃配置，REALITY 由 VLESS+Vision+REALITY 启用及处理。）

注意：

1、Xray 版本不小于 v24.10.31，其 XHTTP 传输方式才正式支持 REALITY。

2、本示例目标网站使用别人的，其网站要求：国外网站、域名非跳转、最低支持 TLSv1.3 与 HTTP/2。是否支持 TLSv1.3 与 HTTP/2 可用 [SSL Server Test](https://www.ssllabs.com/ssltest/) 检查。

3、若本示例目标网站使用自己的，其配置可参考 [Xray(M+H+K+G+B+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M%2BH%2BK%2BG%2BB%2BA)%2BNginx) 或 [Xray(M+H+K+G+B+A)+Caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M%2BH%2BK%2BG%2BB%2BA)%2BCaddy(N%2BT)) 示例中 VLESS+Vision+REALITY 应用。

4、配置1：使用 Local Loopback 连接。配置2：使用 UDS 连接。
