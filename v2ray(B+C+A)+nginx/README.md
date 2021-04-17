介绍：

除 Xray\v2ray kcp 外，所用应用共用443端口。此端口由 nginx 监听（即 nginx 前置），反向代理 WebSocket（WS）。包括应用如下：

1、B=vless+WS+tls（tls由nginx提供及处理，不需配置；另可改成或添加其它WS类应用，参考反向代理WS类的单一示例。）

2、C=SS+v2ray-plugin+tls（tls由nginx提供及处理，不需配置。）

3、A=vless+kcp+seed（可改成vmess-kcp-seed，或添加它。）

注意：

1、采用 nginx 反向代理 gRPC，配置 nginx 时需要启用 http/2，因为 gRPC 必须使用 http/2 传输数据。使用源码编译和安装，编译时需要加入 http_ssl 和 http_v2 模块。

2、如果系统版本过低，其对应发行版仓库自带 nginx 预编译程序包可能不支持 tls1.3；如需要支持 tls1.3，必须先升级 OpenSSl 版本大于 1.1.1，再进行 nginx 源代码编译和安装。

3、配置1：采用端口转发。配置2：vless+WS+tls 采用进程转发，其它应用采用端口转发。

