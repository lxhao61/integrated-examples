介绍：

Hysteria 是一个功能丰富的、专为恶劣网络环境进行优化的网络工具（双边加速），基于修改版的 QUIC 协议，可实现 SOCKS5 代理 (TCP & UDP)、HTTP/HTTPS 代理、TCP/UDP 转发、TCP/UDP TPROXY 透明代理 (Linux)、TUN (Windows 下为 TAP) 应用。

注意：

1、Hysteria（内置 ACME 客户端） 目前仅支持 HTTP-01 与 TLS-ALPN-01 验证方式申请与更新 TLS 证书，不支持 DNS-01 验证方式申请与更新 TLS 证书（即不支持申请通配符 TLS 证书）。对于 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书请分别确保 80 或 443 端口无其它应用占用。

2、acme_config.json 示例表示使用内置 ACME 客户端从 Let's Encrypt 为服务端自动申请与更新 TLS 证书（独自使用推荐），outside_config.json 示例表示使用外部 TLS 证书（已有科学上网应用再增加此应用推荐）；两示例根据实际情况二选一即可。

3、Hysteria 使用外部 TLS 证书时不支持‘证书热更新’功能，即 Hysteria 不会自动识别 TLS 证书更新并重载 TLS 证书，可使用如下方法之一解决。

1）、Linux 类系统使用 Crontab 指令定时重启 Hysteria 来重载更新后的 TLS 证书，其它系统使用类似命令/工具来定时重启 Hysteria 来重载更新后的 TLS 证书。（通用办法）

2）、若 TLS 证书由 Caddy（内置 ACME 客户端） 提供，可使用 caddy-events-exec 插件应用实现 TLS 证书自动更新后就执行重启 Hysteria 来重载更新后的 TLS 证书，详见 ‘Caddy(Other Configuration) （Caddy的特殊应用配置方法。）’中对应介绍及对应配置示例。（Caddy专属办法）

3）、若 TLS 证书由 acme.sh 客户端提供，可使用 reloadcmd 参数实现 TLS 证书自动更新后就执行重启 Hysteria 来重载更新后的 TLS 证书，详见 acme.sh 客户端说明。（acme.sh专属办法）

4、若网络极差推荐部署，相比 Xray 或 V2Ray 的 mKCP 应用加速明显。

5、若要用 Hysteria 进行高速传输，请[增加系统 UDP 的接收和发送 buffer 大小](https://hysteria.network/zh/docs/optimizations/)。
