介绍：

利用 Caddy 支持 H2C 代理实现 Xray 或 V2Ray 的 VLESS+H2C+TLS 应用，TLS 由 Caddy 提供及处理。

原理：

默认流程：WEB client <---------------- HTTP/2 -----------------> Caddy（WEB server）  
反代流程：Xray/V2Ray client <----- HTTP/2（H2C+TLS） -----> Caddy <-- H2C --> Xray/V2Ray server

注意：

1、Caddy 版本不小于 v2.2.0 才支持 H2C proxy，即支持 Xray 或 V2Ray 的 H2C 反向代理。Caddy 版本不小于 v2.6.0 才支持 H2C proxy 的 UDS 转发。

2、本示例 Caddy 支持自动 HTTPS，即自动申请与更新 TLS 证书，自动 HTTP 重定向到 HTTPS。

3、配置1：使用 Local Loopback 连接。配置2：使用 UDS 连接。
