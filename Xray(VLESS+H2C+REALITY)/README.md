介绍：

本示例实现类似 Xray 或 V2Ray 的 [VLESS+H2C+TLS](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VLESS%2BH2C)%2BCaddy) 应用，TLS 由 REALITY 取代。可消除服务端 TLS 指纹特征，仍有前向保密性等，且证书链攻击无效，安全性超越常规 TLS。可指向别人的网站，无需自己买域名、配置 TLS 服务端，更方便，实现向中间人呈现指定 SNI 的全程真实 TLS，可解决 SNI 名单阻断问题。

原理：

使用目标网站证书（受信证书）的 TLS 伪装代理。

注意：

1、Xray 版本不小于 v1.8.0 才支持 REALITY 及同步 uTLS（强制客户端必须使用指纹伪造）。

2、若目标网站使用外部的，其最低标准：国外网站，支持 TLSv1.3 与 HTTP/2，域名非跳转；是否符合标准可用 [SSL Server Test](https://www.ssllabs.com/ssltest/) 检查。

3、若目标网站使用自己的，网站及关联配置可参考 [Xray(M+K+B+G+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M%2BK%2BB%2BG%2BA)%2BNginx) 或 [Xray(M+K+B+G+A)+Caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M%2BK%2BB%2BG%2BA)%2BCaddy(N%2BT)) 配置。
