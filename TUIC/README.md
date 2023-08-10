介绍：

TUIC 是基于原生 QUIC 协议的代理软件。不支持 ofbs，使用 BBR 等拥塞控制，相对于 Hysteria 使用自己的拥塞控制（暴力发包）更温和、更克制、更友好。

注意：

1、本示例使用 TUIC 版本为 5。

2、TUIC 不支持‘证书热更新’功能，即 TUIC 不会自动识别 TLS 证书更新并重载 TLS 证书，可使用如下方法之一解决。

1）、Linux 类系统使用 Crontab 指令定时重启 TUIC 来重载更新后的 TLS 证书，其它系统使用类似命令/工具来定时重启 TUIC 来重载更新后的 TLS 证书。（通用办法）

2）、若 TLS 证书由 Caddy（内置 ACME 客户端） 提供，可使用 caddy-events-exec 插件应用实现 TLS 证书自动更新后就执行重启 TUIC 来重载更新后的 TLS 证书，详见 ‘Caddy(Other Configuration) （Caddy的特殊应用配置方法。）’中对应介绍及对应配置示例。（Caddy 专属办法）

3）、若 TLS 证书由 acme.sh 客户端提供，可使用 reloadcmd 参数实现 TLS 证书自动更新后就执行重启 TUIC 来重载更新后的 TLS 证书，详见 acme.sh 客户端说明。（acme.sh 专属办法）

3、若网络极差推荐部署，相比 V2Ray 或 Xray 的 mKCP 应用加速明显。

4、若使用 Hysteria 被 IDC 警告及被本地网络 QOS，推荐使用 TUIC 替换。
