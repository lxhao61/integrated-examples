介绍：

本示例实现类似 V2Ray 或 Xray 的 [VLESS+H2C+TLS](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VLESS%2BH2C)%2BCaddy) 应用，TLS 由 REALITY 取代。可消除服务端 TLS 指纹特征，仍有前向保密性等，且证书链攻击无效，安全性超越常规 TLS。可指向别人的网站，无需自己买域名、配置 TLS 服务端，更方便，实现向中间人呈现指定 SNI 的全程真实 TLS，可解决 SNI 名单阻断问题。

原理：

使用目标网站证书（受信证书）的 TLS 伪装代理。

注意：

1、Xray 版本不小于 v1.8.0 才支持 REALITY，其同步 uTLS（强制客户端必须使用指纹伪造）。

2、目标网站使用外部的，其网站最低要求：国外网站、域名非跳转、支持 TLSv1.3 与 HTTP/2，是否符合要求可用 [SSL Server Test](https://www.ssllabs.com/ssltest/) 检查。
