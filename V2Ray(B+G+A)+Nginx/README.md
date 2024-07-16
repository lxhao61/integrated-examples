介绍：

利用 Nginx 支持 WebSocket、gRPC 代理，实现除 V2Ray 或 Xray 的 mKCP 应用外各应用共用 443 端口，其应用如下：

1、B=VMess+WebSocket+TLS（TLS 由 Nginx 启用及处理，不需配置。）

2、G=Shadowsocks+gRPC+TLS（TLS 由 Nginx 启用及处理，不需配置。）

3、A=VLESS+mKCP+seed

注意：

1、V2Ray 或 Xray 的监听地址不支持 Shadowsocks 协议使用 UDS 监听。

2、V2Ray 版本不小于 v4.37.0 才支持 Shadowsocks 启用 IV 检查功能，可使某些 IV 重放攻击更加困难。

3、Xray 版本不小于 v1.7.0 才完美支持 Shadowsocks 2022 新协议，提升了性能并带有完整的重放保护。

4、Nginx 支持 HTTP/2 server 需要 Nginx 包含 http_ssl_module 与 http_v2_module 模块构建。

5、不要使用 ACME 客户端在采用本示例的服务器上以 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书，因 HTTP-01 或 TLS-ALPN-01 验证方式申请与更新 TLS 证书需监听 80 或 443 端口，从而与当前应用端口冲突。

6、配置1：使用 Local Loopback 连接。配置2：使用 UDS 连接（对应 Shadowsocks+gRPC+TLS 除外）。
