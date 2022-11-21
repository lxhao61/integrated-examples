一、回落后由 Caddy 分流到不同网站的配置方法

此方法解决 Xray 或 V2Ray 前置监听 443 后不影响先前 Caddy 前置时不同域名访问不同网站问题，配置见 shunt_caddy.json 或 shunt_Caddyfile 示例。

注意：

1、若不同域名没有使用通配符证书，那么还需要在 Xray 或 V2Ray 中并列配置多个域名对应的证书及密钥。

2、此回落到不同网站是回落后由 Caddy 进行的 host（域名）分流。

3、也可以用 Caddy SNI、Nginx SNI、HAProxy SNI、Xray fallbacks SNI 等分流来解决问题（不同方法，达到相同效果。），相关分流见各自配置示例。

二、Caddy 以 DNS-01 验证方式申请 TLS 证书的配置方法

提供了 cloudflare、dnspodcn（dnspod中国版插件）、duckdns 三种最常见插件配置示例，其它插件配置请参考官方资料及 cloudflare 或 duckdns 配置示例。

注意：

1、以 DNS-01 验证方式才支持通配符 TLS 证书申请。示例为通配符域名的 TLS 证书申请，可通配符域名、普通域名（含根域名）单一或组合申请（证书是各自分开的）。

2、申请免费 TLS 证书的域名不要超过五个，否则影响 TLS 证书的更新。

3、Caddy 以 DNS-01 验证方式申请 TLS 证书，必须带对应 DNS API 插件。dnspod 解析分 dnspod.com（国际版）与 dnspod.cn（中国版），故两者插件不通用，必须对应各自 dnspod 解析使用。

4、Cloudflare 已不支持 Freenom 提供的免费域名以 DNS-01 验证方式申请 TLS 证书了。可以参考 duckdns 配置示例间接（挑战委托模式）实现 Cloudflare 解析的 Freenom 免费域名以 DNS-01 验证方式申请 TLS 证书。

5、挑战委托模式最早由 duckdns 插件专属支持，后 Caddy 通用支持了（目前 Caddyfile 支持不完全）。其它插件不推荐配置此应用：A、其它插件使用此模式需要两个根域名；其中一个域名仅用它二级域名来中间关联，极大浪费。 B、目前其它插件 Caddyfile 配置挑战委托模式很不方便，无对应全局配置参数。

三、caddy-events-exec 插件应用配置方法

以 caddy-events-exec 插件实现 TLS 证书自动更新后就执行重启相关程序重载更新后的 TLS 证书（类似 acme.sh 的 reloadcmd 参数应用），配置见 events-exec_caddy.json 或 events-exec_Caddyfile 示例。

四、使用外部 TLS 证书对应 Caddy 的配置方法

使用外部 TLS 证书对应 Caddy 的配置方法，配置见 outside_caddy.json 或 outside_Caddyfile 示例。

五、Caddy 网盘应用配置方法

以 WebDAV 插件及文件服务应用打造不同的网盘应用（服务端），配置见 webdav_caddy.json 或 webdav_Caddyfile 示例。

六、Caddy DDNS 客户端配置方法

Caddy 使用 caddy-dynamicdns 插件及对应 caddy-dns 插件实现 DDNS 客户端应用。基本配置见 DDNS_caddy.json 或 DDNS_Caddyfile 示例，详细配置见 caddy-dynamicdns 资源。
