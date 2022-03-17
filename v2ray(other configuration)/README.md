一、Xray 或 v2ray 禁用 BT 的配置方法

注意：

1、仅服务端配置即可。

2、本人 github 中的所有配置示例都已配置了禁用 BT，此配置方法仅备份及参考等。

二、Xray fallbacks SNI shunt 回落到不同网站的配置方法

此方法解决 Xray 前置监听443后，不影响原来不同域名访问不同网站问题。

注意：

1、Xray 版本不小于 v1.2.2 才支持 VLESS fallbacks SNI shunt。Xray 版本不小于 v1.2.3 才支持 Trojan fallbacks SNI shunt。

2、若不同域名没有使用通配符证书，那么还需要在 Xray 中并列配置多个域名对应的证书及私钥。

3、此 fallbacks SNI 回落是解除 TLS 后 Xray 进行的 name（域名）分流。

4、也可以用 nginx SNI、haproxy SNI、caddy 分流（SNI或host分流） 等分流来解决问题（不同方法，达到相同效果。），相关分流见各自配置示例。

三、Xray 或 v2ray SNI 分流的配置方法

此方法也可以解决 Xray 或 v2ray 应用与网站应用（原网站不想做回落网站，或 nginx、caddy 等有多个网站应用。）共用 443 端口问题。

注意：

1、Xray 或 v2ray SNI 分流不支持 PROXY protocol 发送。

2、1_SNI_config.json 分流采用 Local Loopback 连接，实现转发端口（域名）的分流，简称 v2ray SNI 的端口分流。端口分流配置虽然效率稍低，但可适用任意系统服务器。

3、2_SNI_config.json 分流采用 Unix Domain Socket 连接，实现转发进程（域名）的分流，简称 v2ray SNI 的进程分流。进程分流配置效率高，但在 Windows 10 Build 17036 之前版本不可用。

4、原 Xray 或 v2ray SNI 分流示例已被其它 SNI 分流示例优势替代，此配置仅备份及参考等。

四、Xray 或 v2ray 流量统计的配置方法

1、配置流量统计（见traffic_config.json配置）

1）、入站的流量统计（不推荐，一般建议关闭。），根据各个入站 tag 来记录。

2）、出站的流量统计（不推荐，一般建议关闭。），根据各个出站 tag 来记录。

3）、用户的流量统计（推荐），根据 email 来记录。SOCKS、HTTP 等其他协议内的用户不支持被统计。

2、流量统计处理

1）、把 traffic.sh（Xray_traffic.sh或v2ray_traffic.sh） 脚本上传到服务器 root 目录，并授予执行权限（chmod +x traffic.sh）。

2）、执行 ./traffic.sh 即可查看流量统计。

注意：

1、开启流量统计需消耗服务器资源，严重时可能影响速度，非必要不需要配置。

2、采用 traffic.sh 脚本进行流量统计处理简单好用，但不支持重启及配置修改后保持之前记录，即重启及配置修改后记录归零。
