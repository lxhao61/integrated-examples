**本仓库分享的是主流科学上网的优化配置及最优组合示例（如不太了解科学上网，建议先简单到复杂参考部署。），可避免因配置不合理服务器被封问题，其特点如下：**  
1. 实现了 V2Ray/Xray 示例（与 Shadowsocks、mKCP 关联的应用除外）使用 Local Loopback 连接与使用 UDS（Unix Domain Socket） 连接可选。
2. 实现了 Xray 示例（与 mKCP 关联的应用除外）的 SNI 分流连接、回落/分流连接启用了 PROXY protocol 支持。
3. 实现了 V2Ray/Xray 与 Caddy 的示例使用 UDS（Unix Domain Socket） 连接时采用 abstract 模式，不需考虑 UDS 路径及监听进程的访问权限。
4. 实现了 Xray 与 Nginx 的示例使用 UDS（Unix Domain Socket） 连接时（回落/分流连接除外）采用附加访问权限形式，简单高效地解决了监听进程的访问权限。
5. 实现了 JSON 配置 Caddy SNI 分流及定向 UDP 转发，且可针对不同分流端口或进程灵活决定是否开启 PROXY protocol 发送。
6. 实现了由 Caddy 提供 TLS 证书的示例，其证书申请、更新及重载更新证书都可全自动化。
7. 实现了 Caddy 的 NaiveProxy 除了支持 HTTPS 协议连接外，还同时支持 QUIC 协议连接，即支持 HTTP/3 传输。
8. 实现了反代 Xray 的 XHTTP 应用除了支持 HTTP/2 传输外，还同时支持 HTTP/3 传输。
9. 实现了正常应用与 CDN 流量中转（基于 XHTTP/gRPC/WebSocket/HTTPUpgrade over TLS） 应用可同时使用，且使用 CDN 进行流量中转也能获取到客户端真实 IP。
10. 实现了服务端综合应用配置示例中所有非 RAW（原 TCP） 应用可删、可换、可增，灵活修改而不影响整体使用。
11. 实现了除 V2Ray/Xray 的 mKCP 应用及 Hysteria 应用外，其它应用对外都使用 TCP/UDP 443 端口，各应用互不影响。
12. 实现了除 V2Ray/Xray 的 mKCP 应用及 Hysteria 应用外，其它应用都支持流量伪装与防探测，且提供流量伪装与防探测的网站都支持 HTTP 自动跳转到 HTTPS，SSL/TLS 安全评估报告为 A+（非 AES 算法的密码套件配置示例除外） 等，即所有特征完全与真实网站一致。

### 服务端单一/简单应用配置示例
#### &emsp;V2Ray/Xray 的 mKCP 应用
1. [V2Ray(VMess\VLESS+mKCP+seed)](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VMess%5CVLESS%2BmKCP%2Bseed))（VMess/VLESS+mKCP+seed 应用。VLESS+mKCP+seed 标记为 A。）
#### &emsp;V2Ray/Xray 的反代 WebSocket 应用
1. [V2Ray(VMess+WebSocket)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VMess%2BWebSocket)%2BNginx%5CCaddy)（VMess+WebSocket+TLS 应用。标记为 C。）
2. [V2Ray[SS+(DD+WebSocket)]+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray%5BSS%2B(DD%2BWebSocket)%5D%2BNginx%5CCaddy)（等同 Shadowsocks 加 v2ray-plugin 插件的 websocket-tls 应用。）
3. [V2Ray(VLESS+WebSocket)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VLESS%2BWebSocket)%2BNginx%5CCaddy)（VLESS+WebSocket+TLS 应用。）
4. [V2Ray(Trojan+WebSocket)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(Trojan%2BWebSocket)%2BNginx%5CCaddy)（Trojan+WebSocket+TLS 应用。）
#### &emsp;V2Ray 的反代 H2C 应用
1. [V2Ray(VLESS+HTTP)+Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VLESS%2BHTTP)%2BCaddy)（VLESS+HTTP+TLS 应用。）
2. [V2Ray(Trojan+HTTP)+Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(Trojan%2BHTTP)%2BCaddy)（Trojan+HTTP+TLS 应用。标记为 D。）
#### &emsp;V2Ray/Xray 的反代 gRPC 应用
1. [V2Ray(VMess+gRPC)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VMess%2BgRPC)%2BNginx%5CCaddy)（VMess+gRPC+TLS 应用。）
2. [V2Ray(SS+gRPC)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(SS%2BgRPC)%2BNginx%5CCaddy)（兼容 Shadowsocks 加 v2ray-plugin 插件的 grpc-tls 应用。标记为 G。）
3. [V2Ray(VLESS+gRPC)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VLESS%2BgRPC)%2BNginx%5CCaddy)（VLESS+gRPC+TLS 应用。）
4. [V2Ray(Trojan+gRPC)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(Trojan%2BgRPC)%2BNginx%5CCaddy)（Trojan+gRPC+TLS 应用。）
#### &emsp;Xray 的 Trojan 回落应用
1. [Xray(Trojan+RAW+TLS)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(Trojan%2BRAW%2BTLS)%2BNginx)（回落 Nginx 的 Trojan+RAW+TLS 应用。标记为 F。）
2. [Xray(Trojan+RAW+TLS)+Caddy](https://github.com/lxhao61/integrated-examples/tree/main/Xray(Trojan%2BRAW%2BTLS)%2BCaddy)（回落 Caddy 的 Trojan+RAW+TLS 应用。标记为 F。）
#### &emsp;Xray 的 XTLS Vision 应用
1. [Xray(VLESS+Vision+TLS)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(VLESS%2BVision%2BTLS)%2BNginx)（回落 Nginx 的 VLESS+Vision+TLS 应用。标记为 E。）
2. [Xray(VLESS+Vision+TLS)+Caddy](https://github.com/lxhao61/integrated-examples/tree/main/Xray(VLESS%2BVision%2BTLS)%2BCaddy)（回落 Caddy 的 VLESS+Vision+TLS 应用。标记为 E。）
#### &emsp;Xray 的反代 HTTPUpgrade 应用
1. [Xray(VMess+HTTPUpgrade)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/Xray(VMess%2BHTTPUpgrade)%2BNginx%5CCaddy)（VMess+HTTPUpgrade+TLS 应用。标记为 B。）
2. [Xray(VLESS+HTTPUpgrade)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/Xray(VLESS%2BHTTPUpgrade)%2BNginx%5CCaddy)（VLESS+HTTPUpgrade+TLS 应用。）
3. [Xray(Trojan+HTTPUpgrade)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/Xray(Trojan%2BHTTPUpgrade)%2BNginx%5CCaddy)（Trojan+HTTPUpgrade+TLS 应用。）
#### &emsp;Xray 的反代 XHTTP 应用
1. [Xray(VMess+XHTTP)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/Xray(VMess%2BXHTTP)%2BNginx%5CCaddy)（VMess+XHTTP+TLS 应用。）
2. [Xray(VLESS+XHTTP)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/Xray(VLESS%2BXHTTP)%2BNginx%5CCaddy)（VLESS+XHTTP+TLS 应用。标记为 H。）
3. [Xray(Trojan+XHTTP)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/Xray(Trojan%2BXHTTP)%2BNginx%5CCaddy)（Trojan+XHTTP+TLS 应用。）
#### &emsp;Xray 的 REALITY XHTTP 应用
1. [Xray(VLESS+XHTTP+REALITY)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(VLESS%2BXHTTP%2BREALITY))（VLESS+XHTTP+REALITY 应用。标记为 K。）
2. [Xray(Trojan+XHTTP+REALITY)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(Trojan%2BXHTTP%2BREALITY))（Trojan+XHTTP+REALITY 应用。）
#### &emsp;Xray 的 REALITY Vision 应用
1. [Xray(VLESS+Vision+REALITY)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(VLESS%2BVision%2BREALITY))（VLESS+Vision+REALITY 应用。标记为 M。）
2. [Xray(M+K)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M+K))（以 REALITY Vision 为核心套娃 REALITY 的应用。）
#### &emsp;Caddy 的 NaiveProxy/Trojan-Go 应用
1. [NaiveProxy(Caddy+forwardproxy)](https://github.com/lxhao61/integrated-examples/tree/main/NaiveProxy(Caddy%2Bforwardproxy))（基于 Caddy 插件的 NaiveProxy 应用。标记为 N。）
2. [Trojan-Go(Caddy+caddy-trojan)](https://github.com/lxhao61/integrated-examples/tree/main/Trojan-Go(Caddy%2Bcaddy-trojan))（基于 Caddy 插件的 Trojan-Go 应用。标记为 T。）
3. [Caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/Caddy(N%2BT))（基于 Caddy 插件的 NaiveProxy 与 Trojan-Go 共存应用。）
#### &emsp;Hysteria 应用
1. [Hysteria](https://github.com/lxhao61/integrated-examples/tree/main/Hysteria)（基于修改 QUIC 协议实现的双边加速代理应用。）

### 服务端综合应用配置示例
#### &emsp;以反代为核心的综合应用
1. [V2Ray(G+C+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(G%2BC%2BA)%2BNginx)（反代 gRPC、WebSocket 的综合应用。）
2. [V2Ray(D+G+C+A)+Caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(D%2BG%2BC%2BA)%2BCaddy(N%2BT))（反代 H2C/gRPC、WebSocket 加 NaiveProxy 与 Trojian-Go 的综合应用。）
3. [Xray(H+G+B+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(H%2BG%2BB%2BA)%2BNginx)（反代 XHTTP、gRPC、HTTPUpgrade 的综合应用。）
4. [Xray(H+G+B+A)+Caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(H%2BG%2BB%2BA)%2BCaddy(N%2BT))（反代 XHTTP、gRPC、HTTPUpgrade 加 NaiveProxy 与 Trojian-Go 的综合应用。）
#### &emsp;以 XTLS Vision 为核心的综合应用
1. [Xray(E+H+G+B+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(E%2BH%2BG%2BB%2BA)%2BNginx)（回落 Nginx 的综合应用。）
2. [Xray(E+H+G+B+A)+Caddy](https://github.com/lxhao61/integrated-examples/tree/main/Xray(E%2BH%2BG%2BB%2BA)%2BCaddy)（回落 Caddy 的综合应用。）
#### &emsp;以 REALITY Vision 为核心的综合应用
1. [Xray(M+H+K+G+B+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M%2BH%2BK%2BG%2BB%2BA)%2BNginx)（由 Nginx 提供证书的综合应用。）
2. [Xray(M+H+K+G+B+A)+Caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M%2BH%2BK%2BG%2BB%2BA)%2BCaddy(N%2BT))（由 Caddy 提供证书的综合应用。）
#### &emsp;由 Nginx/Caddy 兼顾 SNI 分流实现 XTLS Vision 与 Trojan 回落为核心的综合应用
1. [Xray(E+F+H+G+B+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(E%2BF%2BH%2BG%2BB%2BA)%2BNginx)（由 Nginx 兼顾 SNI 分流的综合应用。）
2. [Xray(E+F+H+G+B+A)+Caddy(N)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(E%2BF%2BH%2BG%2BB%2BA)%2BCaddy(N))（由 Caddy 兼顾 SNI 分流的综合应用。）
#### &emsp;由 Nginx/Caddy 兼顾 SNI 分流实现 REALITY Vision 与 Trojan 回落为核心的综合应用
1. [Xray(M+F+H+K+G+B+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M%2BF%2BH%2BK%2BG%2BB%2BA)%2BNginx)（由 Nginx 兼顾 SNI 分流的综合应用。）
2. [Xray(M+F+H+K+G+B+A)+Caddy(N)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M%2BF%2BH%2BK%2BG%2BB%2BA)%2BCaddy(N))（由 Caddy 兼顾 SNI 分流的综合应用。）
#### &emsp;注意（以上所有示例）:
1. Xray 是 V2Ray（v4 版） 的超集，包含其全部应用且配置完全兼容、还独有 XTLS Vision（主要解决 TLS in TLS 问题）、REALITY（主要解决基于 SNI 名单阻断问题） 等一系列增强应用。
2. V2Ray/Xray 示例中各应用都配置了屏蔽 BT 流量，如要调整请参考 ‘V2Ray(Other Configuration)’ 中 bt_config.json 示例。
3. V2Ray/Xray 单一核心应用简记：A=VLESS+mKCP+seed、B=VMess+HTTPUpgrade+TLS、C=VMess+WebSocket+TLS、D=Trojan+HTTP+TLS、E=VLESS+Vision+TLS、F=Trojan+RAW+TLS、G=Shadowsocks+gRPC+TLS、H=VLESS+XHTTP+TLS、K=VLESS+XHTTP+REALITY、M=VLESS+Vision+REALITY。
4. Caddy 插件单一应用简记：N=NaiveProxy(Caddy+forwardproxy)、T=Trojan-Go(Caddy+caddy-trojan)。
5. 目前 Caddy 从 Let's Encrypt 或 ZeroSSL 申请的免费 TLS 证书默认为 ECC 证书。
6. 基于安全原因，WebSocket 应用目前仅推荐使用 CDN 进行流量中转。
7. 若 CDN 流量中转不支持 WebSocket/HTTPUpgrade、gRPC 通过，可使用 XHTTP 应用来解决。
8. 若使用不可信的 CDN 进行流量中转，推荐使用自带加密的 VMess 配置；否则推荐使用轻量的 VLESS 或 Trojan 配置。
9. 综合应用配置示例中非 RAW（原 TCP） 应用怎么删、换、增，请参考‘服务端单一/简单应用配置示例’中对应示例。
10. 流量伪装与防探测网站可由其它 WEB 应用软件实现，其支持反代应用（反代 WebSocket/HTTPUpgrade、XHTTP、gRPC 及 H2C）与支持回落应用（提供 H2C server 及 HTTP/1.1 server 的 WEB 服务）等取决于自身，其配置自行参考 Caddy 或 Nginx 对应示例。
11. 支持本仓库中应用的 Caddy 程序文件已编译好，去本人 Releases 中下载即可。
12. Trojan-Go 安卓手机客户端也可以去本人 Releases 中（最早）下载。

### systemd 服务配置示例
&emsp;[Service Configuration](https://github.com/lxhao61/integrated-examples/tree/main/Service%20Configuration)（配置软件服务由 systemd 管理。）

### 服务端特殊应用配置示例
1. [V2Ray(Other Configuration)](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(Other%20Configuration)) （V2Ray 或 Xray 的特色应用配置方法。）
2. [Caddy(Other Configuration)](https://github.com/lxhao61/integrated-examples/tree/main/Caddy(Other%20Configuration)) （Caddy 的特色应用配置方法。）
3. [Fusion Configuration](https://github.com/lxhao61/integrated-examples/tree/main/Fusion%20Configuration) （服务端深度融合配置方法。）

### 原版客户端配置示例
&emsp;[Client Configuration](https://github.com/lxhao61/integrated-examples/tree/main/Client%20Configuration)（若使用第三方客户端参考即可。）

### 更新及贡献
1. 根据科学上网软件更新不定时调整示例，如科学上网软件有新增功能及应用等。
2. 根据当前科学上网情况不定时调整示例，如删除当前情况下不安全或被替代的应用等。
3. 欢迎你提交 PR，如对现行配置示例优化修订，或将自己使用的配置制作模板提交等。
