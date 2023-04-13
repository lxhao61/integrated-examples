introduce:

Hysteria is a feature-rich network tool (bilateral acceleration) optimized for harsh network environments. Based on a modified version of the QUIC protocol, it can implement SOCKS5 proxy (TCP & UDP), HTTP/HTTPS proxy, TCP/UDP forwarding, TCP /UDP TPROXY Transparent proxy (Linux), TUN (TAP under Windows) applications.

Notice:

1. Hysteria (built-in ACME client) currently only supports HTTP-01 and TLS-ALPN-01 verification methods to apply for and update TLS certificates, and does not support DNS-01 verification methods to apply for and update TLS certificates (that is, it does not support wildcard TLS certificate applications) . For the HTTP-01 or TLS-ALPN-01 verification method to apply for and update the TLS certificate, please ensure that port 80 or port 443 is not occupied by other applications.

2. The example of acme_config.json means to use the built-in ACME client to automatically apply for and renew the TLS certificate for the server from Let's Encrypt (recommended for independent use), and the example of outside_config.json means to use the external TLS certificate (it is recommended to add this application after the existing scientific online application ); choose one of the two examples according to the actual situation.

3. Hysteria does not support the "Certificate Hot Update" function when using an external TLS certificate, that is, Hysteria will not automatically recognize the TLS certificate update and reload the TLS certificate. You can use one of the following methods to solve it.

1) Linux-like systems use the Crontab command to periodically restart Hysteria to reload the updated TLS certificate, and other systems use similar commands/tools to periodically restart Hysteria to reload the updated TLS certificate. (General method)

2) If the TLS certificate is provided by Caddy (the built-in ACME client), you can use the caddy-events-exec plug-in application to realize the automatic update of the TLS certificate, and then restart Hysteria to reload the updated TLS certificate. For details, see 'Caddy(Other Configuration) (Caddy's special application configuration method.)' in the corresponding introduction and corresponding configuration examples. (Caddy exclusive method)

3) If the TLS certificate is provided by the acme.sh client, you can use the reloadcmd parameter to automatically update the TLS certificate and then restart Hysteria to reload the updated TLS certificate. See the acme.sh client instructions for details. (acme.sh exclusive method)

4. If the network is extremely poor, it is recommended to deploy. Compared with Xray or V2Ray's mKCP application, the acceleration is obvious.

5. If you want to use Hysteria for high-speed transmission, please [increase the receiving and sending buffer size of the system UDP](https://hysteria.network/zh/docs/optimizations/).
