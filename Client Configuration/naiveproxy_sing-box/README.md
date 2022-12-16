**介绍：**

本目录中配置文件利用 [sing-box](https://github.com/SagerNet/sing-box) 路由分流 + [naiveproxy](https://github.com/klzgrad/naiveproxy) 实现科学上网。

使用时需要同时启动 sing-box 与 naiveproxy。

相比 v2ray + naiveproxy，本配置有如下优势
* sing-box 带来更高的性能和更低的占用；
* 原生支持 [UDP over TCP](https://github.com/SagerNet/UoT)【服务端需使用 [SagerNet/forwardproxy](https://github.com/SagerNet/forwardproxy) 插件】，使 naiveproxy 可以传输 UDP 数据报；
* [自动配置系统代理](https://sing-box.sagernet.org/configuration/inbound/mixed/#set_system_proxy)（支持 Linux, Android, Windows, macOS），同端口开启 HTTP/SOCKS 入站。
 