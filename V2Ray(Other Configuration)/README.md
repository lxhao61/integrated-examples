一、各应用多用户的配置方法

具体参考 multi_config.json 配置示例。

二、使用内置 DNS 服务器的配置方法

具体参考 dns_config.json 配置示例。使用定制 DNS 解析，可解决服务器的系统默认 DNS 出错、外出端口被限制等问题。

三、屏蔽回中国流量的配置方法

具体参考 cn_config 配置示例。

四、删除屏蔽 BT 流量的配置方法

具体参考 bt_config.json 配置示例。

五、流量统计的配置方法

1、配置流量统计（见 traffic_config.json 配置）

1）、入站的流量统计（不推荐，一般建议关闭。），根据各个入站 tag 来记录。

2）、出站的流量统计（不推荐，一般建议关闭。），根据各个出站 tag 来记录。

3）、用户的流量统计（推荐），根据 email 来记录。Socks、HTTP 等其他协议内的用户不支持被统计。

2、流量统计处理

1）、把对应 traffic.sh（v2ray_traffic.sh 或 xray_traffic.sh） 脚本上传到服务器 root 目录，并授予执行权限（chmod +x traffic.sh）。

2）、执行 ./traffic.sh 即可查看流量统计。

注意：

1、开启流量统计需消耗服务器资源，严重时可能影响速度，非必要不需要配置。

2、采用 traffic.sh 脚本进行流量统计简单好用，但不支持重启及配置修改后保持之前记录，即重启及配置修改后记录归零。

六、V2Ray/Xray 的 SNI 分流共用 TCP 443 端口配置方法

此方法也可解决 V2Ray 或 Xray 应用与网站应用（原网站不想做回落网站，或 Nginx、Caddy 等有多个网站应用。）共用 TCP 443 端口问题。

注意：

1、V2Ray/Xray 的 SNI 分流共用 TCP 443 端口配置不支持 PROXY protocol 发送。

2、1_sni_config.json 采用 Local Loopback 连接，实现 SNI 分流共用 TCP 443 端口配置的端口转发。

3、2_sni_config.json 采用 UDS 连接，实现 SNI 分流共用 TCP 443 端口配置的进程转发。

4、V2Ray/Xray 的 SNI 分流共用 TCP 443 端口配置已被其它 SNI 分流共用 TCP 443 端口配置优势替代，其配置示例仅备份及参考等。
