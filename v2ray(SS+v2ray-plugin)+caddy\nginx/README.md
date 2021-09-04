介绍：

1、本配置采用 Xray\v2ray 自带 shadowsocks（SS） 应用加自身 Xray\v2ray ‘分离’ 出的 Xray-plugin\v2ray-plugin 模块，直接实现 shadowsocks 加 Xray-plugin\v2ray-plugin 的 WebSocket 应用（服务端），客户端使用 shadowsocks 加 Xray-plugin\v2ray-plugin 插件即可。

2、利用 caddy 或 nginx 支持 WebSocket（WS）反向代理，实现 SS+v2ray-plugin+tls 反向代理应用，TLS 由 caddy 或 nginx 提供及处理。

原理：

默认流程：WEB client <-------- HTTPS（HTTP/1.1+tls） -------> caddy\nginx（WEB server）  
匹配流程：shadowsocks client <------ WebSocket+tls ------> caddy\nginx <-- WebSocket --> Xray\v2ray server

注意：

1、本配置 shadowsocks+v2ray-plugin 插件的 WebSocket 应用不等于 Xray\v2ray 的 shadowsocks+WebSocket 应用，两者不兼容。它仅兼容 shadowsocks 客户端的 WebSocket 应用，即 shadowsocks 客户端须配合 Xray-plugin\v2ray-plugin 插件使用。

2、v2ray_DS_config.json 采用 Unix Domain Socket 连接 shadowsocks 应用与 Xray-plugin\v2ray-plugin 模块，效率高，但在 Windows 10 Build 17036 之前版本不可用。v2ray_redirect_config.json 采用 local loopback 连接 shadowsocks 应用与 Xray-plugin\v2ray-plugin 模块，效率稍低，但可适用任意系统服务器。

3、若采用 caddy 反向代理，本示例 caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可（效果一样）。支持自动 HTTPS，即自动申请与更新证书与私钥，自动 HTTP 重定向到 HTTPS。

4、若采用 nginx 反向代理，如果系统版本过低，其对应发行版仓库自带 nginx 预编译程序包可能不支持 tls1.3；如需要支持 tls1.3，必须先升级 OpenSSl 版本大于 1.1.1，再进行 nginx 源代码编译和安装。

5、若采用 nginx 反向代理，本示例配置不要使用 ACME 客户端在当前服务器上申请与更新普通证书及密钥，因普通证书及密钥申请与更新需要占用或监听80端口（或443端口），从而与当前应用端口冲突。
