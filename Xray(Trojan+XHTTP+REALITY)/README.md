介绍：

本示例实现类似 Xray 的 [Trojan+XHTTP+TLS](https://github.com/lxhao61/integrated-examples/tree/main/Xray(Trojan%2BXHTTP)%2BNginx%5CCaddy) 应用，TLS 由 REALITY 取代。可消除服务端 TLS 指纹特征，仍有前向保密性等，且证书链攻击无效，安全性超越常规 TLS。可指向别人的网站，无需自己买域名、配置 TLS 服务端，更方便，实现向中间人呈现指定 SNI 的全程真实 TLS，可解决 SNI 名单阻断问题。

原理：

使用目标网站证书（受信证书）的 TLS 伪装代理。

注意：

1、Xray 版本不小于 v24.10.31，其 XHTTP 传输方式才正式支持 REALITY。

2、本示例目标网站使用别人的，其网站要求：国外网站、域名非跳转、最低支持 TLSv1.3 与 HTTP/2。是否支持 TLSv1.3 与 HTTP/2 可用 [SSL Server Test](https://www.ssllabs.com/ssltest/) 检查。

3、若本示例目标网站使用自己的，其配置可参考 [Xray(M+H+K+G+B+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M%2BH%2BK%2BG%2BB%2BA)%2BNginx) 或 [Xray(M+H+K+G+B+A)+Caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M%2BH%2BK%2BG%2BB%2BA)%2BCaddy(N%2BT)) 示例中 VLESS+Vision+REALITY 应用。
