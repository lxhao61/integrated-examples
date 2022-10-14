介绍：

利用 caddy 支持 H2C 代理，实现 Xray 或 v2ray 的 vless+h2c+tls 与 vmess+h2c+tls 两种反向代理应用，TLS 由 caddy 提供及处理。

原理：

默认流程：WEB client <---------------- HTTP/2 -----------------> caddy（WEB server）  
反代流程：Xray/v2ray client <----- HTTP/2（H2C+TLS） ------> caddy <-- H2C --> Xray/v2ray server

注意：

1、caddy 版本不小于 v2.2.0 才支持 H2C proxy，即支持 Xray 或 v2ray 的 H2C 反向代理。caddy 版本不小于 v2.6.0 才支持 H2C proxy 的 Unix Domain Socket（UDS） 转发。

2、本示例 caddy 支持自动 HTTPS，即自动申请与更新 SSL/TLS 证书，自动 HTTP 重定向到 HTTPS。

3、配置1：采用端口转发。配置2：采用进程转发。
