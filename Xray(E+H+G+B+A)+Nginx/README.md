介绍：

Xray 前置（监听 443 端口），利用 VLESS+Vision+TLS 回落/分流特点先分流出 HTTPUpgrade 应用，其余的回落给 Nginx 处理，Nginx 为 XHTTP、gRPC 提供反向代理，实现除 Xray 的 mKCP 应用外各应用共用 TCP 443 端口，其应用如下：

1、E=VLESS+Vision+TLS（回落/分流配置，TLS 由自己启用及处理。）

2、H=VLESS+XHTTP+TLS（反代配置，TLS 由 E 或 Nginx 启用及处理。）

3、G=Shadowsocks+gRPC+TLS（反代配置，TLS 由 E 启用及处理。）

4、B=VMess+HTTPUpgrade+TLS（分流配置，TLS 由 E 启用及处理。）

5、A=VLESS+mKCP+seed

注意：

1、Xray 的监听地址不支持 Shadowsocks 协议使用 UDS 监听。

2、Xray 版本不小于 v24.11.30 才支持完全体 XHTTP，其 XHTTP 传输方式实现了真正的上下行分离（见客户端配置示例），给 GFW 针对单个连接的分析带来了麻烦。

3、Nginx 支持 H2C server、HTTP/3 server 需要 Nginx 包含 http_ssl_module、http_v2_module、http_v3_module 模块构建。

4、Nginx 版本不小于 v1.25.1 才支持 H2C server 与 HTTP/1.1 server 共用一个端口或一个进程。若 Nginx 版本小于 v1.25.1，Xray 的 fallbacks 配置必须分成回落给 H2C server 与回落给 HTTP/1.1 server 分别对应 Nginx 的 H2C server 与 HTTP/1.1 server。

5、Nginx 版本不小于 v1.25.0 且所用 SSL 库支持 QUIC 才支持 HTTP/3 server，相关信息见 Nginx 文档。

6、Nginx 支持对请求标头的 PROXY 协议处理需要 Nginx 包含 http_realip_module 模块构建。

7、ACME 客户端在采用本示例的服务器上以 HTTP-01 验证方式申请与更新 TLS 证书时，建议仅使用 Nginx 模式，避免端口冲突。

8、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol。配置2：使用 UDS 连接（对应 Shadowsocks+gRPC+TLS 除外），且启用了 PROXY protocol。
