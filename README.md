**这里是搭建主流科学上网的优化配置及最优组合示例。如是不太了解科学上网，建议先依次从简单到复杂参考及部署。**  
1. 实现了SNI分流应用的端口分流到进程分流及启用PROXY protocol的从低到高（效率）应用支持。
2. 实现了回落应用的端口回落\分流到进程回落\分流及启用PROXY protocol的从低到高（效率）应用支持。
3. 实现了反代应用的端口转发到进程转发的从低到高（效率）应用支持。
4. 实现了除v2ray(vless\vmess+kcp+seed)示例及应用外，其它示例及应用都支持流量伪装与防探测，且提供流量伪装的回落或反代网站都支持http自动跳转到https，SSL/TLS安全评估报告为A+等，与访问（探测）真实网站完全一致。
5. 实现了nginx SNI分流（TCP转发）与定向UDP转发，以支持SNI分流后的naiveproxy http/3代理应用。
6. 实现了caddy Caddyfile配置开启h2c server、PROXY protocol、naiveproxy等应用支持，让caddy配置简单化。
7. 实现了caddy json配置SNI分流应用，且同时支持端口或进程分别PROXY protocol发送，灵活性等同haproxy SNI分流。
8. 实现了Xray与caddy相关应用的证书及密钥申请与更新全自动化。
9. 实现了CDN应用（caddy反向代理gRPC应用除外）与正常应用共存。
10. 实现了caddy Caddyfile配置与caddy json配置几乎完全等同，功效一致。
* **备注：** 端口分流、端口回落\分流、端口转发是指基于local loopback实现的不同方式；进程分流、进程回落\分流、进程转发是指基于Unix Domain Socket实现的不同方式。

### 服务端单一应用配置示例
1. [trojan-go\trojan+caddy](https://github.com/lxhao61/integrated-examples/tree/main/trojan-go%5Ctrojan%2Bcaddy) （trojan-go或trojan应用，web回落给caddy。）
2. [trojan-go\trojan+nginx](https://github.com/lxhao61/integrated-examples/tree/main/trojan-go%5Ctrojan%2Bnginx) （trojan-go或trojan应用，web回落给nginx。）
---
1. [naiveproxy(caddy+forwardproxy)](https://github.com/lxhao61/integrated-examples/tree/main/naiveproxy(caddy%2Bforwardproxy)) （naiveproxy应用，基于http/2或http/3代理。）
---
1. [v2ray(vless\vmess+kcp+seed)](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(vless%5Cvmess%2Bkcp%2Bseed)) （vless+kcp+seed与vmess+kcp+seed应用。vless+kcp+seed标记为A。）
---
1. [v2ray(vless\vmess+WS)+caddy\nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(vless%5Cvmess%2BWS)%2Bcaddy%5Cnginx) （vless+ws+tls与vmess+ws+tls反代应用。vless+ws+tls标记为B。）
2. [v2ray(socks\SS+WS)+caddy\nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(socks%5CSS%2BWS)%2Bcaddy%5Cnginx) （socks+ws+tls与shadowsocks+ws+tls反代应用。）
3. [v2ray(SS+v2ray-plugin)+caddy\nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(SS%2Bv2ray-plugin)%2Bcaddy%5Cnginx) （shadowsocks+v2ray-plugin+tls反代应用。标记为C。）
4. [v2ray(trojan+WS)+caddy\nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(trojan%2BWS)%2Bcaddy%5Cnginx) （trojan+ws+tls反代应用。）
---
1. [v2ray(vless\vmess+h2c)+caddy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(vless%5Cvmess%2Bh2c)%2Bcaddy) （vless+h2c+tls与vmess+h2c+tls反代应用。vless+h2c+tls标记为D。）
---
1. [v2ray(vless\trojan+tcp+tls)+caddy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(vless%5Ctrojan%2Btcp%2Btls)%2Bcaddy) （vless+tcp+tls与trojan+tcp+tls回落应用。分别标记为E与F。）
2. [v2ray(vless\trojan+tcp+tls)+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(vless%5Ctrojan%2Btcp%2Btls)%2Bnginx) （vless+tcp+tls与trojan+tcp+tls回落应用。分别标记为E与F。）
---
1. [v2ray(vless\vmess+grpc)+caddy\nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(vless%5Cvmess%2Bgrpc)%2Bcaddy%5Cnginx)（vless+grpc+tls与vmess+grpc+tls反代应用。vless+grpc+tls标记为G。）

### 服务端综合应用配置示例
#### &emsp;以trojan-go或trojan为主、caddy(naiveproxy)为辅的综合应用。
1. [trojan-go\trojan+naiveproxy](https://github.com/lxhao61/integrated-examples/tree/main/trojan-go%5Ctrojan%2Bnaiveproxy) （trojan-go或trojan加naiveproxy的应用。）
#### &emsp;以Xray或v2ray为主、nginx为辅的综合应用。
1. [v2ray(B+C+A)+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(B%2BC%2BA)%2Bnginx) （反向代理WebSocket的综合应用。）
2. [v2ray(B+C+G+A)+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(B%2BC%2BG%2BA)%2Bnginx) （以nginx SNI兼顾反向代理WebSocket与gRPC的综合应用。）
---
1. [v2ray(E+B)+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB)%2Bnginx) （vless+tcp+tls回落\分流简单应用。）
2. [v2ray(E+B+C+G+A)+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BC%2BG%2BA)%2Bnginx) （以vless+tcp+tls为主的综合应用。）
---
1. [v2ray(F+B)+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(F%2BB)%2Bnginx) （trojan+tcp+tls回落\分流简单应用。）
2. [v2ray(F+B+C+G+A)+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(F%2BB%2BC%2BG%2BA)%2Bnginx) （以trojan+tcp+tls为主的综合应用。）
---
1. [v2ray(E+B+C+F+A)+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BC%2BF%2BA)%2Bnginx) （以套娃方式兼顾vless\trojan+tcp+tls的综合应用。）
2. [v2ray(E+B+F+C+G+A)+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BF%2BC%2BG%2BA)%2Bnginx) （以nginx SNI兼顾vless\trojan+tcp+tls的综合应用）
#### &emsp;以Xray或v2ray为主、caddy(naiveproxy)为辅的综合应用。
1. [v2ray(B+C+D+G+A)+naiveproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(B%2BC%2BD%2BG%2BA)%2Bnaiveproxy) （反向代理WebSocket、h2c、gRPC加naiveproxy的综合应用。）
---
1. [v2ray(E+B)+naiveproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB)%2Bnaiveproxy)（vless+tcp+tls回落\分流简单应用加naiveproxy应用。）
2. [v2ray(E+B+C+D+G+A)+naiveproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BC%2BD%2BG%2BA)%2Bnaiveproxy) （以vless+tcp+tls为主加naiveproxy的综合应用。）
---
1. [v2ray(F+B)+naiveproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(F%2BB)%2Bnaiveproxy)（trojan+tcp+tls回落\分流简单应用加naiveproxy应用。）
2. [v2ray(F+B+C+D+G+A)+naiveproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(F%2BB%2BC%2BD%2BG%2BA)%2Bnaiveproxy) （以trojan+tcp+tls为主加naiveproxy的综合应用。）
---
1. [v2ray(E+B+C+F+A)+caddy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BC%2BF%2BA)%2Bcaddy) （以套娃方式兼顾vless\trojan+tcp+tls的综合应用。）
2. [v2ray(E+B+F+C+D+G+A)+naiveproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BF%2BC%2BD%2BG%2BA)%2Bnaiveproxy) （以caddy SNI兼顾vless\trojan+tcp+tls为主加naiveproxy的综合应用。）
#### &emsp;trojan-go或trojan与Xray或v2ray的综合应用。
1. [v2ray(E+B+C+G+A)+trojan+nginx](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BC%2BG%2BA)%2Btrojan%2Bnginx) （以nginx SNI兼顾vless+tcp+tls为主加trojan的应用。）
---
1. [v2ray(E+B+C+D+G+A)+trojan+naiveproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BC%2BD%2BG%2BA)%2Btrojan%2Bnaiveproxy) （以caddy SNI兼顾vless+tcp+tls为主加trojan加naiveproxy的应用。）
#### &emsp;兼顾各自优势的综合应用。
1. [v2ray(E+B+C+D+G+A)+trojan+naiveproxy+nginx\haproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BC%2BD%2BG%2BA)%2Btrojan%2Bnaiveproxy%2Bnginx%5Chaproxy) （用nginx或haproxy SNI分流，平衡兼顾各应用。）
---
1. [v2ray(E+B+F+C+D+G+A)+naiveproxy+nginx\haproxy](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(E%2BB%2BF%2BC%2BD%2BG%2BA)%2Bnaiveproxy%2Bnginx%5Chaproxy) （用nginx或haproxy SNI分流，平衡兼顾各应用。）
#### &emsp;以上所有实例注意:
1. 所有Xray或v2ray配置文件都配置了禁用BT。如不需要，可以删除相关配置，参考v2ray(other configuration)中BT_config.json文件。
2. v2ray从版本v4.33.0删除了xtls应用，故若还想用xtls应用，请选Xray。Xray是v2ray的超集（更好的整体性能和xtls等一系列增强，且完全兼容。），也是因为这个应用分家独自发展。
3. Xray或v2ray单一核心应用简记：A=vless+kcp+seed、B=vless+ws+tls、C=SS+v2ray-plugin+tls、D=vless+h2c+tls、E=vless+tcp+tls、F=trojan+tcp+tls、G=vless+grpc+tls。
4. WebSocket（WS）类应用与gRPC应用都支持CDN应用（caddy反向代理gRPC应用除外）。
5. naiveproxy=caddy+forwardproxy（服务端）。此程序文件已编译好，本人github下载即可。
6. 目前caddy的https服务进程监听采用Unix Domain Socket应用不支持http/3；若开启http/3，caddy无法启动。

### 服务端特殊应用配置示例
1. [v2ray(other configuration)](https://github.com/lxhao61/integrated-examples/tree/main/v2ray(other%20configuration)) （Xray或v2ray的特殊应用配置方法。）
2. [caddy(other configuration)](https://github.com/lxhao61/integrated-examples/tree/main/caddy(other%20configuration)) （caddy的特殊应用配置方法。）
3. [nginx(other configuration)](https://github.com/lxhao61/integrated-examples/tree/main/nginx(other%20configuration)) （nginx SNI分流应用配置方法。）

### 官方客户端配置示例
&emsp;[client configuration](https://github.com/lxhao61/integrated-examples/tree/main/client%20configuration)（若使用第三方客户端参考即可。）

### systemd服务文件
&emsp;[service configuration](https://github.com/lxhao61/integrated-examples/tree/main/service%20configuration)（配置软件服务由systemd管理。）

### 使用/贡献指南
1. 若科学上网相关软件增加新功能，开始在服务端单一应用配置示例中添加；过一段时间稳定后才会服务端综合应用配置示例中添加。如除trojan+tcp套娃外，vless+tcp+tls及trojan+tcp+tls的xtls已全部加上。 
2. 欢迎你提交 PR，如对现行配置示例优化修订，或将自己使用的配置制作模板提交等。
