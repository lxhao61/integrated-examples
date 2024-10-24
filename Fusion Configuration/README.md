介绍：

本示例为服务端综合应用及 Hysteria 应用的融合配置，可实现 NaiveProxy、Trojan-Go(caddy-trojan 插件) 及 Hysteria 应用的出站流量由 V2Ray/Xray 统一处理，同时解决服务端 NaiveProxy、Trojan-Go(caddy-trojan 插件) 应用无法使用定制 DNS 解析、无法使用规则来分流等问题。

注意：

1、服务端系统默认 DNS 出错、外出端口被限制等问题推荐参考本示例。

2、服务端 NaiveProxy、Trojan-Go(caddy-trojan 插件) 应用需使用规则来分流推荐参考本示例。 

3、服务端所有应用的出站流量统一管理推荐参考本示例。
