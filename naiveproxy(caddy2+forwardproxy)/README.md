介绍：

naiveproxy 服务端是以 caddy 源码加 forwardproxy 插件编译而成，基于 http/2 或 http/3 代理实现科学上网。

注意：

1、如采用本人 github 文件的 caddy2（naiveproxy 服务端）,支持 http/3 应用，即 quic 协议传输。

2、Caddyfile 配置与 caddy.json 配置二选一（效果一样）。支持自动 https，即自动申请与更新证书与私钥，自动 http 重定向到 https。
