介绍：

Hysteria 是一个功能丰富的、专为恶劣网络环境进行优化的网络工具（双边加速），基于修改版的 QUIC 协议，可实现 SOCKS5 代理 (TCP & UDP)、HTTP/HTTPS 代理、TCP/UDP 转发、TCP/UDP TPROXY 透明代理 (Linux)、TUN (Windows 下为 TAP) 应用。

注意：

1、Hysteria（内置 ACME 客户端） 目前仅支持 HTTP-01 与 TLS-ALPN-01 验证方式申请与更新 TLS 证书，不支持 DNS-01 验证方式申请与更新 TLS 证书（即不支持申请通配符 TLS 证书）。对于 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书请分别确保 80 或 443 端口无其它应用占用。

2、ACME_config.json 示例表示使用内置 ACME 客户端从 Let's Encrypt 为服务端自动申请与更新 TLS 证书（独自使用推荐），TLS_config.json 示例表示使用外部 TLS 证书（已有科学上网应用再增加此应用推荐）；两示例根据实际情况二选一即可。

3、如内网超过 10G 或高延迟跨国超过 1G，建议增加 [UDP 接收缓冲区大小](https://github.com/HyNetwork/hysteria/wiki/%E4%BC%98%E5%8C%96)对超高传速度进行优化。

4、若网络极差推荐部署，相比 V2Ray 或 Xray 的 mKCP 应用加速明显。
