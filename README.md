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
有构建docker环境的dockerfile和对应的功能性测试文件，详细内容请参考其下的 readme.md

## 操作指南

1. 所有的代码仅经过我个人的测试，如果有没有考虑到的特殊情况，请酌情自己修改代码
2. 将全部文件copy到想要的地方，然后在ch_localization同级文件夹下执行以下命令即可  
    ```
    docker build --rm -f "ch_localization/Dockerfile" -t ch_localization:$tag ch_localization
    ```
2. 如果你需要jupyter的中文化，请参考ch_doc/jupyter_ch.sh
3. 如果你需要matplotlib打印出中文，请参考ch_doc/matplot_ch.sh
4. ch_localization/files/temporary/p_root.sh和p_user.sh是上面两个功能的整合，因为涉及到了dockerfile里面build镜像的角色问题，所以分成了两部分

