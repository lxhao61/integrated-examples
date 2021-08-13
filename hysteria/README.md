介绍：

Hysteria 是一个功能丰富的，专为恶劣网络环境进行优化的网络工具（双边加速），基于修改版的 QUIC 协议，可实现 SOCKS5 代理 (TCP & UDP)、HTTP/HTTPS 代理、TCP/UDP 转发、TCP/UDP TPROXY 透明代理 (Linux)、TUN (Windows 下为 TAP) 应用。

注意：

1、Hysteria 服务端需要一个 TLS 证书。ACME_config.json 配置让 Hysteria 内置的 ACME 自动从 Let's Encrypt 为你的服务器签发一个证书。TLS_config.json 配置为使用现有证书及密钥。

2、Hysteria 内置的 ACME 目前仅支持 HTTP 与 TLS-ALPN 验证方式，不支持 DNS 验证。对于两种方式请分别确保 TCP 80/443 端口能够被访问。

3、若网络极差，推荐部署。相比Xray\v2ray 的 kcp 应用，加速明显。
