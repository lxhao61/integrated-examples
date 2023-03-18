介绍：

本示例配置为 VLESS+TCP+TLS 应用（含XTLS Vision）。Xray 或 V2Ray 服务端前置（监听 443 端口）处理来自墙内的 HTTPS 请求，如果是合法的 Xray 或 V2Ray 客户端请求，那么为该请求提供服务（科学上网）；否则将已解除 TLS 的流量请求回落（转发）给 Caddy，由 Caddy 为其提供 WEB 服务。

原理：

默认流程：Xray/V2Ray client <---- TCP+TLS（HTTP/2或HTTPS） ----> Xray/V2Ray server  
回落流程：WEB client <---------------- HTTP/2或HTTPS --------------> Xray/V2Ray server <-- H2C或HTTP/1.1 --> Caddy（WEB server）

注意：

1、V2Ray 版本不小于 v4.31.0 才支持 Trojan 协议。

2、Caddy 支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程。

3、Caddy 默认不支持接收 PROXY protocol。如要支持接收 PROXY protocol 需选 caddy2-proxyprotocol 插件定制编译，或下载本人 Releases 中编译好的 Caddy 来使用即可。

4、本示例所需 TLS 证书由 Caddy（内置 ACME 客户端） 提供，实现 TLS 证书自动申请及更新。

5、V2Ray 不支持‘证书热更新’功能，即 V2Ray 不会自动识别 TLS 证书更新并重载 TLS 证书，可使用如下方法之一解决。

1）、Linux 类系统使用 Crontab 指令定时重启 V2Ray 来重载更新后的 TLS 证书，其它系统使用类似命令/工具来定时重启 V2Ray 来重载更新后的 TLS 证书。（通用办法）

2）、使用 caddy-events-exec 插件应用实现 TLS 证书自动更新后就执行重启 V2Ray 来重载更新后的 TLS 证书，详见 ‘Caddy(Other Configuration) （Caddy的特殊应用配置方法。）’中对应介绍及对应配置示例。（专属办法）

6、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol。配置2：使用 UDS 连接，且启用了 PROXY protocol。
