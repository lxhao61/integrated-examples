介绍：

此配置实现了 v2ray（Xray） 前置（监听443端口），vless+tcp 以 h2 或 http/1.1 自适应协商连接，非 v2ray（Xray） 的 web 连接回落给 nginx。

原理图： v2ray client <------ tcp+tls ------> v2ray server <- web回落 -> nginx

注意：

1、nginx 支持 h2c server，但不支持 http/1.1 server 与 h2c server 共用一个端口或一个进程（Unix Domain Socket 应用）；故此 vless+tcp 应用中的回落端口或进程必须分开，分别对应。

2、nginx 预编译程序包可能不带支持 PROXY protocol 协议的模块。如要使用此项协议应用，需加 http_realip_module（必须加） 及 stream_realip_module（可选加） 两模块构建自定义模板，再进行源代码编译和安装。另编译时选取源代码版本建议不要低于1.13.11。

3、配置1：端口回落，没有启用 PROXY protocol。配置2：进程回落，没有启用 PROXY protocol。配置3：进程回落，启用了 PROXY protocol。
