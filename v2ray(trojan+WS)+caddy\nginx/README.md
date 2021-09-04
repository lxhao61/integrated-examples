介绍：

利用 caddy 或 nginx 支持 WebSocket（WS）反向代理，实现 trojan+ws+tls 反向代理应用，TLS 由 caddy 或 nginx 提供及处理。此服务端兼容 trojan-go 的 WebSocket 应用，客户端可直接使用 trojan-go。

原理：

默认流程：WEB client <------------ HTTPS（HTTP/1.1+tls） -----------> caddy\nginx（WEB server）  
匹配流程：trojan-go\Xray\v2ray client <------- WebSocket+tls -------> caddy\nginx <-- WebSocket --> Xray\v2ray server

注意：

1、v2ray v4.31.0 版本及以后才支持 trojan 协议。

2、此应用使用 trojan-go 客户端及 Xray\v2ray 官方客户端连接无问题，使用第三方的 Xray\v2ray 客户端目前基本不行。另 trojan-go 安卓手机客户端可去本人 Releases 中下载。

3、若采用 caddy 反向代理，本示例 caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可（效果一样）。支持自动 HTTPS，即自动申请与更新证书与私钥，自动 HTTP 重定向到 HTTPS。

4、若采用 nginx 反向代理，如果系统版本过低，其对应发行版仓库自带 nginx 预编译程序包可能不支持 tls1.3；如需要支持 tls1.3，必须先升级 OpenSSl 版本大于 1.1.1，再进行 nginx 源代码编译和安装。

5、若采用 nginx 反向代理，本示例配置不要使用 ACME 客户端在当前服务器上申请与更新普通证书及密钥，因普通证书及密钥申请与更新需要占用或监听80端口（或443端口），从而与当前应用端口冲突。

6、配置1：采用端口转发。配置2：采用进程转发。
