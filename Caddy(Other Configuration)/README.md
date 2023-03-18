一、回落后由 Caddy 分流到不同网站的配置方法

此方法解决 Xray 或 V2Ray 前置监听 443 后不影响先前 Caddy 前置时不同域名访问不同网站问题，配置见 shunt_caddy.json 或 shunt_Caddyfile 示例。

注意：

1、若不同域名没有使用通配符证书，那么还需要在 Xray 或 V2Ray 中并列配置多个域名对应的证书及密钥。

2、此回落到不同网站是回落后由 Caddy 进行的 host（域名）分流。

3、也可以用 Caddy SNI、Nginx SNI、HAProxy SNI、Xray fallbacks SNI 等分流来解决问题（不同方法，达到相同效果。），相关分流见各自配置示例。

二、Caddy 以 DNS-01 验证方式申请 TLS 证书的配置方法

Caddy 以 DNS-01 验证方式申请 TLS 证书，必须带对应 DNS API 插件。目前仅提供支持 cloudflare、dnspodcn（dnspod中国版）、duckdns 三种常见插件配置示例。

注意：

1、以 DNS-01 验证方式才支持通配符 TLS 证书申请。示例为通配符域名的 TLS 证书申请，可通配符域名、普通域名（含根域名）单一或组合申请（证书是各自分开的）。

2、申请免费 TLS 证书的域名不要超过五个，否则影响 TLS 证书的更新。

3、使用 duckdns 插件的挑战委托模式可间接实现无 DNS API 插件的域名管理以 DNS-01 验证方式申请 TLS 证书。

4、挑战委托模式最早由 duckdns 插件专属支持，后 Caddy 通用支持了（目前 Caddyfile 支持不完全）。其它插件不推荐配置此应用：A、其它插件使用此模式需要两个根域名；其中一个域名仅用它二级域名来中间关联，极大浪费。 B、目前其它插件 Caddyfile 配置挑战委托模式很不方便，无对应全局配置参数。

5、Cloudflare 已不支持后缀为 tk、ml、cf、ga、gq 的免费域名以 DNS-01 验证方式申请 TLS 证书了。可以参考上 duckdns 插件的挑战委托模式间接实现以 DNS-01 验证方式申请 TLS 证书。

三、caddy-events-exec 插件应用配置方法

以 caddy-events-exec 插件实现 TLS 证书自动更新后就执行重启相关程序来重载更新后的 TLS 证书，配置见 events-exec_caddy.json 或 events-exec_Caddyfile 示例。

四、Caddy 使用外部 TLS 证书的配置方法

Caddy 使用非自己内置 ACME 客户端提供的 TLS 证书时，其配置见 outside_caddy.json 或 outside_Caddyfile 示例。

五、Caddy 网盘应用配置方法

以 caddy-webdav 插件及文件服务应用打造不同的网盘应用（服务端），配置见 webdav_caddy.json 或 webdav_Caddyfile 示例。

六、Caddy DDNS 客户端配置方法

Caddy 使用 caddy-dynamicdns 插件及对应的 caddy-dns 插件实现对应的 DDNS 客户端应用。基本配置见 DDNS_caddy.json 或 DDNS_Caddyfile 示例，详细配置见 caddy-dynamicdns 资源。
