#!/bin/bash
# user privilege
config_jupyter(){
    jupyter notebook --generate-config
    echo 'token set:welcome1'
    # jupyter notebook password
    path=${HOME}'/.jupyter/jupyter_notebook_config.py'
    sed -i "/c.NotebookApp.ip/c c.NotebookApp.ip = '0.0.0.0'" $path
    # todo
    # sed -i "/c.NotebookApp.password/c c.NotebookApp.password = 'welcome1'" $path
    sed -i "/c.NotebookApp.token/c c.NotebookApp.token = 'welcome1'" $path
    sed -i "/c.NotebookApp.open_browser/c c.NotebookApp.open_browser = False" $path
    sed -i "/c.NotebookApp.notebook_dir/c c.NotebookApp.notebook_dir = '$notebook_dir' " $path
}

# choose notebook dir
notebook_dir=${HOME}'/jupyter-chinese'
# todo
mkdir -m 777 $notebook_dir
cp ./中文.ipynb $notebook_dir
cp ./a.* $notebook_dir

config_jupyter

# flash cache
cd $HOME'/.cache/matplotlib'
ls
# rm fontList*