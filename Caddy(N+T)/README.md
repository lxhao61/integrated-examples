介绍：

本示例使用 Caddy 源码加改进版 forwardproxy 插件、caddy-trojan 插件编译而成 Caddy 文件，实现了 NaiveProxy 与 Trojan-Go 服务端加伪装网站应用。

注意：

1、使用本人 Releases 中编译好的 Caddy 文件，可同时支持 NaiveProxy、Trojan-Go 等应用。

2、本示例 NaiveProxy 除了支持 HTTP/2 代理应用，还同时支持 HTTP/3 代理应用，即 QUIC 协议传输。若 NaiveProxy 使用 HTTP/3 代理应用，建议[增加 UDP 接收缓冲区大小](https://github.com/quic-go/quic-go/wiki/UDP-Buffer-Sizes)。

3、本示例 Trojan-Go 仅兼容原版服务端的核心应用：支持 Trojan 应用与 Trojan-Go 的 WebSocket 应用共存，支持 CDN 流量中转(基于 WebSocket over TLS)。客户端推荐选择 Xray 客户端，支持使用指纹伪造；WebSocket 应用不能启用 WebSocket 0-RTT 与多路复用，不兼容。

4、本示例 Caddy 支持自动 HTTPS，即自动申请与更新 TLS 证书，自动 HTTP 重定向到 HTTPS。

5、由于新版的 forwardproxy 插件已经弃用了 "auth_user_deprecated" 以及 "auth_pass_deprecated" 字段，故而使用 caddy.json 文件进行配置时需要配合 "auth_credentials" 字段来配置原本的 user:pass 信息，具体变更方法如下:

``` json
"handle": [{
  "handler": "forward_proxy",
  "auth_user_deprecated": "user", //NaiveProxy 用户，修改为自己的。
  "auth_pass_deprecated": "pass", //NaiveProxy 密码，修改为自己的。
  ...
}]
```
改为
``` json
"handle": [{
  "handler": "forward_proxy",
  "auth_credentials": ["your_user:pass_base64"], //使用你的 user:pass 二次编译后的 base64 编码。
  ...
}]
```

$ echo -n "user:pass" | base64 | tr -d '\n' | base64

使用以上命令可对 user:pass 进行二次 base64 编码。

$ echo -e "$(echo "your_user:pass_base64" | base64 --decode | base64 --decode)"

使用以上命令可检验你对 user:pass 进行的二次 base64 编码是否正确。
