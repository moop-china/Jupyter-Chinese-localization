### files

+ Dockerfile
+ files
    + environment.yml
    + temporary
        + p_root.sh
        + p_user.sh
        + msyh.ttf
        + simhei.ttf
    + test_files
        + a.csv
        + test_pdf.png
        + 中文 and plot test.ipynb
+ readme.md

### What dose dockerfile do?

1. 首先准备环境，包括文件准备和依赖安装。  

2. 然后在root权限下，复制字体到指定的文件夹，然后重建字体索引。  

3. 找到matplotlib的字体库路径和配置文件路径，把字体复制到字体库，并修改配置文件。  

4. 修改latex的配置文件。  

5. 切换jupyter的默认用户jovyan，复制测试文件到指定目录，并修改jupyter配置文件。然后刷新matplot的字体缓存。  

6. 最后删除在temporary中的sh脚本和字体文件。