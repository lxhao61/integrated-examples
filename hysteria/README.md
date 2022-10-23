介绍：

Hysteria 是一个功能丰富的、专为恶劣网络环境进行优化的网络工具（双边加速），基于修改版的 QUIC 协议，可实现 SOCKS5 代理 (TCP & UDP)、HTTP/HTTPS 代理、TCP/UDP 转发、TCP/UDP TPROXY 透明代理 (Linux)、TUN (Windows 下为 TAP) 应用。

注意：

1、ACME_config.json 示例使用内置的 ACME 自动从 Let's Encrypt 为服务器签发一个 SSL/TLS 证书（独自使用推荐）。TLS_config.json 示例使用现有 SSL/TLS 证书（已有科学上网应用再增加此应用推荐）。两示例根据实际情况二选一即可。

2、Hysteria 内置的 ACME 目前仅支持 HTTP-01 与 TLS-ALPN-01 验证方式，不支持 DNS-01 验证方式（即不支持申请通配符证书）。对于 HTTP-01 或 TLS-ALPN-01 验证方式请分别确保 80 或 443 端口能够被访问。

3、针对超高传速度进行优化，建议增加 [UDP 接收缓冲区大小](https://github.com/HyNetwork/hysteria/wiki/%E4%BC%98%E5%8C%96。

4、若网络极差推荐部署，相比 v2ray 或 Xray 的 KCP 应用加速明显。
