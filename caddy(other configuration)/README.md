一、回落 caddy 分流到不同网站的配置方法

此方法解决 Xray\v2ray 前置监听443后，不影响原来 caddy 前置时，不同域名访问不同网站问题。

注意：

1、若不同域名没有使用通配符证书，那么还需要在 Xray\v2ray 中并列配置多个域名对应的证书及私钥。

2、此回落到不同网站是 Xray\v2ray 解除 tls 后 caddy 进行的 host（域名）分流。

3、caddy json 配置才支持此应用， Caddyfile 配置不支持。因 Caddyfile 配置参数是简化的，非完整的。

4、也可以用 caddy SNI 或 haproxy SNI 等分流来解决问题（不同方法，达到相同效果。）。caddy SNI 配置示例见如下介绍。haproxy SNI 配置示例参考示例中用 haproxy SNI 分流的 haproxy 配置。

二、caddy SNI 分流的配置方法

此方法也可以解决 Xray\v2ray 应用与网站应用（原网站不想做回落网站，或 nginx\caddy 等有多个网站应用。）共用443端口问题。

注意：

1、caddy 加 caddy-l4 插件定制编译的才可以实现 SNI 分流，目前仅支持使用 json 配置。

2、采用改进的 caddy-l4 插件定制编译的才同时支持 PROXY protocol（发送），且可以对分流的进程或端口分别开启 PROXY protocol（发送）。

3、1_SNI_caddy.json 分流采用 local loopback 应用（redirect），实现转发端口（域名）的分流，简称 caddy SNI 的端口分流。此端口分流效率稍低，可适用全部服务器。

4、2_SNI_caddy.json 分流采用 Unix Domain Socket 应用，实现转发进程（域名）的分流，简称 caddy SNI 的进程分流。此进程分流效率高，但在 Windows 10 Build 17036 前不可用。

5、本人 github 中的相关配置示例已配置 caddy SNI 分流共用端口 ，此配置方法仅备份及参考等。

三、caddy 以 DNS API 方式申请证书与私钥

1、dnspod、cloudflare、dnspodcn 以 DNS API 方式申请证书与私钥，可以申请普通证书，也可以申请通配符证书。

2、Xray\v2ray 可以直接使用 caddy 以 DNS API 方式申请的证书与私钥，配合 Xray 服务端（版本必须不低于 v1.3.0）更新 OCSP 数据前自动检查并重载证书与私钥，可实现 Xray 服务端证书与私钥的申请及更新自动化；否则 Xray\v2ray 服务端（Xray 版本低于 v1.3.0）不支持自动热重载证书，caddy 证书到期更新后需手动重启 Xray\v2ray 来重新加载更新的证书。

注意：

1、dnspod 分 dnspod.com（国际版）与 dnspod.cn（中国版），故两者插件不通用，必须对应各自 dnspod 域名解析使用。

2、cloudflare 已不支持 freenom 的免费域名以 DNS API 方式申请证书与私钥了。

3、acme申请证书与私钥路径，通配符证书与私钥在/home/tls/certificates/acme-v02.api.letsencrypt.org-directory/wildcard_.xx.yy目录中,普通证书与私钥在/home/tls/certificates/acme-v02.api.letsencrypt.org-directory/xx.yy目录中。zerossl申请证书与私钥路径，与acme申请证书与私钥路径类似。

4、推荐采用 json 配置，否则采用 Caddyfile 配置必须启用额外无用端口来联动实现自动申请及更新证书与私钥。另外采用 Caddyfile 配置 DNS API 方式申请证书与私钥仅支持端口监听模式。
