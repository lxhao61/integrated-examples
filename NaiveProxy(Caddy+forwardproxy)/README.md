介绍：

本示例为使用 Caddy 的改进版 forwardproxy 插件实现的 NaiveProxy 服务端应用。

注意：

1、使用本人 Releases 中编译好的 Caddy 文件，可支持 NaiveProxy 等应用。

2、本示例 Caddy 支持自动 HTTPS，即自动申请与更新 TLS 证书，自动 HTTP 重定向到 HTTPS。

3、本示例中 NaiveProxy 支持 HTTP/3 传输。若想要由 Caddy 处理的 HTTP/3 应用高速传输，建议[增加服务端系统的 UDP 缓冲区大小](https://github.com/quic-go/quic-go/wiki/UDP-Buffer-Sizes)。
