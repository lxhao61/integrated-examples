介绍：

此示例包括 trojan-go\trojan、naiveproxy（caddy） 应用。trojan-go\trojan 以 h2 或 http/1.1 自适应协商连接，非 trojan-go\trojan 的 https 连接回落给 caddy；caddy 再处理，若是 naiveproxy 数据就进行正向代理。其应用如下：

1、trojan-go或trojan（回落配置，tls由自己提供。）

2、naiveproxy（带有forwardproxy插件的caddy才支持naiveproxy应用。tls由trojan-go\trojan提供及处理，不需配置。）

注意：

1、caddy 不小于 v2.3.0 版才支持 Caddyfile 配置开启 h2c server。

2、caddy 支持 http/1.1 server 与 h2c server 共用一个端口或一个进程（Unix Domain Socket 应用）。

3、因 trojan-go\trojan 不支持 Unix Domain Socket，故不能采用进程回落。

4、因 trojan-go\trojan 不支持 PROXY protocol（发送），故不启用此项应用。

5、使用本人 github 中编译好的 caddy 文件，才支持 naiveproxy 等应用。

6、本示例中 caddy 的 Caddyfile 格式配置与 json 格式配置二选一即可（效果一样）。

7、不要使用非 caddy（自带 ACME 客户端） 的 ACME 客户端在当前服务器上申请与更新普通证书及密钥，因普通证书及密钥申请与更新需占用或监听80端口（或443端口），从而与当前应用端口冲突。

7、trojan-go 使用 go 实现了完全兼容 trojan，实例还有自己的特色：1、支持 CDN 流量中转(基于 WebSocket over TLS/SSL )。2、支持使用 AEAD 对 trojan 流量二次加密(基于 Shadowsocks AEAD )。

8、trojan-go CDN 应用（WebSocket类应用）与正常应用同时使用，仅支持使用通配符证书或 SAN 证书的不同域名实现，因为 trojan-go 不支持设置多组证书及密钥。
