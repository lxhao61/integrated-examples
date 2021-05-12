介绍：

本配置是 trojan-go 或 trojan 应用，trojan-go 以 h2 协商连接，trojan 以 h2 或 http/1.1 自适应协商连接；非 trojan-go\trojan 的 https 连接回落给 nginx（即解除 tls 后的 web 连接转给 nginx 处理），tls 由 trojan-go\trojan 提供及处理。

原理：

默认流程：trojan-go\trojan client <------ https ------> trojan-go\trojan server  
匹配流程：web client <------------- https ------------> trojan-go\trojan server <-- web回落 --> nginx（web server）

注意：

1、nginx 支持 h2c server，但不支持 http/1.1 server 与 h2c server 共用一个端口或一个进程（Unix Domain Socket 应用）。而 trojan-go 目前不支持 http/1.1 与 h2 的回落端口或进程分离 ，故 trojan-go 回落只能二选一。本示例采用 h2 连接及回落，毕竟 h2 连接自带链路复用，且延迟小一点。

2、因 trojan-go\trojan 不支持 Unix Domain Socket，故不能采用进程回落。

3、因 trojan-go\trojan 不支持 PROXY protocol（发送），故不启用此项应用。

4、trojan-go 使用 go 实现了完全兼容 trojan，还有自己的特色：trojan-go 支持使用多路复用提升并发性能，使用路由模块实现国内直连；支持 CDN 流量中转(基于 WebSocket over TLS/SSL )；支持使用 AEAD 对 trojan 流量二次加密(基于 Shadowsocks AEAD )；支持可插拔的传输层插件，允许替换 TLS，使用其他加密隧道传输 trojan 协议流量。

5、不能使用 ACME 客户端在当前服务器上申请与更新普通证书及密钥，因普通证书及密钥申请与更新需要占用或监听80端口（或443端口），从而与当前应用端口冲突。
