介绍：

Hysteria 是一个功能丰富的，专为恶劣网络环境（如卫星网络、拥挤的公共 Wi-Fi、从中国连接境外服务器等）进行优化的双边加速工具（代理软件），基于修改版的 QUIC 协议。

注意：

1、Hysteria 版本不小于 v2.5.0 其内置 ACME 客户端才支持以 DNS-01 验证方式申请与更新 TLS 证书（即支持申请通配符 TLS 证书）。另外若以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书请分别确保 80 或 443 端口无其它应用占用。

2、acme_config.yaml 表示使用内置 ACME 客户端自动申请与更新 TLS 证书，outside_config.yaml 表示使用外部 TLS 证书。

3、Hysteria 使用外部 TLS 证书时不支持‘证书热更新’功能，即 Hysteria 不会自动识别 TLS 证书已更新并重载，可使用如下方法之一解决。

1）、Linux 类系统使用 Crontab 指令定时重启 Hysteria 来重载更新后的 TLS 证书，其它系统使用类似命令/工具来定时重启 Hysteria 来重载更新后的 TLS 证书。（通用办法）

2）、若 TLS 证书由 Caddy（内置 ACME 客户端） 提供，可使用 caddy-events-exec 插件应用实现 TLS 证书自动更新后就执行重启 Hysteria 来重载更新后的 TLS 证书，详见 ‘Caddy(Other Configuration) （Caddy的特殊应用配置方法。）’中对应介绍及对应配置示例。（Caddy 专属办法）

3）、若 TLS 证书由 acme.sh 客户端提供，可使用 reloadcmd 参数实现 TLS 证书自动更新后就执行重启 Hysteria 来重载更新后的 TLS 证书，详见 acme.sh 客户端说明。（acme.sh 专属办法）

4、若想要 Hysteria 高速传输，请参考[链接](https://hysteria.network/zh/docs/advanced/Performance/)在服务端上进行性能优化。

5、若网络极差推荐部署，相比 V2Ray 或 Xray 的 mKCP 应用加速明显。
