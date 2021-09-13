介绍：

Xray\v2ray 前置（监听443端口），利用 trojan+tcp+tls 强大的回落/分流特性，实现与 WebSocket（WS）类应用共用443端口。trojan+tcp+tls 以 h2 或 http/1.1 自适应协商连接，分流 WebSocket（WS） 连接，非 Xray\v2ray 的连接回落给 nginx。其应用如下：

1、F=trojan+tcp+tls（回落/分流配置，TLS由自己提供及处理。）

2、B=vless+ws+tls（TLS由trojan+tcp+tls提供及处理，不需配置；另可改成或添加其它WS类应用，参考对应的服务端单一应用配置示例。）

注意：

1、v2ray 版本不小于 v4.31.0 才支持 trojan 协议。

2、nginx 支持 H2C server，需要 nginx 包含 http_v2_module 模块。

3、nginx 支持 PROXY protocol 接收，需要 nginx 包含 http_realip_module 及 stream_realip_module（可选）模块。

4、nginx 支持 H2C server，但不支持 HTTP/1.1 server 与 H2C server 共用一个端口或一个进程（Unix Domain Socket 应用）；故回落配置就必须分成 http/1.1 回落与 h2 回落两部分，以便分别对应 nginx 的 HTTP/1.1 server 与 H2C server。

5、不要使用 ACME 客户端在当前服务器上申请与更新普通证书及密钥，因普通证书及密钥申请与更新需要占用或监听80端口（或443端口），从而与当前应用端口冲突。

6、配置1：采用端口回落\分流。配置2：采用进程回落\分流。配置3：采用进程回落\分流，且启用了 PROXY protocol。
