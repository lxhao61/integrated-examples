介绍：

利用 caddy 支持 H2C 反向代理，实现 vless+h2c+tls 与 vmess+h2c+tls 两种反向代理应用，TLS 由 caddy 提供及处理。

原理：

默认流程：WEB client <----------- HTTPS（HTTP/2） ----------> caddy（WEB server）  
匹配流程：Xray\v2ray client <------ H2C+TLS（HTTP/2） ------> caddy <-- H2C --> Xray\v2ray server

注意：

1、caddy 不小于 v2.2.0-rc.1 版才支持 H2C proxy，即支持 Xray\v2ray 的 H2C 反向代理。

2、本示例 caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可（效果一样）。支持自动 HTTPS，即自动申请与更新证书与私钥，自动 HTTP 重定向到 HTTPS。

3、nginx 不支持 H2C proxy，故不能用 nginx 来实现 Xray\v2ray 的 H2C 反向代理。
