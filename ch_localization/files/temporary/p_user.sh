#!/bin/bash
# user privilege

# choose notebook dir and copy test files
notebook_dir=${HOME}'/jupyter-chinese'
mkdir -m 777 $notebook_dir
cp ./test_files/* $notebook_dir

# config_jupyter
jupyter notebook --generate-config
path=${HOME}'/.jupyter/jupyter_notebook_config.py'
sed -i "/c.NotebookApp.ip/c c.NotebookApp.ip = '0.0.0.0'" $path
# sed -i "/c.NotebookApp.token/c c.NotebookApp.token = 'welcome1'" $path
sed -i "/c.NotebookApp.open_browser/c c.NotebookApp.open_browser = False" $path
sed -i "/c.NotebookApp.notebook_dir/c c.NotebookApp.notebook_dir = '$notebook_dir' " $path

echo 'please manually flash cache if exist, under $HOME/.cache/matplotlib'
