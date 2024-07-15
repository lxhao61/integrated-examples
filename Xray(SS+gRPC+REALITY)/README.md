介绍：

本示例实现类似 V2Ray 或 Xray 的 [Shadowsocks+gRPC+TLS](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(SS%2BgRPC)%2BNginx%5CCaddy) 应用，TLS 由 REALITY 取代。可指向别人的网站，无需自己买域名、配置 TLS 服务端，更方便，实现向中间人呈现指定 SNI 的全程真实 TLS，可解决 SNI 名单阻断问题。

原理：

使用目标网站证书（受信证书）的 TLS 伪装代理。

注意：

1、Xray 版本不小于 v1.8.0 才支持 REALITY。

2、Xray 的 Shadowsocks 2022 新协议提升了性能并带有完整的重放保护。

3、本示例虽然因为使用 gRPC 传输方式（自带多路复用）减轻了 TLS in TLS 特征，但是因为无法完全去除；故本示例仅推荐目标网站使用外部的才可使用。

4、目标网站使用外部的，其网站最低要求：国外网站、域名非跳转、支持 TLSv1.3 与 HTTP/2，是否符合要求可用 [SSL Server Test](https://www.ssllabs.com/ssltest/) 检查。
