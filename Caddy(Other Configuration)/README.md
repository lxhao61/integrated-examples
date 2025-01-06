一、限定从 Let's Encrypt 与 ZeroSSL 申请 TLS 证书的配置方法

此方法可实现不同域名的 TLS 证书由不同 TLS 证书提供商提供、或避开申请免费普通 TLS 证书的域名超过五个问题，配置见 two_caddy.json 示例。

二、以 DNS-01 验证方式申请 TLS 证书的配置方法

Caddy 以 DNS-01 验证方式申请 TLS 证书，必须带对应 DNS API 插件。目前仅提供支持 cloudflare、dnspodcn（dnspod 中国版）、duckdns 三种常见插件配置示例。

注意：

1、以 DNS-01 验证方式才支持通配符 TLS 证书申请。示例为通配符域名的 TLS 证书申请，可通配符域名、普通域名（含根域名）单一或组合申请（证书是各自分开的）。

2、申请免费 TLS 证书的域名不要超过五个，否则影响 TLS 证书的更新。

3、使用 duckdns 插件的挑战委托模式可间接实现无 DNS API 插件的域名管理以 DNS-01 验证方式申请 TLS 证书。

三、caddy-events-exec 插件应用配置方法

以 caddy-events-exec 插件实现 TLS 证书自动更新后就执行重启相关程序来重载更新后的 TLS 证书，配置见 events-exec_caddy.json 或 events-exec_Caddyfile 示例。

四、使用外部 TLS 证书的配置方法

Caddy 使用非自己内置 ACME 客户端提供的 TLS 证书时，其配置见 outside_caddy.json 或 outside_Caddyfile 示例。

五、转发或回落到不同网站配置方法

此方法可解决 Xray 前置监听 443 后不影响先前 Caddy 前置时不同域名访问不同网站问题，配置见 shunt_caddy.json 示例。

注意：

1、若回落应用中不同域名没有使用通配符证书，那么还需要在 Xray 中并列配置多个域名对应的证书及密钥。

2、也可以用 Caddy SNI、Nginx SNI 等分流来解决问题（不同方法，达到相同效果。），相关分流见各自配置示例。

六、反向代理到 HTTP/2 或 HTTPS 网站配置方法

此配置实现 Caddy 不必启用 WEB 服务，流量伪装与防探测网站由国外 HTTP/2 或 HTTPS 网站提供。配置见 proxyweb_caddy.json 或 proxyweb_Caddyfile 示例。

七、网盘应用配置方法

以 caddy-webdav 插件及文件服务应用打造不同的网盘应用（服务端），配置见 webdav_caddy.json 或 webdav_Caddyfile 示例。

八、DDNS 客户端配置方法

Caddy 使用 caddy-dynamicdns 插件及对应的 caddy-dns 插件实现对应的 DDNS 客户端应用。基本配置见 ddns_caddy.json 或 ddns_Caddyfile 示例，详细配置见 caddy-dynamicdns 资源。
