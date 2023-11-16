**这里是分享怎么搭建主流科学上网的优化配置及最优组合示例（如是不太了解科学上网，建议先依次从简单到复杂参考及部署。），其特点如下：**  
1. 实现了反代使用 Local Loopback 连接或使用 UDS（Unix Domain Socket） 连接可选。
2. 实现了回落/分流使用 Local Loopback 连接及启用 PROXY protocol 支持或使用 UDS（Unix Domain Socket） 连接及启用 PROXY protocol 支持可选。
3. 实现了 SNI 分流使用 Local Loopback 连接及启用 PROXY protocol 支持或使用 UDS（Unix Domain Socket） 连接及启用 PROXY protocol 支持可选。
4. 实现了 V2Ray/Xray 与 Caddy 的应用使用 UDS（Unix Domain Socket） 连接时全部采用 Abstract sockets 模式，不需考虑 UDS 文件路径及权限设置。
5. 实现了 Nginx SNI 分流（TCP 转发） 与定向 UDP 转发配合可支持 SNI 分流后的 NaiveProxy HTTP/3 代理应用。
6. 实现了 JSON 配置 Caddy SNI 分流，且可针对不同分流端口或进程灵活决定是否开启 PROXY protocol 发送。
7. 实现了由 Caddy 提供 TLS 证书的应用，其证书申请与更新、同步证书更新都可全自动化。
8. 实现了服务端综合应用配置示例中使用 mKCP、WebSocket、HTTP/2（H2）、gRPC 传输方式的应用配置可删、可换、可增（REALITY H2/gRPC 应用除外），灵活改变而不影响整体架构。
9. 实现了正常应用与 CDN 流量中转（基于 WebSocket over TLS 或基于 gRPC over TLS） 同时使用。
10. 实现了除 V2Ray/Xray 的 mKCP 应用与 TUIC/Hysteria 应用之外，其它应用对外都使用 443 端口，各应用互不影响。
11. 实现了除 V2Ray/Xray 的 mKCP 应用与 TUIC/Hysteria 应用之外，其它应用都支持流量伪装与防探测，且提供流量伪装与防探测的回落或代理网站都支持 HTTP 自动跳转到 HTTPS，SSL/TLS 安全评估报告为 A+（非 AES 算法的密码套件配置示例除外） 等，即所有特征完全与真实网站一致。

### 服务端单一/简单应用配置示例
#### &emsp;V2Ray/Xray 的 mKCP 应用
1. [V2Ray(VMess\VLESS+mKCP+seed)](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VMess%5CVLESS%2BmKCP%2Bseed))（VMess/VLESS+mKCP+seed 应用。VLESS+mKCP+seed 标记为 A。）
#### &emsp;V2Ray/Xray 的反代 WebSocket 应用
1. [V2Ray(VMess+WebSocket)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VMess%2BWebSocket)%2BNginx%5CCaddy)（VMess+WebSocket+TLS 应用。标记为 B。）
2. [V2Ray(SS+Door+WebSocket)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(SS%2BDoor%2BWebSocket)%2BNginx%5CCaddy)（兼容 Shadowsocks 加 v2ray-plugin 插件的 websocket-tls 应用。）
3. [V2Ray(VLESS+WebSocket)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VLESS%2BWebSocket)%2BNginx%5CCaddy)（VLESS+WebSocket+TLS 应用。）
4. [V2Ray(Trojan+WebSocket)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(Trojan%2BWebSocket)%2BNginx%5CCaddy)（Trojan+WebSocket+TLS 应用。）
#### &emsp;V2Ray/Xray 的反代 H2C 应用
1. [V2Ray(VLESS+H2C)+Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VLESS%2BH2C)%2BCaddy)（VLESS+H2C+TLS 应用。标记为 D。）
2. [V2Ray(Trojan+H2C)+Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(Trojan%2BH2C)%2BCaddy)（Trojan+H2C+TLS 应用。）
#### &emsp;V2Ray/Xray 的反代 gRPC 应用
1. [V2Ray(VMess+gRPC)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VMess%2BgRPC)%2BNginx%5CCaddy)（VMess+gRPC+TLS 应用。）
2. [V2Ray(SS+gRPC)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(SS%2BgRPC)%2BNginx%5CCaddy)（兼容 Shadowsocks 加 v2ray-plugin 插件的 grpc-tls 应用。标记为 G。）
3. [V2Ray(VLESS+gRPC)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VLESS%2BgRPC)%2BNginx%5CCaddy)（VLESS+gRPC+TLS 应用。）
4. [V2Ray(Trojan+gRPC)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(Trojan%2BgRPC)%2BNginx%5CCaddy)（Trojan+gRPC+TLS 应用。）
#### &emsp;Xray 的 Trojan 回落应用
1. [Xray(Trojan+TCP+TLS)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(Trojan%2BTCP%2BTLS)%2BNginx)（回落 Nginx 的 Trojan+TCP+TLS 应用。标记为 F。）
2. [Xray(Trojan+TCP+TLS)+Caddy](https://github.com/lxhao61/integrated-examples/tree/main/Xray(Trojan%2BTCP%2BTLS)%2BCaddy)（回落 Caddy 的 Trojan+TCP+TLS 应用。标记为 F。）
#### &emsp;Xray 的 XTLS Vision 应用
1. [Xray(VLESS+Vision+TLS)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(VLESS%2BVision%2BTLS)%2BNginx)（回落 Nginx 的 VLESS+Vision+TLS 应用。标记为 E。）
2. [Xray(VLESS+Vision+TLS)+Caddy](https://github.com/lxhao61/integrated-examples/tree/main/Xray(VLESS%2BVision%2BTLS)%2BCaddy)（回落 Caddy 的 VLESS+Vision+TLS 应用。标记为 E。）
#### &emsp;Xray 的 REALITY H2/gRPC 应用
1. [Xray(VLESS+H2C+REALITY)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(VLESS%2BH2C%2BREALITY))（VLESS+H2C+REALITY 应用。标记为 K。）
2. [Xray(SS+gRPC+REALITY)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(SS%2BgRPC%2BREALITY))（Shadowsocks+gRPC+REALITY 应用。）
#### &emsp;Xray 的 REALITY Vision 应用
1. [Xray(VLESS+Vision+REALITY)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(VLESS%2BVision%2BREALITY))（VLESS+Vision+REALITY 应用。标记为 M。）
2. [Xray(M+K)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M+K))（以 REALITY Vision 为核心的套娃应用。）
#### &emsp;Caddy 的 NaiveProxy 与 Trojan-Go 应用
1. [NaiveProxy(Caddy+forwardproxy)](https://github.com/lxhao61/integrated-examples/tree/main/NaiveProxy(Caddy%2Bforwardproxy))（基于 Caddy 插件的 NaiveProxy 应用。标记为 N。）
2. [Trojan-Go(Caddy+caddy-trojan)](https://github.com/lxhao61/integrated-examples/tree/main/Trojan-Go(Caddy%2Bcaddy-trojan))（基于 Caddy 插件的 Trojan-Go 应用。标记为 T。）
3. [Caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/Caddy(N%2BT))（基于 Caddy 插件的 NaiveProxy 与 Trojan-Go 共存应用。）
#### &emsp;TUIC 与 Hysteria 应用
1. [TUIC](https://github.com/lxhao61/integrated-examples/tree/main/TUIC)（基于原生 QUIC 协议实现的加速代理应用。）
2. [Hysteria](https://github.com/lxhao61/integrated-examples/tree/main/Hysteria)（基于修改 QUIC 协议实现的双边加速代理应用。）

### 服务端综合应用配置示例
#### &emsp;以反代为核心的综合应用
1. [V2Ray(B+G+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(B%2BG%2BA)%2BNginx)（反代 WebSocket、gRPC 的综合应用。）
2. [V2Ray(B+D+G+A)+Caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(B%2BD%2BG%2BA)%2BCaddy(N%2BT))（反代 WebSocket、H2C、gRPC 加 NaiveProxy 与 Trojian-Go 的综合应用。）
#### &emsp;以 XTLS Vision 为核心的综合应用
1. [Xray(E+B+G+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(E%2BB%2BG%2BA)%2BNginx)（回落 Nginx 的综合应用。）
2. [Xray(E+B+G+A)+Caddy](https://github.com/lxhao61/integrated-examples/tree/main/Xray(E%2BB%2BG%2BA)%2BCaddy)（回落 Caddy 的综合应用。）
#### &emsp;以 REALITY Vision 为核心的综合应用
1. [Xray(M+B+G+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M%2BB%2BG%2BA)%2BNginx)（由 Nginx 提供证书的综合应用。）
2. [Xray(M+B+D+G+A)+Caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M%2BB%2BD%2BG%2BA)%2BCaddy(N%2BT))（由 Caddy 提供证书的综合应用。）
#### &emsp;由 Nginx/Caddy 兼顾 SNI 分流实现 XTLS Vision 与 Trojan 回落为核心的综合应用
1. [Xray(E+F+B+G+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(E%2BF%2BB%2BG%2BA)%2BNginx)（由 Nginx 兼顾 SNI 分流的综合应用。）
2. [Xray(E+F+B+D+G+A)+Caddy(N)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(E%2BF%2BB%2BD%2BG%2BA)%2BCaddy(N))（由 Caddy 兼顾 SNI 分流的综合应用。）
#### &emsp;由 Nginx/Caddy 兼顾 SNI 分流实现 REALITY Vision 与 Trojan 回落为核心的综合应用
1. [Xray(M+F+B+G+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M%2BF%2BB%2BG%2BA)%2BNginx)（由 Nginx 兼顾 SNI 分流的综合应用。）
2. [Xray(M+F+B+D+G+A)+Caddy(N)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M%2BF%2BB%2BD%2BG%2BA)%2BCaddy(N))（由 Caddy 兼顾 SNI 分流的综合应用。）
#### &emsp;由 Nginx 专职 SNI 分流实现兼顾各方优势的综合应用
1. [Xray(E+F+B+D+G+A)+Caddy(N)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(E%2BF%2BB%2BD%2BG%2BA)%2BCaddy(N)%2BNginx)（以 XTLS Vision 为核心的综合应用。）
2. [Xray(M+F+B+D+G+A)+Caddy(N)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M%2BF%2BB%2BD%2BG%2BA)%2BCaddy(N)%2BNginx)（以 REALITY Vision 为核心的综合应用。）
#### &emsp;注意（以上所有示例）:
1. Xray 是 V2Ray 的超集，拥有更好的整体性能和独有的 XTLS Vision（主要解决 TLS in TLS 问题）、REALITY（主要解决基于 SNI 名单阻断问题） 等一系列增强应用，且通用 V2Ray（v4 版） 配置。
2. V2Ray/Xray 示例中各应用都配置了禁用 BT。如不需要，参考 ‘V2Ray(Other Configuration)’ 中 BT_config.json 示例删除相关配置。
3. V2Ray/Xray 单一核心应用简记：A=VLESS+mKCP+seed、B=VMess+WebSocket+TLS、D=VLESS+H2C+TLS、E=VLESS+Vision+TLS、F=Trojan+TCP+TLS、G=Shadowsocks+gRPC+TLS、K=VLESS+H2C+REALITY、M=VLESS+Vision+REALITY。
4. Caddy 插件单一应用简记：N=NaiveProxy(Caddy+forwardproxy)、T=Trojan-Go(Caddy+caddy-trojan)。
5. 受限应用条件及场景，NaiveProxy 的 QUIC 应用（即 Caddy 的 HTTP/3 代理应用）不是所有相关 NaiveProxy 示例都支持。
6. 目前 Caddy 从 Let's Encrypt 或 ZeroSSL 自动申请的 TLS 证书默认都为 ECC 证书。
7. 综合应用配置示例中使用 mKCP、WebSocket、HTTP/2（H2）、gRPC 传输方式的应用配置可删、可换、可增（REALITY H2/gRPC 应用除外）；参考‘服务端单一/简单应用配置示例’中对应配置示例修改。
8. 当前不推荐使用 WebSocket 传输方式的应用直接科学上网，套 CDN 使用无碍。若 CDN 流量中转（基于 WebSocket over TLS 或基于 gRPC over TLS）使用不可信的 CDN 进行中转，V2Ray/Xray 示例推荐使用自身带加密的 VMess 或 Shadowsocks 协议配置；否则推荐使用自身不带加密的 VLESS 或 Trojan 协议配置。
9. 针对 V2Ray 特性，当前服务端配置推荐使用非 AES 算法密码套件配置示例，客户端开启 uTLS 指纹。 针对 Xray 特性，当前服务端配置依次推荐使用 REALITY Vision 配置示例、XTLS Vision 配置示例、非 AES 算法的密码套件配置示例、REALITY 配置示例，客户端开启 uTLS 指纹。
10. 流量伪装与防探测网站可由其它 WEB 应用软件实现，其支持反代应用（反代 WebSocket、gRPC 及 H2C）与支持回落应用（提供 H2C server 及 HTTP/1.1 server 的 WEB 服务）等取决于自身，其配置自行参考 Caddy 或 Nginx 对应配置示例。
11. 附加相关插件的 Caddy 程序文件已编译好，去本人 Releases 中下载即可。
12. Trojan-Go 安卓手机客户端可以去本人 Releases 中下载（最末）。

### systemd 服务配置示例
&emsp;[Service Configuration](https://github.com/lxhao61/integrated-examples/tree/main/Service%20Configuration)（配置软件服务由 systemd 管理。）

### 原版客户端配置示例
&emsp;[Client Configuration](https://github.com/lxhao61/integrated-examples/tree/main/Client%20Configuration)（若使用第三方客户端参考即可。）

### 服务端特殊应用配置示例
1. [V2Ray(Other Configuration)](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(Other%20Configuration)) （V2Ray 或 Xray 的特色应用配置方法。）
2. [Caddy(Other Configuration)](https://github.com/lxhao61/integrated-examples/tree/main/Caddy(Other%20Configuration)) （Caddy 的特色应用配置方法。）

### 更新及贡献
1. 根据科学上网软件更新不定时调整示例，如科学上网软件有新增功能及应用等。
2. 根据当前科学上网情况不定时调整示例，如删除当前情况下不安全或被替代的应用等。
3. 欢迎你提交 PR，如对现行配置示例优化修订，或将自己使用的配置制作模板提交等。
