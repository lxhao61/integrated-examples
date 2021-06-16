介绍：

Xray\v2ray 前置（监听443端口），vless+tcp+tls 以 h2 或 http/1.1 自适应协商连接，分流 WebSocket（WS） 连接，其它连接回落给 trojan+tcp，trojan+tcp 处理后再回落给 nginx。其应用如下：

1、E=vless+tcp+tls（回落/分流配置，tls由自己提供。）

2、B=vless+ws+tls（tls由vless+tcp+tls提供及处理，不需配置；另可改成或添加其它WS类应用，参考对应的服务端单一应用配置示例。）

3、C=SS+v2ray-plugin+tls（tls由vless+tcp+tls提供及处理，不需配置。）

4、F=trojan+tcp+tls（tls由vless+tcp+tls提供及处理，不需配置。）

5、A=vless+kcp+seed（可改成vmess+kcp+seed，或添加它。）

注意：

1、v2ray v4.31.0 版本及以后才支持 trojan 协议。

2、nginx 支持 h2c server，但不支持 http/1.1 server 与 h2c server 共用一个端口或一个进程（Unix Domain Socket 应用），故 trojan+tcp+tls 应用中的 http/1.1 与 h2 回落端口或进程须分开，分别回落。

3、nginx 预编译程序包可能不带支持 PROXY protocol 协议的模块。如要使用此项协议应用，需加 http_realip_module（必须加） 及 stream_realip_module（可选加） 两模块构建自定义模板，再进行源代码编译和安装。另编译时选取源代码版本建议不要低于1.13.11。

4、此方法采用的是套娃方式实现共用443端口，支持 vless+tcp+tls 与 trojan+tcp+tls 完美共存，且仅需要一个域名及普通证书即可搞定，但 trojan+tcp+tls（tls由vless+tcp+tls提供及处理） 不支持 xtls 应用。

5、不要使用 ACME 客户端在当前服务器上申请与更新普通证书及密钥，因普通证书及密钥申请与更新需要占用或监听80端口（或443端口），从而与当前应用端口冲突。

6、配置1：采用端口回落\分流、端口转发。配置2：采用进程回落\分流、端口转发。配置3：采用进程回落\分流、端口转发，且启用了 PROXY protocol。
