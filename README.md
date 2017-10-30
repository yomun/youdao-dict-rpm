# youdao-dict-rpm
RPM 版有道词典<br>
1) 准备 youdao-dict 文件来代替原文件 /usr/bin/youdao-dict (系统连接文件)<br>
$ wget https://github.com/yomun/youdao-dict-rpm/raw/master/youdao-dict<br><br>
2) 编写 SPEC 文件 模板<br>
$ wget https://github.com/yomun/youdao-dict-rpm/raw/master/youdao-dict.temp.spec<br><br>
3) 在 Ubuntu 安装 rpm (需要 rpmbuild)<br>
$ sudo apt install rpm<br><br>
4) 下载整理源码后, 运行 rpmbuild, 生成 rpm 文件<br>
$ wget https://github.com/yomun/youdao-dict-rpm/raw/master/build.sh<br>
$ bash build.sh<br><br>
5) 在其它 Linux 分发版(如 Fedora) 安装 rpm<br>
$ sudo rpm -i youdao-dict-1.1.1-0.x86_64.rpm<br><br>
6) 缺依赖软件包, 可以看<br>
https://github.com/yomun/youdaodict_5.5
