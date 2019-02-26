#!/bin/bash
# python version == 2.7 or > 3.3 and need to run under conda env
# if jupyter have been installed, the script will still ask for new password
# root privilege and under root path
# 默认字体和shell是在同一文件夹下
# call by dockerfile


# check if the env had been activated

# if [ $# -lt 1 ]
# then 
#     echo 'add a conda environment in command line, like bash test.sh testenv'
#     exit
# fi


# source activate $1
conda info -e
python --version

# ---
echo 'prepare fonts'
mkdir /usr/share/fonts/chinese
cp ./msyh.ttf /usr/share/fonts/chinese
cp ./simhei.ttf /usr/share/fonts/chinese
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
# /opt/conda/lib/python3.7/site-packages/matplotlib/mpl-data/fonts/ttf
echo 'config matplotlib'
cp /usr/share/fonts/chinese/simhei.ttf $font_path
cp /usr/share/fonts/chinese/msyh.ttf $font_path
# todo
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
# if [[ $txt =~ *$font_one* ]]
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

echo 'import sys' > python_root_path.py
echo 'from distutils.sysconfig import get_python_lib; print (get_python_lib())' >> python_root_path.py
lib_path=`python python_root_path.py`
template_path=${lib_path}'/nbconvert/templates/latex/'
rm python_root_path.py

article=${template_path}'article.tplx'
base=${template_path}'base.tplx'
# if it is necessary to check the existent content to avoid duplicate?
# add setting to article, and delete ascii_only from base
sed -i "/\\documentclass\[11pt\]{article}/a \\\\\usepackage{indentfirst}\n\\\\usepackage{xeCJK}\n\\\\setCJKmainfont{${font}}" $article
sed -i "s/ | ascii_only//" $base
