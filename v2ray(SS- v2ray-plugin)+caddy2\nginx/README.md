介绍：

1、本配置采用 v2ray（Xray） 自带 shadowsocks 协议及自身 v2ray（Xray） ‘分离’ 出的 v2ray-plugin（Xray-plugin） 模块，直接实现 shadowsocks 加 v2ray-plugin（Xray-plugin） 的 WebSocket 应用（服务端），客户端使用 shadowsocks 加 v2ray-plugin（Xray-plugin） 插件即可。

2、通过 caddy2 或 nginx 前置 v2ray server 实现 ws（WebSocket） 反向代理，tls 由 caddy2 或 nginx 提供及处理。

原理图： shadowsocks client <------ ws+tls ------> caddy2\nginx <- ws -> v2ray server

注意：

1、本配置 shadowsocks+v2ray-plugin 插件的 WebSocket 应用不等于 v2ray 的 shadowsocks+WebSocket 应用，两者不兼容。它仅兼容 shadowsocks 客户端的 WebSocket 应用，即 shadowsocks 客户端须配合 v2ray-plugin 插件使用。

2、v2ray_domainsocket_config.json 效率高，但在 Windows 10 Build 17036 前不可用；而 v2ray_redirect_config.json 效率稍低，可适用全部服务器。

3、此示例中若采用 caddy2 反向代理，Caddyfile 配置与 caddy.json 配置二选一（效果一样）。支持自动 https，即自动申请与更新证书与私钥，自动 http 重定向到 https。

4、此示例中若采用 nginx 反向代理，如果系统版本过低，其对应发行版仓库自带 nginx 预编译程序包可能不支持 tls1.3；如需要支持 tls1.3，必须先升级 OpenSSl 版本大于 1.1.1，再进行 nginx 源代码编译和安装。
