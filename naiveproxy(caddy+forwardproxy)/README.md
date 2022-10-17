介绍：

naiveproxy 服务端是以 caddy 源码加改进版 forwardproxy 插件编译而成，实现以 HTTP/2 或 HTTP/3 代理科学上网。

注意：

1、使用本人 Releases 中编译好的 caddy 文件，可支持 naiveproxy 等应用。

2、本示例 naiveproxy 除了支持 HTTP/2 代理应用，还同时支持 HTTP/3 代理应用，即 QUIC 协议传输。

3、本示例 caddy 支持自动 HTTPS，即自动申请与更新 SSL/TLS 证书，自动 HTTP 重定向到 HTTPS。
