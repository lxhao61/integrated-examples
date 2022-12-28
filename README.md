**这里是分享怎么搭建主流科学上网的优化配置及最优组合示例（如是不太了解科学上网，建议先依次从简单到复杂参考及部署。），其特点如下：**  
1. 实现了SNI分流使用Local Loopback连接或使用Unix Domain Socket（UDS）连接及启用PROXY protocol支持。
2. 实现了回落/分流使用Local Loopback连接或使用Unix Domain Socket（UDS）连接及启用PROXY protocol支持。
3. 实现了反代使用Local Loopback连接或使用Unix Domain Socket（UDS）连接支持。
4. 实现了Nginx SNI分流（TCP转发）与定向UDP转发，以支持SNI分流后的NaiveProxy HTTP/3代理应用。
5. 实现了Caddy Caddyfile配置开启H2C server、H2C proxy及接收PROXY protocol等应用支持，让Caddy配置简单化。
6. 实现了Caddy json配置SNI分流应用，且支持针对转发端口或进程开启或关闭发送PROXY protocol，灵活性等同HAProxy SNI分流。
7. 实现了Caddy与相关应用的TLS证书申请与更新全自动化。
8. 实现了CDN流量中转（基于WebSocket over TLS或基于gRPC over TLS）与正常应用同时使用。
9. 实现了除Xray/V2Ray mKCP与Hysteria应用之外，其它应用对外都使用443端口，各应用互不影响。
10. 实现了除Xray/V2Ray mKCP与Hysteria应用之外，其它应用都支持流量伪装与防探测，且提供流量伪装与防探测的回落或代理网站都支持HTTP自动跳转到HTTPS，SSL/TLS安全评估报告为A+（V2Ray回落网站除外）等，即所有特征完全与真实网站一致。

### 服务端单一/简单应用配置示例
#### &emsp;Caddy插件应用
1. [NaiveProxy(Caddy+forwardproxy)](https://github.com/lxhao61/integrated-examples/tree/main/NaiveProxy(Caddy%2Bforwardproxy)) （基于Caddy插件的NaiveProxy应用。标记为N。）
2. [Trojan-Go(Caddy+caddy-trojan)](https://github.com/lxhao61/integrated-examples/tree/main/Trojan-Go(Caddy%2Bcaddy-trojan)) （基于Caddy插件的Trojan-Go应用。标记为T。）
3. [Caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/Caddy(N%2BT)) （基于Caddy插件的NaiveProxy与Trojan-Go应用。）
#### &emsp;Trojan-Go/Trojan回落应用
1. [Trojan-Go\Trojan+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/Trojan-Go%5CTrojan%2BNginx) （Trojan-Go/Trojan回落Nginx应用。）
2. [Trojan-Go\Trojan+Caddy(N)](https://github.com/lxhao61/integrated-examples/tree/main/Trojan-Go%5CTrojan%2BCaddy(N)) （Trojan-Go/Trojan回落Caddy加NaiveProxy应用。）
#### &emsp;Xray/V2Ray mKCP与Hysteria应用
1. [V2Ray(VLESS\VMess+mKCP+seed)](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VLESS%5CVMess%2BmKCP%2Bseed)) （vless+kcp+seed/vmess+kcp+seed应用。vless+kcp+seed标记为A。）
2. [Hysteria](https://github.com/lxhao61/integrated-examples/tree/main/Hysteria) （基于QUIC协议修改的双边加速代理应用。）
#### &emsp;Xray/V2Ray WebSocket反代应用
1. [V2Ray(VLESS\VMess+WS)+Caddy\Nginx](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VLESS%5CVMess%2BWS)%2BCaddy%5CNginx) （vless+ws+tls/vmess+ws+tls反代应用。vmess+ws+tls标记为B。）
2. [V2Ray(SS+WS)+Caddy\Nginx](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(SS%2BWS)%2BCaddy%5CNginx) （shadowsocks+ws+tls反代应用。）
3. [V2Ray(SS+v2ray-plugin)+Caddy\Nginx](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(SS%2Bv2ray-plugin)%2BCaddy%5CNginx) （兼容原版Shadowsocks加v2ray-plugin插件的WS反代应用。）
4. [V2Ray(Trojan+WS)+Caddy\Nginx](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(Trojan%2BWS)%2BCaddy%5CNginx) （trojan+ws+tls反代应用。标记为C。）
#### &emsp;Xray/V2Ray H2C反代应用
1. [V2Ray(VLESS\VMess+H2C)+Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VLESS%5CVMess%2BH2C)%2BCaddy) （vless+h2c+tls/vmess+h2c+tls反代应用。vless+h2c+tls标记为D。）
2. [V2Ray(Trojan+H2C)+Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(Trojan%2BH2C)%2BCaddy) （trojan+h2c+tls反代应用。）
#### &emsp;Xray/V2Ray gRPC反代应用
1. [V2Ray(VLESS\VMess+gRPC)+Caddy\Nginx](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VLESS%5CVMess%2BgRPC)%2BCaddy%5CNginx)（vless+grpc+tls/vmess+grpc+tls反代应用。）
2. [V2Ray(SS+gRPC)+Caddy\Nginx](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(SS%2BgRPC)%2BCaddy%5CNginx)（兼容原版Shadowsocks加v2ray-plugin插件的gRPC反代应用。标记为G。）
3. [V2Ray(Trojan+gRPC)+Caddy\Nginx](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(Trojan%2BgRPC)%2BCaddy%5CNginx)（trojan+grpc+tls反代应用。）
#### &emsp;Xray/V2Ray VLESS/Trojan回落应用
1. [V2Ray(VLESS\Trojan+TCP+TLS)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VLESS%5CTrojan%2BTCP%2BTLS)%2BNginx)（vless+tcp+tls/xtls与trojan+tcp+tls/xtls回落Nginx应用。标记为E与F。）
2. [V2Ray(VLESS\Trojan+TCP+TLS)+Caddy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(VLESS%5CTrojan%2BTCP%2BTLS)%2BCaddy)（vless+tcp+tls/xtls与trojan+tcp+tls/xtls回落Caddy应用。标记为E与F。）

### 服务端综合应用配置示例
#### &emsp;Xray/V2Ray反向代理的综合应用
1. [V2Ray(B+G+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(B%2BG%2BA)%2BNginx) （反向代理WebSocket、gRPC的综合应用。）
2. [V2Ray(B+D+G+A)+Caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(B%2BD%2BG%2BA)%2BCaddy(N%2BT)) （反向代理WebSocket、H2C、gRPC加NaiveProxy与Trojian-Go的综合应用。）
#### &emsp;Xray/V2Ray VLESS回落/分流为主的综合应用
1. [V2Ray(E+B+G+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(E%2BB%2BG%2BA)%2BNginx) （以vless+tcp+tls/xtls为主的综合应用。）
2. [V2Ray(E+B+D+G+A)+Caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(E%2BB%2BD%2BG%2BA)%2BCaddy(N%2BT)) （以vless+tcp+tls/xtls为主加NaiveProxy与Trojian-Go的综合应用。）
#### &emsp;Xray/V2Ray Trojan回落/分流为主的综合应用
1. [V2Ray(F+C+G+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(F%2BC%2BG%2BA)%2BNginx) （以trojan+tcp+tls/xtls为主的综合应用。）
2. [V2Ray(F+C+D+G+A)+Caddy(N)](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(F%2BC%2BD%2BG%2BA)%2BCaddy(N)) （以trojan+tcp+tls/xtls为主加NaiveProxy的综合应用。）
#### &emsp;以套娃方式实现VLESS回落/分流与Trojan回落共存为主的综合应用
1. [V2Ray(E+B+C+F+G+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(E%2BB%2BC%2BF%2BG%2BA)%2BNginx) （由套娃方式实现的综合应用。）
2. [V2Ray(E+B+C+F+D+G+A)+Caddy(N)](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(E%2BB%2BC%2BF%2BD%2BG%2BA)%2BCaddy(N)) （由套娃方式实现的综合应用。）
#### &emsp;以Nginx/Caddy兼顾SNI分流实现VLESS回落/分流与Trojan回落/分流共存为主的综合应用
1. [V2Ray(E+B+F+C+G+A)+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(E%2BB%2BF%2BC%2BG%2BA)%2BNginx) （由Nginx兼顾SNI分流实现的综合应用。）
2. [V2Ray(E+B+F+C+D+G+A)+Caddy(N)](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(E%2BB%2BF%2BC%2BD%2BG%2BA)%2BCaddy(N)) （由Caddy兼顾SNI分流实现的综合应用。）
#### &emsp;以Nginx/Caddy兼顾SNI分流实现VLESS回落/分流为主的综合应用与Trojan-Go/Trojan共存
1. [V2Ray(E+B+G+A)+Trojan+Nginx](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(E%2BB%2BG%2BA)%2BTrojan%2BNginx) （由Nginx兼顾SNI分流实现的综合应用。）
2. [V2Ray(E+B+D+G+A)+Trojan+Caddy(N)](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(E%2BB%2BD%2BG%2BA)%2BTrojan%2BCaddy(N)) （由Caddy兼顾SNI分流实现的综合应用。）
#### &emsp;由Nginx/HAProxy专职SNI分流实现兼顾各方优势的综合应用
1. [V2Ray(E+B+D+G+A)+Trojan+Caddy(N)+Nginx\HAProxy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(E%2BB%2BD%2BG%2BA)%2BTrojan%2BCaddy(N)%2BNginx%5CHAProxy) （Trojan-Go/Trojan由原版实现的综合应用。）
2. [V2Ray(E+B+D+G+A)+Caddy(N+T)+Nginx\HAProxy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(E%2BB%2BD%2BG%2BA)%2BCaddy(N%2BT)%2BNginx%5CHAProxy) （Trojan-Go/Trojan由Caddy插件实现的综合应用。）
3. [V2Ray(E+B+F+C+D+G+A)+Caddy(N)+Nginx\HAProxy](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(E%2BB%2BF%2BC%2BD%2BG%2BA)%2BCaddy(N)%2BNginx%5CHAProxy) （Trojan/Trojan-Go由Xray/V2Ray配置实现的综合应用。）
#### &emsp;注意（以上所有示例）:
1. V2Ray从v4.33.0版开始删除了XTLS应用，故若还想用XTLS应用，请选Xray。Xray是V2Ray的超集（更好的整体性能和XTLS等一系列增强，且完全兼容。），也是因为这个应用分家独自发展。
2. Xray/V2Ray单一核心应用简记：A=vless+kcp+seed、B=vmess+ws+tls、C=trojan+ws+tls、D=vless+h2c+tls、E=vless+tcp+tls/xtls、F=trojan+tcp+tls/xtls、G=shadowsocks+grpc+tls。
3. Xray/V2Ray示例中各应用都配置了禁用BT。如不需要，可参考V2Ray(Other Configuration)中BT_config.json示例删除相关配置。
4. Caddy插件单一应用简记：N=NaiveProxy(Caddy+forwardproxy)、T=Trojan-Go(Caddy+caddy-trojan)。
5. 受限应用条件及场景，NaiveProxy的QUIC应用（即Caddy的HTTP/3代理应用）不是所有相关NaiveProxy示例都支持。
6. 当前Caddy从Let's Encrypt或ZeroSSL自动申请的TLS证书默认都为ECC证书。
7. 流量伪装与防探测网站可由其它WEB应用软件实现，其支持反代（WebSocket、gRPC及H2C）与支持回落（H2C server及HTTP/1.1 server）取决于自身，配置自行参考Caddy或Nginx对应示例。
8. 附加相关插件的Caddy程序文件已编译好，去本人Releases中下载即可。
9. Trojan-Go安卓手机客户端可以去本人Releases中下载（最末）。

### 服务端特殊应用配置示例
1. [V2Ray(Other Configuration)](https://github.com/lxhao61/integrated-examples/tree/main/V2Ray(Other%20Configuration)) （Xray或V2Ray的特色应用配置方法。）
2. [Caddy(Other Configuration)](https://github.com/lxhao61/integrated-examples/tree/main/Caddy(Other%20Configuration)) （Caddy的特色应用配置方法。）

### 原版客户端配置示例
&emsp;[Client Configuration](https://github.com/lxhao61/integrated-examples/tree/main/Client%20Configuration)（若使用第三方客户端参考即可。）

### systemd服务文件
&emsp;[Service Configuration](https://github.com/lxhao61/integrated-examples/tree/main/Service%20Configuration)（配置软件服务由systemd管理。）

### 使用/贡献指南
1. 若科学上网相关软件增加新功能，开始在服务端单一应用配置示例中添加；过一段时间（测试及验证稳定后）才会服务端综合应用配置示例中添加。
2. 欢迎你提交 PR，如对现行配置示例优化修订，或将自己使用的配置制作模板提交等。
