一、Xray\v2ray 禁用 BT 的配置方法

注意：

1、仅服务端配置即可。

2、本人 github 中的所有配置示例都已配置了禁用 BT，此配置方法仅备份及参考等。

二、Xray fallbacks SNI shunt 回落到不同网站的配置方法

此方法解决 Xray 前置监听443后，不影响原来不同域名访问不同网站问题。

注意：

1、Xray v1.2.2 版本及以后才支持 VLESS fallbacks SNI shunt。Xray v1.2.3 版本及以后才支持 Trojan fallbacks SNI shunt。

2、若不同域名没有使用通配符证书，那么还需要在 Xray 中并列配置多个域名对应的证书及私钥。

3、此 fallbacks SNI 回落是解除 tls 后 Xray 进行的 name（域名）分流。

4、也可以用 nginx SNI、haproxy SNI 及 caddy（SNI及host分流）等分流来解决问题（不同方法，达到相同效果。）。相关 SNI 分流见各自相关示例。

三、Xray\v2ray SNI 分流的配置方法

此方法也可以解决 Xray\v2ray 应用与网站应用（原网站不想做回落网站，或 nginx\caddy 等有多个网站应用。）共用443端口问题。

注意：

1、Xray\v2ray SNI 分流不支持 PROXY protocol（发送）。

2、1_SNI_config.json 分流采用 local loopback 应用（redirect），实现转发端口（域名）的分流，简称 v2ray SNI 的端口分流。此端口分流效率稍低，可适用全部服务器。

3、2_SNI_config.json 分流采用 Unix Domain Socket 应用，实现转发进程（域名）的分流，简称 v2ray SNI 的进程分流。此进程分流效率高，但在 Windows 10 Build 17036 前不可用。

4、本人 github 中 v2ray（Xray） SNI 分流配置示例已被其它 SNI 分流配置示例优势替代 ，此配置方法仅备份及参考等。

四、v2ray 流量统计的配置方法

1、流量统计介绍

开启流量统计需消耗服务器资源，严重时可能影响速度。非必要不必配置，且此流量统计，不支持重启及修改配置后保持之前流量统计记录。

2、此配置可以统计情况

1）、入站的统计（不推荐，一般建议关闭。），根据 tag 来统计入站流量。

2）、用户的统计（推荐），依据 email 区分及统计用户流量。socks, http 等其他协议内的用户不支持被统计。

3、流量信息的处理

1）、把 traffic.sh 脚本上传到服务器 root 目录，并授予执行权限（chmod +x traffic.sh）。

2）、执行 ./traffic.sh 即可查看流量统计。
