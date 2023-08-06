**这里是分享怎么搭建主流科学上网的优化配置及最优组合示例（如是不太了解科学上网，建议先依次从简单到复杂参考及部署。），其特点如下：**  
1. 实现了反代使用Local Loopback连接或使用Unix Domain Socket（UDS）连接支持。
2. 实现了回落/分流使用Local Loopback连接或使用Unix Domain Socket（UDS）连接及启用PROXY protocol支持。
3. 实现了SNI分流使用Local Loopback连接或使用Unix Domain Socket（UDS）连接及启用PROXY protocol支持。
4. 实现了Caddy、V2Ray/Xray使用UDS连接时采用Abstract sockets模式（不需考虑文件路径及权限设置问题）。
5. 实现了Nginx SNI分流（TCP转发）与定向UDP转发配合以支持SNI分流后的NaiveProxy HTTP/3代理应用。
6. 实现了使用json配置Caddy SNI分流，且可针对分流端口或进程是否开启PROXY protocol发送。
7. 实现了Caddy与相关应用的TLS证书申请与更新全自动化。
8. 实现了服务端综合应用配置示例中使用mKCP、WebSocket、HTTP/2（H2）、gRPC传输方式的应用配置可删、可换、可增（REALITY H2/gRPC应用除外），灵活组合而不影响整体架构。
9. 实现了正常应用与CDN流量中转（基于WebSocket over TLS或基于gRPC over TLS）同时使用。
10. 实现了除V2Ray/Xray的mKCP应用与TUIC/Hysteria应用之外，其它应用对外都使用443端口，各应用互不影响。
11. 实现了除V2Ray/Xray的mKCP应用与TUIC/Hysteria应用之外，其它应用都支持流量伪装与防探测，且提供流量伪装与防探测的回落或代理网站都支持HTTP自动跳转到HTTPS，SSL/TLS安全评估报告为A+（非AES算法的密码套件配置示例除外）等，即所有特征完全与真实网站一致。

### 服务端单一/简单应用配置示例
#### &emsp;V2Ray/Xray的mKCP应用
1. [V2Ray(VMess\VLESS+mKCP+seed)](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VMess%5CVLESS%2BmKCP%2Bseed))（VMess/VLESS+mKCP+seed应用。VLESS+mKCP+seed标记为A。）
#### &emsp;V2Ray/Xray的反代WebSocket应用
1. [V2Ray(VMess+WebSocket)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VMess%2BWebSocket)%2BNginx%5CCaddy)（VMess+WebSocket+TLS应用。标记为B。）
2. [V2Ray(SS+Door+WebSocket)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(SS%2BDoor%2BWebSocket)%2BNginx%5CCaddy)（兼容Shadowsocks加v2ray-plugin插件的websocket-tls应用。）
3. [V2Ray(VLESS+WebSocket)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VLESS%2BWebSocket)%2BNginx%5CCaddy)（VLESS+WebSocket+TLS应用。）
4. [V2Ray(Trojan+WebSocket)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(Trojan%2BWebSocket)%2BNginx%5CCaddy)（Trojan+WebSocket+TLS应用。）
#### &emsp;V2Ray/Xray的反代H2C应用
1. [V2Ray(VLESS+H2C)+Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VLESS%2BH2C)%2BCaddy)（VLESS+H2C+TLS应用。标记为D。）
2. [V2Ray(Trojan+H2C)+Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(Trojan%2BH2C)%2BCaddy)（Trojan+H2C+TLS应用。）
#### &emsp;V2Ray/Xray的反代gRPC应用
1. [V2Ray(VMess+gRPC)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VMess%2BgRPC)%2BNginx%5CCaddy)（VMess+gRPC+TLS应用。）
2. [V2Ray(SS+gRPC)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(SS%2BgRPC)%2BNginx%5CCaddy)（兼容Shadowsocks加v2ray-plugin插件的grpc-tls应用。标记为G。）
3. [V2Ray(VLESS+gRPC)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VLESS%2BgRPC)%2BNginx%5CCaddy)（VLESS+gRPC+TLS应用。）
4. [V2Ray(Trojan+gRPC)+Nginx\Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(Trojan%2BgRPC)%2BNginx%5CCaddy)（Trojan+gRPC+TLS应用。）
#### &emsp;Xray的Trojan回落应用
1. [Xray(Trojan+TCP+TLS)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(Trojan%2BTCP%2BTLS)%2BNginx)（Trojan+TCP+TLS回落Nginx应用。标记为F。）
2. [Xray(Trojan+TCP+TLS)+Caddy](https://github.com/lxhao61/integrated-examples/tree/main/Xray(Trojan%2BTCP%2BTLS)%2BCaddy)（Trojan+TCP+TLS回落Caddy应用。标记为F。）
#### &emsp;Xray的XTLS Vision应用
1. [Xray(VLESS+Vision+TLS)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(VLESS%2BVision%2BTLS)%2BNginx)（VLESS+Vision+TLS回落Nginx。标记为E。）
2. [Xray(VLESS+Vision+TLS)+Caddy](https://github.com/lxhao61/integrated-examples/tree/main/Xray(VLESS%2BVision%2BTLS)%2BCaddy)（VLESS+Vision+TLS回落Caddy。标记为E。）
#### &emsp;Xray的REALITY H2/gRPC应用
1. [Xray(VLESS+H2C+REALITY)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(VLESS%2BH2C%2BREALITY))（VLESS+H2C+REALITY应用。标记为K。）
2. [Xray(SS+gRPC+REALITY)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(SS%2BgRPC%2BREALITY))（Shadowsocks+gRPC+REALITY应用。）
#### &emsp;Xray的REALITY Vision应用
1. [Xray(VLESS+Vision+REALITY)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(VLESS%2BVision%2BREALITY))（VLESS+Vision+REALITY应用。标记为M。）
2. [Xray(M+K)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M+K))（以REALITY Vision为核心的套娃应用。）
#### &emsp;Caddy的NaiveProxy与Trojan-Go应用
1. [NaiveProxy(Caddy+forwardproxy)](https://github.com/lxhao61/integrated-examples/tree/main/NaiveProxy(Caddy%2Bforwardproxy))（基于Caddy插件的NaiveProxy应用。标记为N。）
2. [Trojan-Go(Caddy+caddy-trojan)](https://github.com/lxhao61/integrated-examples/tree/main/Trojan-Go(Caddy%2Bcaddy-trojan))（基于Caddy插件的Trojan-Go应用。标记为T。）
3. [Caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/Caddy(N%2BT))（基于Caddy插件的NaiveProxy与Trojan-Go共存应用。）
#### &emsp;TUIC与Hysteria应用
1. [TUIC](https://github.com/lxhao61/integrated-examples/tree/main/TUIC)（基于原生QUIC协议的代理应用。）
2. [Hysteria](https://github.com/lxhao61/integrated-examples/tree/main/Hysteria)（基于QUIC协议修改的双边加速代理应用。）

### 服务端综合应用配置示例
#### &emsp;以反代为核心的综合应用
1. [V2Ray(B+G+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(B%2BG%2BA)%2BNginx)（反代WebSocket、gRPC的综合应用。）
2. [V2Ray(B+D+G+A)+Caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(B%2BD%2BG%2BA)%2BCaddy(N%2BT))（反代WebSocket、H2C、gRPC加NaiveProxy与Trojian-Go的综合应用。）
#### &emsp;以XTLS Vision为核心的综合应用
1. [Xray(E+B+G+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(E%2BB%2BG%2BA)%2BNginx)（以VLESS回落Nginx为核心的综合应用。）
2. [Xray(E+B+G+A)+Caddy](https://github.com/lxhao61/integrated-examples/tree/main/Xray(E%2BB%2BG%2BA)%2BCaddy)（以VLESS回落Caddy为核心的综合应用。）
#### &emsp;以REALITY Vision为核心的综合应用
1. [Xray(M+B+G+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M%2BB%2BG%2BA)%2BNginx)（由Nginx提供网站实现以REALITY Vision为核心的综合应用。）
2. [Xray(M+B+D+G+A)+Caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M%2BB%2BD%2BG%2BA)%2BCaddy(N%2BT))（由Caddy提供网站实现以REALITY Vision为核心的综合应用。）
#### &emsp;由Nginx/Caddy兼顾SNI分流实现XTLS Vision与Trojan回落为核心的综合应用
1. [Xray(E+F+B+G+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(E%2BF%2BB%2BG%2BA)%2BNginx)（由Nginx兼顾SNI分流实现的综合应用。）
2. [Xray(E+F+B+D+G+A)+Caddy(N)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(E%2BF%2BB%2BD%2BG%2BA)%2BCaddy(N))（由Caddy兼顾SNI分流实现的综合应用。）
#### &emsp;由Nginx/Caddy兼顾SNI分流实现REALITY Vision与Trojan回落为核心的综合应用
1. [Xray(M+F+B+G+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M%2BF%2BB%2BG%2BA)%2BNginx)（由Nginx兼顾SNI分流实现的综合应用。）
2. [Xray(M+F+B+D+G+A)+Caddy(N)](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M%2BF%2BB%2BD%2BG%2BA)%2BCaddy(N))（由Caddy兼顾SNI分流实现的综合应用。）
#### &emsp;由Nginx专职SNI分流实现兼顾各方优势的综合应用
1. [Xray(E+F+B+D+G+A)+Caddy(N)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(E%2BF%2BB%2BD%2BG%2BA)%2BCaddy(N)%2BNginx)（以XTLS Vision为核心的综合应用。）
2. [Xray(M+F+B+D+G+A)+Caddy(N)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Xray(M%2BF%2BB%2BD%2BG%2BA)%2BCaddy(N)%2BNginx)（以REALITY Vision为核心的综合应用。）
#### &emsp;注意（以上所有示例）:
1. Xray是V2Ray的超集，更好的整体性能和独有的XTLS Vision（主要解决TLS in TLS问题）、REALITY（主要解决基于SNI名单阻断问题）等一系列应用增强，且完全兼容V2Ray的v4版。
2. V2Ray/Xray示例中各应用都配置了禁用BT。如不需要，参考‘V2Ray(Other Configuration)’中BT_config.json示例删除相关配置。
3. V2Ray/Xray单一核心应用简记：A=VLESS+mKCP+seed、B=VMess+WebSocket+TLS、D=VLESS+H2C+TLS、E=VLESS+Vision+TLS、F=Trojan+TCP+TLS、G=Shadowsocks+gRPC+TLS、K=VLESS+H2C+REALITY、M=VLESS+Vision+REALITY。
4. Caddy插件单一应用简记：N=NaiveProxy(Caddy+forwardproxy)、T=Trojan-Go(Caddy+caddy-trojan)。
5. 受限应用条件及场景，NaiveProxy的QUIC应用（即Caddy的HTTP/3代理应用）不是所有相关NaiveProxy示例都支持。
6. 目前Caddy从Let's Encrypt或ZeroSSL自动申请的TLS证书默认都为ECC证书。
7. 综合应用配置示例中使用mKCP、WebSocket、HTTP/2（H2）、gRPC传输方式的应用配置可删、可换、可增（REALITY H2/gRPC应用除外）；参考‘服务端单一/简单应用配置示例’中对应配置示例修改。
8. 当前不推荐使用WebSocket传输方式的应用直接科学上网，套CDN使用无碍。若CDN流量中转（基于WebSocket over TLS或基于gRPC over TLS）使用不可信的CDN进行中转，V2Ray/Xray示例推荐使用自身带加密的VMess或Shadowsocks协议配置；否则推荐使用自身不带加密的VLESS或Trojan协议配置。
9. 针对V2Ray特性，当前服务端配置推荐使用非AES算法密码套件配置示例，客户端开启uTLS指纹。 针对Xray特性，当前服务端配置依次推荐使用REALITY Vision配置示例、XTLS Vision配置示例、非AES算法的密码套件配置示例、REALITY配置示例，客户端开启uTLS指纹。
10. 流量伪装与防探测网站可由其它WEB应用软件实现，其支持反代应用（反代WebSocket、gRPC及H2C）与支持回落应用（提供H2C server及HTTP/1.1 server的WEB服务）等取决于自身，其配置自行参考Caddy或Nginx对应配置示例。
11. 附加相关插件的Caddy程序文件已编译好，去本人Releases中下载即可。
12. Trojan-Go安卓手机客户端可以去本人Releases中下载（最末）。

### 服务端特殊应用配置示例
1. [V2Ray(Other Configuration)](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(Other%20Configuration)) （V2Ray或Xray的特色应用配置方法。）
2. [Caddy(Other Configuration)](https://github.com/lxhao61/integrated-examples/tree/main/Caddy(Other%20Configuration)) （Caddy的特色应用配置方法。）

### 原版客户端配置示例
&emsp;[Client Configuration](https://github.com/lxhao61/integrated-examples/tree/main/Client%20Configuration)（若使用第三方客户端参考即可。）

### systemd服务文件
&emsp;[Service Configuration](https://github.com/lxhao61/integrated-examples/tree/main/Service%20Configuration)（配置软件服务由systemd管理。）

### 更新及贡献
1. 根据科学上网软件更新不定时调整示例，如科学上网软件有新增功能及应用等。
2. 根据当前科学上网情况不定时调整示例，如删除当前情况下不安全或被替代的应用等。
3. 欢迎你提交PR，如对现行配置示例优化修订，或将自己使用的配置制作模板提交等。
