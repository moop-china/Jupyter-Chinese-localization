# Chinese_localization
## 目的
jupyter notebook的使用中，有这样三个问题

1. 中文界面并不稳定，有些人可以看到中文界面，有些看不到
2. 无法正常下载有中文的PDF
3. matplotlib和基于它的包画出的图没有中文

这三个问题困扰着中文使用者。这个项目就是针对这些问题，对jupyter做的一些修复改造工作。  

## 文件结构

1. ch_doc  
    1. jupyter_ch.md 是解决matplotlib使用中，jupyter无法输出中文pdf和图像的方案,jupyter_ch.sh是自动脚本, jupyter_en.md是英文教程  
    2. matplot_ch.md是在matplotlib中绘图无法显示中文的解决方案，matplot_ch.sh是自动脚本
3. ch_localization  
有构建docker环境的dockerfile和对应的功能性测试文件

## 操作指南

1. 所有的代码仅经过我个人的测试，如果有没有考虑到的特殊情况，请酌情自己修改代码
2. 将全部文件copy到想要的地方，然后在ch_localization同级文件夹下执行以下命令即可  
    ```
    docker build --rm -f "ch_localization/Dockerfile" -t ch_localization:$tag ch_localization
    ```
3. 如果你需要jupyter的中文化，请参考ch_doc/jupyter_ch.sh
4. 如果你需要matplotlib打印出中文，请参考ch_doc/matplot_ch.sh
5. ch_localization/files/config.sh是上面两个功能的整合

## 操作简介

下面将简单介绍config.sh做了什么工作。  
1. 首先查看python和conda的版本是否符合预期
2. 找到python库路径，添加i18n的信息
3. 添加字体，在Linux系统中添加字体索引信息
4. 找到matplotlib的字体库路径，对配置文件进行修改
5. 对jupyter进行配置
6. 重新载入matplotlib的配置信息

## 可能存在的问题
1. 初始存在的文件都是只读文件，创建者是root，在jupyter页面是无法修改的。
    * 容器启动后，进入其控制终端，用`docker container ls`来查询containerID，然后执行`docker exec -it ${containerID} /bin/sh -c "[ -e /bin/bash ] && /bin/bash || /bin/sh"`，进入容器后到指定的位置删除文件即可。
    * 修改`ch_localization\files\test_files`下的文件，这个文件夹下的全部内容都将被copy到jupyter的根目录

