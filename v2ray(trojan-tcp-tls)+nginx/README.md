介绍：

v2ray（Xray） 前置（监听443端口），trojan+tcp 以 h2 协商连接，非 v2ray（Xray） 的 web 连接回落给 nginx，实现了兼容 trojan，即可直接使用 trojan 客户端连接。

原理图： v2ray\trojan client <------ tcp+tls ------> v2ray server <- web回落 -> nginx

注意：

1、v2ray v4.31.0 版本及以后才支持 trojan 协议。

2、nginx 支持 h2c server，但不支持 http/1.1 server 与 h2c server 共用一个端口或一个进程（Unix Domain Socket 应用），故回落端口或进程必须分开。而 trojan+tcp 目前不支持回落端口或进程分离 ，故 trojan+tcp 连接及回落只能二选一。本次示例 trojan+tcp 采用 h2 连接及回落，毕竟 h2 连接自带链路复用，且延迟小一点。

3、nginx 预编译程序包可能不带支持 PROXY protocol 协议的模块。如要使用此项协议应用，需加 http_realip_module（必须加） 及 stream_realip_module（可选加） 两模块构建自定义模板，再进行源代码编译和安装。另编译时选取源代码版本建议不要低于1.13.11。

4、配置1：端口回落，没有启用 PROXY protocol。配置2：进程回落，没有启用 PROXY protocol。配置3：进程回落，启用了 PROXY protocol。
