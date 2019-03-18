#!/bin/bash
# python version == 2.7 or > 3.3 and need to run under conda env
# if jupyter have been installed, the script will still ask for new password
# root privilege and under root path
# 默认字体和shell是在同一文件夹下
# call by dockerfile

conda info -e
python --version

echo 'import sys' > python_root_path.py
echo 'from distutils.sysconfig import get_python_lib; print (get_python_lib())' >> python_root_path.py
# /opt/conda/envs/ch_localization/lib/python3.6/site-packages
lib_path=`python python_root_path.py`
echo "lib path is:"
echo $lib_path
rm python_root_path.py

# ---
echo 'interface font set'
# apt-get -y install language-pack-zh-hans language-pack-zh-hans-base # refer to dockerfile
locale -a
sed -i "4 i export LC_ALL=zh_CN.UTF-8" /usr/local/bin/start.sh
sed -i "4 i export LANG=zh_CN.UTF-8" /usr/local/bin/start.sh
sed -i "4 i export LANGUAGE=zh_CN:zh:en_US:en" /usr/local/bin/start.sh
cp ./temporary/n* ${lib_path}/notebook/i18n/zh_CN/LC_MESSAGES/

echo 'prepare fonts.'
chmod 777 * -R
mkdir /usr/share/fonts/chinese
cp ./temporary/msyh.ttf /usr/share/fonts/chinese
cp ./temporary/simhei.ttf /usr/share/fonts/chinese
cd /usr/share/fonts/chinese
sudo mkfontscale
sudo mkfontdir
fc-cache

# get path
echo 'import matplotlib' > font_path.py
echo 'import os' >> font_path.py
echo 'from matplotlib.font_manager import fontManager' >> font_path.py
echo "print(os.path.dirname(fontManager.defaultFont['ttf']))" >> font_path.py
font_path=`python font_path.py`

echo 'import matplotlib' > font_path.py
echo 'print(matplotlib.matplotlib_fname())' >> font_path.py
setting_path=`python font_path.py`

rm font_path.py

# ---
echo 'config matplotlib'
cp /usr/share/fonts/chinese/simhei.ttf $font_path
cp /usr/share/fonts/chinese/msyh.ttf $font_path

sed -i "s/#font.family/font.family/" $setting_path
sed -i "s/#font.sans-serif/font.sans-serif/" $setting_path
sed -i "s/#axes.unicode_minus/axes.unicode_minus/" $setting_path
sed -i "s/font.sans-serif     :/font.sans-serif     : Microsoft YaHei, SimHei,/" $setting_path

# config latex
echo 'checking font family...'
txt=`fc-list :lang=zh`
font='Microsoft YaHei'
font_one='Microsoft YaHei'
font_two='SimHei'
if [[ $txt == *$font_one* ]]
then
    echo 'Microsoft YaHei found'
    font='Microsoft YaHei'
elif [[ $txt == *$font_two* ]]
then
    echo 'SimHei found'
    font='SimHei'
else
    exit
fi

template_path=${lib_path}'/nbconvert/templates/latex/'

article=${template_path}'article.tplx'
base=${template_path}'base.tplx'
# if it is necessary to check the existent content to avoid duplicate?
# add setting to article, and delete ascii_only from base
sed -i "/\\documentclass\[11pt\]{article}/a \\\\\usepackage{indentfirst}\n\\\\usepackage{xeCJK}\n\\\\setCJKmainfont{${font}}" $article
sed -i "s/ | ascii_only//" $base

notebook_dir=${HOME}'/jupyter-chinese'
mkdir -m 777 $notebook_dir
cp ${HOME}/test_files/* $notebook_dir

# config_jupyter
jupyter notebook --generate-config
path=${HOME}'/.jupyter/jupyter_notebook_config.py'
sed -i "/c.NotebookApp.ip/c c.NotebookApp.ip = '0.0.0.0'" $path
# sed -i "/c.NotebookApp.token/c c.NotebookApp.token = 'welcome1'" $path
sed -i "/c.NotebookApp.open_browser/c c.NotebookApp.open_browser = False" $path
sed -i "/c.NotebookApp.notebook_dir/c c.NotebookApp.notebook_dir = '$notebook_dir' " $path

# matpolotlib rebuild
echo 'from matplotlib.font_manager import _rebuild' > rebuild.py
echo '_rebuild()' >> rebuild.py
python rebuild.py
rm rebuild.py

echo 'please manually flash cache if exist, under $HOME/.cache/matplotlib'