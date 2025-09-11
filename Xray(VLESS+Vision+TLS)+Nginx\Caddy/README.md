介绍：

本示例为 VLESS+Vision+TLS（别称 XTLS Vision） 应用。Xray 服务端前置（监听 443 端口）处理来自墙内的连接请求，如果是合法的 Xray 客户端请求，那么为该请求提供服务（科学上网）；否则将已解除 TLS 的连接请求回落（转发）给 Nginx 或 Caddy，由 Nginx 或 Caddy 为其提供 WEB 服务。

原理：

默认流程：Xray client <---------- RAW+TLS ---------> Xray server  
回落流程：WEB client <------ HTTP/2或HTTPS ------> Xray server <-- H2C或HTTP/1.1 --> Nginx/Caddy（WEB server）

注意：

1、Xray 版本不小于 v1.7.2 才完美支持 VLESS 协议的 XTLS Vision 应用。

2、Nginx 支持 H2C server 需要 Nginx 包含 http_v2_module 模块构建。

3、Nginx 版本不小于 v1.25.1 才支持 H2C server 与 HTTP/1.1 server 共用一个端口或一个进程。若 Nginx 版本小于 v1.25.1，Xray 的 fallbacks 配置必须分成回落给 H2C server 与回落给 HTTP/1.1 server 分别对应 Nginx 的 H2C server 与 HTTP/1.1 server。

4、Nginx 支持对请求标头的 PROXY 协议处理需要 Nginx 包含 http_realip_module 模块构建。

5、若选用 Nginx 实现应用，ACME 客户端在采用本示例的服务器上以 HTTP-01 验证方式申请与更新 TLS 证书时，建议仅使用 Nginx 模式，避免端口冲突。

6、Caddy 支持 H2C server 与 HTTP/1.1 server 共用一个端口或一个进程。

7、Caddy 版本不小于 v2.7.0 才默认支持 PROXY protocol 接收。若 Caddy 版本小于 v2.7.0 需加 caddy2-proxyprotocol 插件定制编译才支持 PROXY protocol 接收。

8、若选用 Caddy 实现应用，本示例所需 TLS 证书由 Caddy（内置 ACME 客户端） 提供，实现 TLS 证书自动申请及更新。

9、配置1：使用 Local Loopback 连接，且启用了 PROXY protocol。配置2：使用 UDS 连接，且启用了 PROXY protocol。
