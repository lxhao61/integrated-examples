**这里是分享怎么搭建主流科学上网的优化配置及最优组合示例（如是不太了解科学上网，建议先依次从简单到复杂参考及部署。），其特点如下：**  
1. 实现了SNI分流使用Local Loopback连接或使用Unix Domain Socket（UDS）连接及启用PROXY protocol支持。
2. 实现了回落/分流使用Local Loopback连接或使用Unix Domain Socket（UDS）连接及启用PROXY protocol支持。
3. 实现了反代使用Local Loopback连接或使用Unix Domain Socket（UDS）连接支持。
4. 实现了nginx SNI分流（TCP转发）与定向UDP转发，以支持SNI分流后的naiveproxy HTTP/3代理应用。
5. 实现了caddy Caddyfile配置开启H2C server、H2C proxy及接收PROXY protocol等应用支持，让caddy配置简单化。
6. 实现了caddy json配置SNI分流应用，且支持针对转发端口或进程开启或关闭发送PROXY protocol，灵活性等同haproxy SNI分流。
7. 实现了caddy与Xray相关应用的SSL/TLS证书申请与更新全自动化。
8. 实现了CDN流量中转（基于WebSocket over TLS或基于gRPC over TLS）与正常应用同时使用。
9. 实现了除Xray/v2ray mKCP与hysteria应用外，其它应用对外都使用443端口，各应用互不影响。
10. 实现了除Xray/v2ray mKCP与hysteria应用外，其它应用都支持流量伪装与防探测，且提供流量伪装与防探测的回落或代理网站都支持HTTP自动跳转到HTTPS，SSL/TLS安全评估报告为A+等，即所有特征完全与真实网站一致。

### 服务端单一/简单应用配置示例
#### &emsp;caddy插件应用
1. [naiveproxy(caddy+forwardproxy)](https://github.com/lxhao61/integrated-examples/tree/main/naiveproxy(caddy%2Bforwardproxy)) （基于caddy插件的naiveproxy应用。标记为N。）
2. [trojan-go(caddy+caddy-trojan)](https://github.com/lxhao61/integrated-examples/tree/main/trojan-go(caddy%2Bcaddy-trojan)) （基于caddy插件的trojan-go应用。标记为T。）
3. [caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/caddy(N%2BT)) （基于caddy插件的naiveproxy与trojian-go应用。）
#### &emsp;trojan-go/trojan回落应用
1. [trojan-go\trojan+nginx](https://github.com/lxhao61/integrated-examples/tree/main/trojan-go%5Ctrojan%2Bnginx) （trojan-go/trojan回落nginx应用。）
2. [trojan-go\trojan+caddy(N)](https://github.com/lxhao61/integrated-examples/tree/main/trojan-go%5Ctrojan%2Bcaddy(N)) （trojan-go/trojan加naiveproxy应用。）
#### &emsp;Xray/v2ray mKCP与hysteria应用
1. [v2ray(vless\vmess+kcp+seed)](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(vless%5Cvmess%2Bkcp%2Bseed)) （vless+kcp+seed/vmess+kcp+seed应用。vless+kcp+seed标记为A。）
2. [hysteria](https://github.com/lxhao61/integrated-examples/tree/main/hysteria) （基于QUIC协议修改的双边加速代理应用。）
#### &emsp;Xray/v2ray WebSocket反代应用
1. [v2ray(vless\vmess+WS)+caddy\nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(vless%5Cvmess%2BWS)%2Bcaddy%5Cnginx) （vless+ws+tls/vmess+ws+tls反代应用。vmess+ws+tls标记为B。）
2. [v2ray(SS+WS)+caddy\nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(SS%2BWS)%2Bcaddy%5Cnginx) （shadowsocks+ws+tls反代应用。）
3. [v2ray(SS+v2ray-plugin)+caddy\nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(SS%2Bv2ray-plugin)%2Bcaddy%5Cnginx) （兼容原版shadowsocks加v2ray-plugin插件的WS反代应用。）
4. [v2ray(trojan+WS)+caddy\nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(trojan%2BWS)%2Bcaddy%5Cnginx) （trojan+ws+tls反代应用。标记为C。）
#### &emsp;Xray/v2ray H2C反代应用
1. [v2ray(vless\vmess+h2c)+caddy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(vless%5Cvmess%2Bh2c)%2Bcaddy) （vless+h2c+tls/vmess+h2c+tls反代应用。vless+h2c+tls标记为D。）
2. [v2ray(trojan+h2c)+caddy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(trojan%2Bh2c)%2Bcaddy) （trojan+h2c+tls反代应用。）
#### &emsp;Xray/v2ray gRPC反代应用
1. [v2ray(vless\vmess+grpc)+caddy\nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(vless%5Cvmess%2Bgrpc)%2Bcaddy%5Cnginx)（vless+grpc+tls/vmess+grpc+tls反代应用。）
2. [v2ray(SS+grpc)+caddy\nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(SS%2Bgrpc)%2Bcaddy%5Cnginx)（兼容原版shadowsocks加v2ray-plugin插件的gRPC反代应用。标记为G。）
3. [v2ray(trojan+grpc)+caddy\nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(trojan%2Bgrpc)%2Bcaddy%5Cnginx)（trojan+grpc+tls反代应用。）
#### &emsp;Xray/v2ray vless/trojan回落应用
1. [v2ray(vless\trojan+tcp+tls)+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(vless%5Ctrojan%2Btcp%2Btls)%2Bnginx) （vless+tcp+tls/xtls或trojan+tcp+tls/xtls回落nginx应用。分别标记为E与F。）
2. [v2ray(vless\trojan+tcp+tls)+caddy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(vless%5Ctrojan%2Btcp%2Btls)%2Bcaddy) （vless+tcp+tls/xtls或trojan+tcp+tls/xtls回落caddy应用。分别标记为E与F。）

### 服务端综合应用配置示例
#### &emsp;Xray/v2ray反向代理的综合应用
1. [v2ray(B+G+A)+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(B%2BG%2BA)%2Bnginx) （反向代理WebSocket、gRPC的综合应用。）
2. [v2ray(B+D+G+A)+caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(B%2BD%2BG%2BA)%2Bcaddy(N%2BT)) （反向代理WebSocket、H2C、gRPC加naiveproxy与trojian-go的综合应用。）
#### &emsp;Xray/v2ray vless回落/分流为主的综合应用
1. [v2ray(E+B+G+A)+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BG%2BA)%2Bnginx) （以vless+tcp+tls/xtls为主的综合应用。）
2. [v2ray(E+B+D+G+A)+caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BD%2BG%2BA)%2Bcaddy(N%2BT)) （以vless+tcp+tls/xtls为主加naiveproxy与trojian-go的综合应用。）
#### &emsp;Xray/v2ray trojan回落/分流为主的综合应用
1. [v2ray(F+C+G+A)+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(F%2BC%2BG%2BA)%2Bnginx) （以trojan+tcp+tls/xtls为主的综合应用。）
2. [v2ray(F+C+D+G+A)+caddy(N)](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(F%2BC%2BD%2BG%2BA)%2Bcaddy(N)) （以trojan+tcp+tls/xtls为主加naiveproxy的综合应用。）
#### &emsp;以套娃方式实现vless回落/分流与trojan回落共存为主的综合应用
1. [v2ray(E+C+F+A)+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BC%2BF%2BA)%2Bnginx) （由套娃方式实现的综合应用。）
2. [v2ray(E+C+F+A)+caddy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BC%2BF%2BA)%2Bcaddy) （由套娃方式实现的综合应用。）
#### &emsp;以nginx/caddy兼顾SNI分流实现vless回落/分流与trojan回落/分流共存为主的综合应用
1. [v2ray(E+B+F+C+G+A)+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BF%2BC%2BG%2BA)%2Bnginx) （由nginx兼顾SNI分流实现的综合应用。）
2. [v2ray(E+B+F+C+D+G+A)+caddy(N)](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BF%2BC%2BD%2BG%2BA)%2Bcaddy(N)) （由caddy兼顾SNI分流实现的综合应用。）
#### &emsp;以nginx/caddy兼顾SNI分流实现vless回落/分流为主的综合应用与trojan-go/trojan共存
1. [v2ray(E+B+G+A)+trojan+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BG%2BA)%2Btrojan%2Bnginx) （由nginx兼顾SNI分流实现的综合应用。）
2. [v2ray(E+B+D+G+A)+trojan+caddy(N)](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BD%2BG%2BA)%2Btrojan%2Bcaddy(N)) （由caddy兼顾SNI分流实现的综合应用。）
#### &emsp;由nginx/haproxy专职SNI分流实现兼顾各方优势的综合应用
1. [v2ray(E+B+D+G+A)+trojan+caddy(N)+nginx\haproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BD%2BG%2BA)%2Btrojan%2Bcaddy(N)%2Bnginx%5Chaproxy) （trojan-go/trojan由原版实现的综合应用。）
2. [v2ray(E+B+D+G+A)+caddy(N+T)+nginx\haproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BD%2BG%2BA)%2Bcaddy(N%2BT)%2Bnginx%5Chaproxy) （trojan-go/trojan由caddy插件实现的综合应用。）
3. [v2ray(E+B+F+C+D+G+A)+caddy(N)+nginx\haproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BF%2BC%2BD%2BG%2BA)%2Bcaddy(N)%2Bnginx%5Chaproxy) （trojan/trojan-go由Xray/v2ray配置实现的综合应用。）
#### &emsp;注意（以上所有示例）:
1. v2ray从v4.33.0版开始删除了XTLS应用，故若还想用XTLS应用，请选Xray。Xray是v2ray的超集（更好的整体性能和XTLS等一系列增强，且完全兼容。），也是因为这个应用分家独自发展。
2. Xray/v2ray单一核心应用简记：A=vless+kcp+seed、B=vmess+ws+tls、C=trojan+ws+tls、D=vless+h2c+tls、E=vless+tcp+tls/xtls、F=trojan+tcp+tls/xtls、G=shadowsocks+grpc+tls。
3. Xray/v2ray示例中各应用都配置了禁用BT。如不需要，可参考v2ray(other configuration)中BT_config.json配置删除相关配置。
4. caddy插件单一应用简记：N=naiveproxy(caddy+forwardproxy)、T=trojan-go(caddy+caddy-trojan)。
5. 目前caddy采用UDS监听不支持HTTP/3，即仅端口监听才支持开启HTTP/3。
6. 受限应用条件及场景，naiveproxy的QUIC应用（即caddy的HTTP/3代理应用）不是所有相关naiveproxy示例都支持。
7. 当前caddy从Let's Encrypt或ZeroSSL自动申请的SSL/TLS证书都为ECC证书。
8. 流量伪装与防探测网站可由其它WEB应用软件实现，其支持反代（WebSocket、gRPC及H2C）与支持回落（H2C server及HTTP/1.1 server）取决于自身，配置自行参考caddy或nginx对应示例。
9. 附加相关插件的caddy程序文件已编译好，去本人Releases中下载即可。
10. trojan-go安卓客户端可以去本人Releases中下载（最末）。

### 服务端特殊应用配置示例
1. [v2ray(other configuration)](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(other%20configuration)) （Xray或v2ray的特色应用配置方法。）
2. [caddy(other configuration)](https://github.com/lxhao61/integrated-examples/tree/main/caddy(other%20configuration)) （caddy的特色应用配置方法。）

### 原版客户端配置示例
&emsp;[client configuration](https://github.com/lxhao61/integrated-examples/tree/main/client%20configuration)（若使用第三方客户端参考即可。）

### systemd服务文件
&emsp;[service configuration](https://github.com/lxhao61/integrated-examples/tree/main/service%20configuration)（配置软件服务由systemd管理。）

### 使用/贡献指南
1. 若科学上网相关软件增加新功能，开始在服务端单一应用配置示例中添加；过一段时间（测试及验证稳定后）才会服务端综合应用配置示例中添加。
2. 欢迎你提交 PR，如对现行配置示例优化修订，或将自己使用的配置制作模板提交等。
