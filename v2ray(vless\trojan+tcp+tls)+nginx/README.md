介绍：

本项示例包括 vless+tcp+tls 与 trojan+tcp+tls 两种应用，实现了 Xray\v2ray 前置（监听443端口），以 h2 或 http/1.1 自适应协商连接，非 Xray\v2ray 的 web 连接回落给 nginx（即解除 tls 后的 web 连接转给 nginx 处理），tls 由 vless+tcp+tls 或 trojan+tcp+tls 提供及处理。

原理：

默认流程：Xray\v2ray client <------ tcp+tls ------> Xray\v2ray server  
匹配流程：web client <----------- https ----------> Xray\v2ray server <-- web回落 --> nginx（web server）

其中 trojan+tcp+tls 还实现了兼容 trojan，即可直接使用 trojan 客户端连接。

注意：

1、v2ray v4.31.0 版本及以后才支持 trojan 协议。

2、nginx 支持 h2c server，但不支持 http/1.1 server 与 h2c server 共用一个端口或一个进程（Unix Domain Socket 应用），故回落端口或进程必须分开。

3、nginx 预编译程序包可能不带支持 PROXY protocol 协议的模块。如要使用此项协议应用，需加 http_realip_module（必须加） 及 stream_realip_module（可选加） 两模块构建自定义模板，再进行源代码编译和安装。另编译时选取源代码版本建议不要低于1.13.11。

4、配置1：采用端口回落。配置2：采用进程回落。配置3：采用进程回落，且启用了 PROXY protocol。
