介绍：

Xray\v2ray 前置（监听443端口），利用 trojan+tcp+tls 强大的回落/分流特性，实现了共用443端口。trojan+tcp+tls 以 h2 或 http/1.1 自适应协商连接，分流 WebSocket（WS） 连接，非 Xray\v2ray 的 web 连接回落给 nginx。其应用如下：

1、F=trojan+tcp+tls（回落/分流配置，tls由自己提供。）

2、B=vless+WS+tls（tls由trojan+tcp+tls提供及处理，不需配置；另可改成或添加其它WS类应用，参考反向代理WS类的单一示例。）

注意：

1、v2ray v4.31.0 版本及以后才支持 trojan 协议。

2、nginx 支持 h2c server，但不支持 http/1.1 server 与 h2c server 共用一个端口或一个进程（Unix Domain Socket 应用）；故此 trojan-tcp-tls 应用中的 http/1.1 与 h2 回落端口或进程须分开，分别对应。

3、nginx 预编译程序包可能不带支持 PROXY protocol 协议的模块。如要使用此项协议应用，需加 http_realip_module（必须加） 及 stream_realip_module（可选加） 两模块构建自定义模板，再进行源代码编译和安装。另编译时选取源代码版本建议不要低于1.13.11。

4、配置1：采用端口回落\分流。配置2：采用进程回落\分流。配置3：采用进程回落\分流，且启用了 PROXY protocol。
