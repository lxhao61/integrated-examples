**这里是分享怎么搭建主流科学上网的优化配置及最优组合示例（如是不太了解科学上网，建议先依次从简单到复杂参考及部署。），其特点如下：**  
1. 实现了SNI分流应用的端口分流到进程分流及启用PROXY protocol的从低到高（效率）应用支持。
2. 实现了回落应用的端口回落/分流到进程回落/分流及启用PROXY protocol的从低到高（效率）应用支持。
3. 实现了反代应用的端口转发到进程转发的从低到高（效率）应用支持。
4. 实现了nginx SNI分流（TCP转发）与定向UDP转发，以支持SNI分流后的naiveproxy HTTP/3代理应用。
5. 实现了caddy Caddyfile配置开启H2C server、H2C proxy及接收PROXY protocol等应用支持，让caddy配置简单化。
6. 实现了caddy json配置SNI分流应用，且支持针对转发端口或进程开启或关闭发送PROXY protocol，灵活性等同haproxy SNI分流。
7. 实现了caddy与Xray相关应用的证书及密钥申请与更新全自动化。
8. 实现了CDN流量中转（基于WebSocket over TLS或基于gRPC over TLS）与正常应用同时使用。
9. 实现了除v2ray(vless\vmess+kcp+seed)与hysteria示例或应用外，其它应用对外都使用443端口，各应用互不影响。
10. 实现了除v2ray(vless\vmess+kcp+seed)与hysteria示例或应用外，其它应用都支持流量伪装与防探测，且提供流量伪装与防探测的回落或代理网站都支持HTTP自动跳转到HTTPS，SSL/TLS安全评估报告为A+等，即所有特征完全与真实网站一致。
* **备注：** 端口分流、端口回落/分流、端口转发是指基于Local Loopback连接的不同功能应用分类；进程分流、进程回落/分流、进程转发是指基于Unix Domain Socket连接的不同功能应用分类。

### 服务端单一应用配置示例
1. [trojan-go\trojan+nginx](https://github.com/lxhao61/integrated-examples/tree/main/trojan-go%5Ctrojan%2Bnginx) （trojan-go或trojan回落nginx应用。）
2. [trojan-go\trojan+caddy](https://github.com/lxhao61/integrated-examples/tree/main/trojan-go%5Ctrojan%2Bcaddy) （trojan-go或trojan回落caddy应用。）
---
1. [naiveproxy(caddy+forwardproxy)](https://github.com/lxhao61/integrated-examples/tree/main/naiveproxy(caddy%2Bforwardproxy)) （基于caddy的HTTP/2或HTTP/3代理应用。标记为N。）
2. [trojan-go(caddy+caddy-trojan)](https://github.com/lxhao61/integrated-examples/tree/main/trojan-go(caddy%2Bcaddy-trojan)) （基于caddy-trojan插件的trojan-go应用。标记为T。）
---
1. [v2ray(vless\vmess+kcp+seed)](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(vless%5Cvmess%2Bkcp%2Bseed)) （vless+kcp+seed或vmess+kcp+seed应用。vless+kcp+seed标记为A。）
2. [hysteria](https://github.com/lxhao61/integrated-examples/tree/main/hysteria) （基于QUIC协议修改的双边加速代理应用。）
---
1. [v2ray(vless\vmess+WS)+caddy\nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(vless%5Cvmess%2BWS)%2Bcaddy%5Cnginx) （vless+ws+tls或vmess+ws+tls反代应用。vless+ws+tls标记为B。）
2. [v2ray(SS+WS)+caddy\nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(SS%2BWS)%2Bcaddy%5Cnginx) （shadowsocks+ws+tls反代应用。）
3. [v2ray(SS+v2ray-plugin)+caddy\nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(SS%2Bv2ray-plugin)%2Bcaddy%5Cnginx) （兼容原版shadowsocks加v2ray-plugin插件的WS反代应用。标记为C。）
4. [v2ray(trojan+WS)+caddy\nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(trojan%2BWS)%2Bcaddy%5Cnginx) （trojan+ws+tls反代应用。）
---
1. [v2ray(vless\vmess+h2c)+caddy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(vless%5Cvmess%2Bh2c)%2Bcaddy) （vless+h2c+tls或vmess+h2c+tls反代应用。vless+h2c+tls标记为D。）
2. [v2ray(trojan+h2c)+caddy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(trojan%2Bh2c)%2Bcaddy) （trojan+h2c+tls反代应用。）
---
1. [v2ray(vless\vmess+grpc)+caddy\nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(vless%5Cvmess%2Bgrpc)%2Bcaddy%5Cnginx)（vless+grpc+tls或vmess+grpc+tls反代应用。vless+grpc+tls标记为G。）
2. [v2ray(SS+grpc)+caddy\nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(SS%2Bgrpc)%2Bcaddy%5Cnginx)（兼容原版shadowsocks加v2ray-plugin插件的gRPC反代应用。）
3. [v2ray(trojan+grpc)+caddy\nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(trojan%2Bgrpc)%2Bcaddy%5Cnginx)（trojan+grpc+tls反代应用。）
---
1. [v2ray(vless\trojan+tcp+tls)+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(vless%5Ctrojan%2Btcp%2Btls)%2Bnginx) （vless+tcp+tls/xtls或trojan+tcp+tls/xtls回落nginx应用。分别标记为E与F。）
2. [v2ray(vless\trojan+tcp+tls)+caddy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(vless%5Ctrojan%2Btcp%2Btls)%2Bcaddy) （vless+tcp+tls/xtls或trojan+tcp+tls/xtls回落caddy应用。分别标记为E与F。）

### 服务端综合应用配置示例
#### &emsp;trojan-go或trojan加naiveproxy的综合应用。
1. [trojan-go\trojan+naiveproxy](https://github.com/lxhao61/integrated-examples/tree/main/trojan-go%5Ctrojan%2Bnaiveproxy) （trojan-go或trojan加naiveproxy应用。）
---
1. [caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/caddy(N%2BT)) （基于caddy插件的naiveproxy与trojian-go应用。）
#### &emsp;以Xray或v2ray为主、nginx为辅的综合应用。
1. [v2ray(B+C+G+A)+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(B%2BC%2BG%2BA)%2Bnginx) （反向代理WebSocket、gRPC的综合应用。）
---
1. [v2ray(E+B)+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB)%2Bnginx) （vless+tcp+tls/xtls回落/分流应用。）
2. [v2ray(E+B+C+G+A)+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BC%2BG%2BA)%2Bnginx) （以vless+tcp+tls/xtls为主的综合应用。）
---
1. [v2ray(F+B)+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(F%2BB)%2Bnginx) （trojan+tcp+tls/xtls回落/分流应用。）
2. [v2ray(F+B+C+G+A)+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(F%2BB%2BC%2BG%2BA)%2Bnginx) （以trojan+tcp+tls/xtls为主的综合应用。）
---
1. [v2ray(E+B+C+F+A)+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BC%2BF%2BA)%2Bnginx) （以套娃方式兼顾各应用的综合应用。）
2. [v2ray(E+B+F+C+G+A)+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BF%2BC%2BG%2BA)%2Bnginx) （以nginx SNI兼顾各应用的综合应用）
#### &emsp;以Xray或v2ray为主、caddy为辅的综合应用。
1. [v2ray(B+C+D+G+A)+naiveproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(B%2BC%2BD%2BG%2BA)%2Bnaiveproxy) （反向代理WebSocket、H2C、gRPC加naiveproxy的综合应用。）
2. [v2ray(B+C+D+G+A)+caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(B%2BC%2BD%2BG%2BA)%2Bcaddy(N%2BT)) （反向代理WebSocket、H2C、gRPC加naiveproxy与trojian-go的综合应用。）
---
1. [v2ray(E+B)+naiveproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB)%2Bnaiveproxy)（vless+tcp+tls/xtls回落/分流加naiveproxy应用。）
2. [v2ray(E+B+C+D+G+A)+naiveproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BC%2BD%2BG%2BA)%2Bnaiveproxy) （以vless+tcp+tls/xtls为主加naiveproxy的综合应用。）
3. [v2ray(E+B+C+D+G+A)+caddy(N+T)](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BC%2BD%2BG%2BA)%2Bcaddy(N%2BT)) （以vless+tcp+tls/xtls为主加naiveproxy与trojian-go的综合应用。）
---
1. [v2ray(F+B)+naiveproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(F%2BB)%2Bnaiveproxy)（trojan+tcp+tls/xtls回落/分流加naiveproxy应用。）
2. [v2ray(F+B+C+D+G+A)+naiveproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(F%2BB%2BC%2BD%2BG%2BA)%2Bnaiveproxy) （以trojan+tcp+tls/xtls为主加naiveproxy的综合应用。）
---
1. [v2ray(E+B+C+F+A)+caddy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BC%2BF%2BA)%2Bcaddy) （以套娃方式兼顾各应用的综合应用。）
2. [v2ray(E+B+F+C+D+G+A)+naiveproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BF%2BC%2BD%2BG%2BA)%2Bnaiveproxy) （以caddy SNI兼顾各应用加naiveproxy的综合应用。）
#### &emsp;由nginx或caddy兼顾SNI分流实现Xray或v2ray与trojan-go或trojan的综合应用。
1. [v2ray(E+B+C+G+A)+trojan+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BC%2BG%2BA)%2Btrojan%2Bnginx) （以nginx SNI兼顾trojan-go或trojan的综合应用。）
---
1. [v2ray(E+B+C+D+G+A)+trojan+naiveproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BC%2BD%2BG%2BA)%2Btrojan%2Bnaiveproxy) （以caddy SNI兼顾trojan-go或trojan加naiveproxy的综合应用。）
#### &emsp;用nginx或haproxy的SNI分流实现兼顾各方优势的综合应用。
1. [v2ray(E+B+C+D+G+A)+trojan+naiveproxy+nginx\haproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BC%2BD%2BG%2BA)%2Btrojan%2Bnaiveproxy%2Bnginx%5Chaproxy) （Xray或v2ray与trojan-go或trojan的综合应用。）
---
1. [v2ray(E+B+C+D+G+A)+caddy(N+T)+nginx\haproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BC%2BD%2BG%2BA)%2Bcaddy(N%2BT)%2Bnginx%5Chaproxy) （由caddy提供trojan-go实现的综合应用。）
---
1. [v2ray(E+B+F+C+D+G+A)+naiveproxy+nginx\haproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BF%2BC%2BD%2BG%2BA)%2Bnaiveproxy%2Bnginx%5Chaproxy) （由Xray或v2ray提供trojan实现的综合应用。）
#### &emsp;注意（以上所有示例）:
1. v2ray从v4.33.0版开始删除了XTLS应用，故若还想用XTLS应用，请选Xray。Xray是v2ray的超集（更好的整体性能和XTLS等一系列增强，且完全兼容。），也是因为这个应用分家独自发展。
2. Xray或v2ray单一核心应用简记：A=vless+kcp+seed、B=vless+ws+tls、C=shadowsocks+xray-plugin/v2ray-plugin+tls的WS应用、D=vless+h2c+tls、E=vless+tcp+tls/xtls、F=trojan+tcp+tls/xtls、G=vless+grpc+tls。
3. 所有Xray或v2ray配置文件都配置了禁用BT。如不需要，可以删除相关配置，参考v2ray(other configuration)中BT_config.json文件。
4. caddy插件单一应用简记：N=naiveproxy(caddy+forwardproxy)、T=trojan-go(caddy+caddy-trojan)。
5. 目前caddy采用进程监听不支持HTTP/3，即仅端口监听才支持开启HTTP/3。
6. 受限应用条件及场景，naiveproxy的QUIC应用（即caddy的HTTP/3代理应用）不是所有相关naiveproxy示例都支持。
7. 流量伪装与防探测网站可由其它WEB应用软件实现，其反代支持能力（WebSocket、gRPC及H2C）与回落支持能力（H2C server及HTTP/1.1 server）取决于自身，配置自行参考caddy或nginx对应示例。
8. 附加相关插件的caddy程序文件已编译好，去本人Releases中下载即可。
9. trojan-go安卓客户端可以去本人Releases中下载（最末）。

### 服务端特殊应用配置示例
1. [v2ray(other configuration)](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(other%20configuration)) （Xray或v2ray的特色应用配置方法。）
2. [nginx(other configuration)](https://github.com/lxhao61/integrated-examples/tree/main/nginx(other%20configuration)) （nginx SNI分流应用配置方法。）
3. [caddy(other configuration)](https://github.com/lxhao61/integrated-examples/tree/main/caddy(other%20configuration)) （caddy的特色应用配置方法。）

### 原版客户端配置示例
&emsp;[client configuration](https://github.com/lxhao61/integrated-examples/tree/main/client%20configuration)（若使用第三方客户端参考即可。）

### systemd服务文件
&emsp;[service configuration](https://github.com/lxhao61/integrated-examples/tree/main/service%20configuration)（配置软件服务由systemd管理。）

### 使用/贡献指南
1. 若科学上网相关软件增加新功能，开始在服务端单一应用配置示例中添加；过一段时间（测试及验证稳定后）才会服务端综合应用配置示例中添加。
2. 欢迎你提交 PR，如对现行配置示例优化修订，或将自己使用的配置制作模板提交等。
