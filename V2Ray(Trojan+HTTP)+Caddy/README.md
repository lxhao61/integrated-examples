介绍：

利用 Caddy 支持 H2C 反向代理实现 V2Ray 的 Trojan+HTTP+TLS 应用，TLS 由 Caddy 提供及处理。

原理：

默认流程：Web client <----------------- HTTP/2 -----------------> Caddy（Web server）  
反代流程：V2Ray client <-------- HTTP+TLS（HTTP/2） --------> Caddy <-- H2C --> V2Ray server

注意：

1、V2Ray 版本不小于 v4.31.0 才支持 Trojan 协议。

2、Caddy 版本不小于 v2.6.0 才支持 H2C 反向代理的 UDS 转发。

3、本示例 Caddy 支持自动 HTTPS，即自动申请与更新 TLS 证书，自动 HTTP 重定向到 HTTPS。

4、配置1：使用 Local Loopback 连接。配置2：使用 UDS 连接。
