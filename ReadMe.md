# 折腾了一段时间的manjaro，简单记录一下配置文件

# 一些配置
1. https://github.com/LukeSmithxyz/voidrice
1. https://github.com/theniceboy/.config
1. https://github.com/Martins3/My-Linux-config
1. https://github.com/Pipapa/dotfiles
1. https://github.com/liaoishere/dotfiles.git
1. https://github.com/AshNobita/i3andpolybarconfig.git
1. https://github.com/wall-shen/arch-config.git

# 一些教程
1. https://www.cnblogs.com/huanhao/p/archlinuxsystem.html

# 使用踩坑记录
---

# 配置源
## 简单
sudo pacman-mirrors -i -c China -m rank
## 添加华为源
Server = https://mirrors.huaweicloud.com/manjaro/stable/$repo/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/manjaro/stable/$repo/$arch
## 更新
sudo pacman -Syy
## 在/etc/pacman.conf添加archlinuxcn
[archlinuxcn]
SigLevel = Optional TrustedOnly
Server = https://mirrors.cloud.tencent.com/archlinuxcn/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
## 然后
pacman-key --init
sudo pacman -Sy
sudo pacman -S archlinuxcn-keyring
sudo pacman -Syyu

# 主题、中文、驱动直接使用manjaro的系统设置

# 基础软件
sudo pacman -S zsh git neovim nodejs npm python2 python3
sudo pacman -S yay base-devel

# 输入法
## 安装
sudo pacman -S fcitx fcitx-im fcitx-configtool 
sudo pacman -S fcitx-googlepinyin
## 配置~/.xprofile和.xinitrc 
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFILERS=@im=fcitx
## 配置 /etc/environment
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx

## 安装完重启

# dock栏
sudo pacman -S latte-dock
这个dock一启动会自己添加开机启动在～/.config/autostart/下
# vscode
sudo pacman -Qs visual-studio-code
sudo pacman -S visual-studio-code-bin
# VLC视频播放器
sudo pacman -S vlc
# 网易云音乐
yay -S netease-cloud-music
# wps
sudo pacman -S  wps-office-cn
sudo pacman -S  ttf-wps-fonts
sudo pacman -S wps-office-mime-cn wps-office-mui-zh-cn

# 浏览器
sudo pacman -S  google-chrome-stable

# TeamViewer
sudo pacman -S teamviewer

# 命令行文件管理：ranger
sudo pacman -S ranger

# 代理
yay -S clash
[配置说明](https://www.jianshu.com/p/2906066d2e0a)
通过浏览器访问 http://clash.razord.top 进行策略组设置

# i3wm（暂时不用）
sudo pacman -S i3-gaps feh compton polybar rofi
?????
##复制 /etc/X11/xinit/xinitrc 到～/.xinitrc。注释掉文件后面的最后的以下几行。
    twm &
    xclock -geometry 50x50-1+1 &
    xterm -geometry 80x50+494+51 &
    xterm -geometry 80x20+494-0 &
    exec xterm -geometry 80x66+0+0 -name login
然后添加i3启动命令
exec i3
    if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
      exec startx
    fi
?????
#在i3的config最后添加
exec feh --randomize --bg-fill ~/picture
exec compton -b
exec . ~/.config/polybar/launch.sh
bindsym $mod+c exec firefox
#在i3的config替换
bindsym $mod+d exec rofi -show drun
#去除i3的标题栏
    new_window none
    new_float normal
    hide_edge_borders both
#推荐byobu会话管理器，算是tmux的加强版。截图工具推荐flameshot。


# java
sudo pacman -S jdk
yay -S intellij-idea-ultimate-edition
#linux下不要使用插件rainbow(彩虹括号),不知道为什么一点就卡死
sudo pacman -S maven
#修改maven配置xml文件
mkdir ~/.m2
sudo cp /opt/maven/conf/setting.xml ~/.m2/
sudo chown -R w:w ~/.m2
#添加镜像
<mirror>
    <id>huaweicloud</id>
    <mirrorOf>*</mirrorOf>
    <url>https://mirrors.huaweicloud.com/repository/maven/</url>
</mirror>
或者
<mirror>
    <id>aliyunmaven</id>
    <mirrorOf>*</mirrorOf>
    <name>阿里云公共仓库</name>
    <url>https://maven.aliyun.com/repository/public</url>
</mirror>

# Mysql/mariadb
#安装，选择mariadb
sudo pacman -s mysql
#初始化数据目录
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
####user一定要是mysql，别chen啊chen啊的....××
#查看mysql状态
sudo systemctl status mysqld
#开机启动mysqld服务
sudo systemctl enable mysqld
#打开mysql  # systemctl start mariadb
sudo systemctl start mysqld
#设置mysql root用户密码
sudo mysql_secure_installation
#默认密码是空的，回车后设置root用户密码，后面就回车回车

mysql -u root -p //启动mariadb

#允许root远程登录
grant all privileges on *.* to 'root'@'%' identified by '123456' with grant option; //授予远程连接权限，密码为123456
flush privileges; //刷新权限
quit； //退出mariadb

# neovim
sudo pacman -S  fzf 
#支持系统剪切板
sudo pacman -S xclip

添加base软件
sudo pacman -S nodejs npm python2 python3  neovim 
sudo pacman -S python-pip #没有python3-pip
sudo pacman -S python2-pip

npm查看源和换源：
npm config get registry  // 查看npm当前镜像源
npm config set registry https://registry.npm.taobao.org/  // 设置npm镜像源为淘宝镜像

或者华为镜像
npm config set registry https://mirrors.huaweicloud.com/repository/npm/
npm cache clean -f

pip换源
pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
pip2 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

安装neovim、pynvim拓展
sudo npm install -g neovim

python3 -m pip install  --user --upgrade pynvim
python2 -m pip install  --user --upgrade pynvim

#coc拓展
:CocInstall coc-git coc-snippets coc-json  coc-yaml coc-html coc-clangd coc-java
:CocInstall https://github.com/one-harsh/vscode-cpp-snippets https://github.com/cstrap/flask-snippets https://github.com/tushortz/vscode-Java-Snippets https://github.com/andys8/vscode-jest-snippets https://github.com/cstrap/python-snippets

#配置c语言环境
sudo pacman -S llvm
sudo pacman -S astyle

#配置python语言环境
python -m pip install --user yapf


# 安装i3wm+plasma（不知道为什么屏幕偶尔性撕裂）
[教程1](https://userbase.kde.org/Tutorials/Using_Other_Window_Managers_with_Plasma)
[教程2](https://github.com/heckelson/i3-and-kde-plasma)

# 安装deepin-screenshot
sudo pacman -S deepin-screenshot
bindsym Print exec deepin-screenshot

# qq
sudo pacman -S deepin.com.qq.im
##如果是kde桌面
sudo pacman -S gnome-settings-daemon
设置gnome-settings-daemon自启动


# 推荐软件待尝试
ydcv —— 翻译工具
ranger —— 命令行文本浏览
w3m —— 图片预览
deepin-screenshot —— deepin 良心截图工具
zsh —— 非常好用的 shell
deepin.com.wechat —— wechat
neofetch是一个个性化显示Linux系统信息的工具
sudo pacman -S neofetch

# 解决linux写入ntfs盘时报错：只读文件系统
#卸载已挂载的设备，只需执行第一句，等一会就会重新挂载上
sudo umount /dev/sdb1
sudo mount -t ntfs -w /dev/sdb1 /run/media/w/oh-my-data

# 系统启动速度优化
Arch Linux 的 systemd-analyze 是个很不错的工具，利用它你可以很直观地观察到系统启动的时间都花到哪儿去了：
 systemd-analyze

用下面这个命令，可以了解到是什么东西启动最慢：
systemd-analyze blame

# 双系统时间设置
Arch Linux中禁用UTC解决双系统时间问题
原因：Windows双系统时间不统一在于时间表示有两个标准：localtime 和 UTC(Coordinated Universal Time) 。UTC 是与时区无关的全球时间标准。尽管概念上有差别，UTC 和 GMT (格林威治时间) 是一样的。localtime 标准则依赖于当前时区。

时间标准由操作系统设定，Windows 默认使用 localtime，Mac OS 默认使用 UTC 而 UNIX 系列的操作系统两者都有。使用 Linux 时，最好将硬件时钟设置为 UTC 标准，并在所有操作系统中使用。这样 Linux 系统就可以自动调整夏令时设置，而如果使用 localtime 标准那么系统时间不会根据夏令时自动调整。

方法
通过如下命令可以检查当前设置，systemd 默认硬件时钟为协调世界时（UTC）

timedatectl status | grep local
硬件时间可以用 hwclock 命令设置，将硬件时间设置为 localtime（解决双系统时间问题）：

 timedatectl set-local-rtc true
硬件时间设置成 UTC（恢复默认设置）：

timedatectl set-local-rtc false
上述命令会自动生成/etc/adjtime，无需单独设置。

Note: 如果不存在 /etc/adjtime，systemd 会假定硬件时间按 UTC 设置。


# 开机启动数字键盘。（MD不好使）
KDE Plasma 用户
系统设置的硬件/输入设备/键盘一项中，包含了 NumLock 行为的配置方法。
[开机启动数字键盘设置](https://wiki.archlinux.org/index.php/Activating_numlock_on_bootup_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))

