一、V2Ray 或 Xray 各应用配置多用户方法

在各应用中 "settings" 项目内增加用户，具体见 multi_config.json 配置示例。

二、V2Ray 或 Xray 流量统计的配置方法

1、配置流量统计（见 traffic_config.json 配置）

1）、入站的流量统计（不推荐，一般建议关闭。），根据各个入站 tag 来记录。

2）、出站的流量统计（不推荐，一般建议关闭。），根据各个出站 tag 来记录。

3）、用户的流量统计（推荐），根据 email 来记录。SOCKS、HTTP 等其他协议内的用户不支持被统计。

2、流量统计处理

1）、把对应 traffic.sh（v2ray_traffic.sh 或 xray_traffic.sh） 脚本上传到服务器 root 目录，并授予执行权限（chmod +x traffic.sh）。

2）、执行 ./traffic.sh 即可查看流量统计。

注意：

1、开启流量统计需消耗服务器资源，严重时可能影响速度，非必要不需要配置。

2、采用 traffic.sh 脚本进行流量统计简单好用，但不支持重启及配置修改后保持之前记录，即重启及配置修改后记录归零。

三、V2Ray 或 Xray 禁用 BT 的配置方法

见 BT_config.json 配置示例。

注意：

1、仅服务端配置即可。

2、V2Ray 或 Xray 示例中各应用都配置了禁用 BT，此配置方法仅备份及参考。

四、V2Ray SNI 或 Xray SNI 分流的配置方法

此方法也可以解决 V2Ray 或 Xray 应用与网站应用（原网站不想做回落网站，或 Nginx、Caddy 等有多个网站应用。）共用 443 端口问题。

注意：

1、V2Ray SNI 或 Xray SNI 分流不支持 PROXY protocol 发送。

2、1_SNI_config.json 采用 Local Loopback 连接，实现 V2Ray SNI 或 Xray SNI 的端口分流。

3、2_SNI_config.json 采用 UDS 连接，实现 V2Ray SNI 或 Xray SNI 的进程分流。

4、原 V2Ray SNI 或 Xray SNI 分流已被其它 SNI 分流优势替代，其配置示例仅备份及参考等。
