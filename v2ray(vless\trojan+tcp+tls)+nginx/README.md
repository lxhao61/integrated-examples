介绍：

本示例配置为 vless+tcp+tls 或 trojan+tcp+tls 应用。Xray\v2ray 服务端前置（监听443端口）处理来自墙内的 HTTPS 请求，如果是合法的 Xray\v2ray 客户端请求，那么为该请求提供服务（科学上网）；否则将已解除 TLS 的流量请求回落（转发）给 WEB 服务器 nginx，由 nginx 为其提供服务。

原理：

默认流程：Xray\v2ray client <------ TCP+TLS（HTTPS） ------> Xray\v2ray server  
回落流程：WEB client <----------------- HTTPS ----------------> Xray\v2ray server <-- 回落 --> nginx（WEB server）

其中 trojan+tcp+tls 应用还实现了兼容原版 trojan，即可使用原版 trojan 客户端连接。

注意：

1、v2ray 版本不小于 v4.31.0 才支持 trojan 协议。

2、nginx 支持 H2C server，但不支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程（Unix Domain Socket 应用）；故回落配置就必须分成 http/1.1 回落与 h2 回落两部分，以便分别对应 nginx 的 HTTP/1.1 server 与 H2C server。

3、nginx 支持 PROXY protocol 接收，需 nginx 加入了 http_realip_module 及 stream_realip_module（可选）模块编译。另 nginx 编译时选取源代码版本不要低于1.13.11。

4、本示例配置不要使用 ACME 客户端在当前服务器上申请与更新普通证书及密钥，因普通证书及密钥申请与更新需要占用或监听80端口（或443端口），从而与当前应用端口冲突。

5、配置1：采用端口回落。配置2：采用进程回落。配置3：采用进程回落，且启用了 PROXY protocol。
