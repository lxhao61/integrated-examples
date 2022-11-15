介绍：

V2Ray 或 Xray 前置（监听 443 端口），利用 trojan+tcp+tls 或 trojan+tcp+xtls 回落及分流 WebSocket（WS）特性与 Caddy 为 H2C 与 gRPC 提供反向代理、为 forwardproxy 插件提供正向代理，实现除 Xray 或 V2Ray 的 mKCP 应用外共用 443 端口，其应用如下：

1、F=trojan+tcp+tls/xtls（回落/分流配置，TLS/XTLS由自己提供及处理。）

2、C=trojan+ws+tls（TLS由trojan+tcp+tls/xtls提供及处理，不需配置。）

3、D=vless+h2c+tls（TLS由trojan+tcp+tls/xtls提供及处理，不需配置。）

4、G=shadowsocks+grpc+tls（TLS由trojan+tcp+tls/xtls提供及处理，不需配置。）

5、A=vless+kcp+seed

6、NaïveProxy（基于Caddy的改进版forwardproxy插件实现，TLS由trojan+tcp+tls/xtls提供及处理，不需配置。）

注意：

1、Xray 或 V2Ray 的监听地址不支持 Shadowsocks（SS） 协议使用 UDS 监听。

2、Xray 版本不小于 v1.4.0 或 V2Ray 版本不小于 v4.36.2 才支持 gRPC 传输方式。

3、Caddy 版本不小于 v2.2.0 才支持 H2C proxy，即支持 Xray 或 V2Ray 的 H2C（gRPC） 反向代理。Caddy 版本不小于 v2.6.0 才支持 H2C proxy 的 UDS 转发。

4、Caddy 支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程。

5、使用本人 Releases 中编译好的 Caddy 文件，可同时支持 H2C server、H2C proxy、NaïveProxy 及接收 PROXY protocol 等应用。

6、本示例中 NaïveProxy 仅支持 HTTP/2 代理应用，即 HTTPS 协议传输。

7、本示例中 Xray 或 V2Ray 所需 TLS 证书由 Caddy（内置 ACME 客户端） 提供，实现 TLS 证书自动申请及更新。

8、V2Ray 不支持‘证书热更新’功能，即 V2Ray 不会自动识别 TLS 证书更新并重载 TLS 证书，之前可使用通用办法解决，现在可选择 Caddy 的专属办法解决了。

1）、Linux 类系统使用 Crontab 指令定时重启 V2Ray 来重载更新后的 TLS 证书，其它系统使用类似命令/工具来定时重启 V2Ray 来重载更新后的 TLS 证书。（通用办法）

2）、使用 caddy-events-exec 插件应用实现 TLS 证书自动更新后就执行重启 V2Ray 来重载更新后的 TLS 证书（类似 acme.sh 的 reloadcmd 参数应用），详见 ‘caddy(other configuration) （Caddy的特殊应用配置方法。）’中对应介绍及对应配置示例。（专属办法）

9、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol。配置2：使用 UDS 连接（对应 shadowsocks+grpc+tls 除外），且启用了 PROXY protocol。

10、本示例 F 兼容原版 Trojan 应用，F+C 组合等同于 Trojan-Go 应用；即可使用 Trojan 客户端 或 Trojan-Go 客户端对应连接。
