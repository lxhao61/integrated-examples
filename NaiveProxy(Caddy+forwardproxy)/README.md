介绍：

本示例使用 Caddy 源码加改进版 forwardproxy 插件编译而成 Caddy 文件，实现了 NaiveProxy 服务端加伪装网站应用。

注意：

1、使用本人 Releases 中编译好的 Caddy 文件，可支持 NaiveProxy 等应用。

2、本示例 NaiveProxy 除了支持 HTTP/2 代理应用，还同时支持 HTTP/3 代理应用，即 QUIC 协议传输。

3、若 NaiveProxy 使用 HTTP/3 代理应用，即 QUIC 协议传输，建议增加 [UDP 接收缓冲区大小](https://github.com/lucas-clemente/quic-go/wiki/UDP-Receive-Buffer-Size)。

4、本示例 Caddy 支持自动 HTTPS，即自动申请与更新 TLS 证书，自动 HTTP 重定向到 HTTPS。
