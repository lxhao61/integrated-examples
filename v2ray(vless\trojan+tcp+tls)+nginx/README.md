介绍：

本示例配置包含 vless+tcp+xtls 或 vless+tcp+tls 与 trojan+tcp+xtls 或 trojan+tcp+tls 应用。Xray 或 v2ray 服务端前置（监听 443 端口）处理来自墙内的 HTTPS 请求，如果是合法的 Xray 或 v2ray 客户端请求，那么为该请求提供服务（科学上网）；否则将已解除 TLS 的流量请求回落（转发）给 WEB 服务器 nginx，由 nginx 为其提供服务。

原理：

默认流程：Xray/v2ray client <------ TCP+TLS（HTTPS） ------> Xray/v2ray server  
回落流程：WEB client <----------------- HTTPS ----------------> Xray/v2ray server <-- 回落 --> nginx（WEB server）

其中 trojan+tcp+xtls 或 trojan+tcp+tls 应用还实现了兼容原版 trojan，即可使用原版 trojan 客户端连接。

注意：

1、v2ray 版本不小于 v4.31.0 才支持 trojan 协议。

2、nginx 支持 H2C server，需要 nginx 包含 http_v2_module 模块。

3、nginx 支持 PROXY protocol 接收，需要 nginx 包含 http_realip_module 及 stream_realip_module（可选）模块。

4、nginx 支持 H2C server，但不支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程（Unix Domain Socket 应用）；故回落配置就必须分成 http/1.1 回落与 h2 回落两部分，以便分别对应 nginx 的 HTTP/1.1 server 与 H2C server。

5、不要使用 ACME 客户端在当前服务器上申请与更新普通证书及密钥，因普通证书及密钥申请与更新需要监听 80 端口（或 443 端口），从而与当前应用端口冲突。

6、配置1：采用端口回落。配置2：采用进程回落。配置3：采用进程回落，且启用了 PROXY protocol。

7、因 v2ray 带来的 bug，无论 v2ray 还是 Xray 的 trojan+tcp+tls 应用都不支持 http/1.1 回落与 h2 回落分开；故若使用 trojan+tcp+tls 回落 nginx 应用，必须删除本示例中 http/1.1 连接参数、http/1.1 回落配置及 h2 回落匹配参数（即保留 h2 连接与 h2 回落），或 h2 连接参数与 h2 回落配置（即保留 http/1.1 连接与 http/1.1 回落）。（即二选一）
