介绍：

v2ray（Xray） 前置（监听443端口），利用 trojan+tcp+tls 强大的回落/分流特性，实现除 v2ray（Xray） kcp 外共用443端口。trojan+tcp+tls 以 h2 或 http/1.1 自适应协商连接，分流 WebSocket（WS） 连接，其它连接回落给 nginx；nginx 再处理，对 grpc 进行反向代理。包括应用如下：

1、F=trojan+tcp+tls（tls由自己提供。）

2、B=vless+WS+tls（tls由trojan+tcp+tls提供及处理，不需配置；另可改成或添加其它WS类应用，参考反向代理WS类的单一示例。）

3、C=SS+v2ray-plugin+tls（tls由trojan+tcp+tls提供及处理，不需配置。）

4、G=vless+grpc+tls（tls由trojan+tcp+tls提供及处理，不需配置；另可改成或添加vmess+grpc+tls应用，参考反向代理grpc的单一示例。）

5、A=vless+kcp+seed（可改成vmess+kcp+seed，或添加它。）

注意：

1、Xray 版本不小于 1.4.0 或 v2ray 版本不小于v4.36.2，才完美支持 grpc 应用。

2、nginx 支持 h2c server，但不支持 http/1.1 server 与 h2c server 共用一个端口或一个进程（Unix Domain Socket 应用）；故此 trojan+tcp+tls 应用中的回落端口或进程必须分开，分别对应。

3、nginx 不支持 h2c proxy，故 nginx 不能实现 v2ray 的 h2c（http/2）反向代理。

4、nginx 预编译程序包可能不带支持 PROXY protocol 协议的模块。如要使用此项协议应用，需加 http_realip_module（必须加） 及 stream_realip_module（可选加） 两模块构建自定义模板，再进行源代码编译和安装。另编译时选取源代码版本建议不要低于1.13.11。

5、配置1：端口转发、端口回落\分流，没有启用 PROXY protocol。配置2：进程转发、进程回落\分流，没有启用 PROXY protocol。配置3：进程转发、进程回落\分流，启用了 PROXY protocol。
