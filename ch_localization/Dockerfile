FROM jupyter/base-notebook:latest

LABEL maintainer="Lirongfan <lirongfan@orientsoft.cn>"

USER root

RUN apt-get update && apt-get install -y fontconfig \
    ttf-mscorefonts-installer\
    texlive-xetex\
    latex-cjk-chinese\
    texlive-fonts-recommended\
    vim\
    language-pack-zh-hans language-pack-zh-hans-base\
    && apt-get -y autoremove && apt-get -y autoclean

COPY ./files/ ./

RUN conda update conda \
    && conda env create -f environment.yml \
    && echo "source activate ch_localization" > ~/.bashrc 

ENV PATH /opt/conda/envs/ch_localization/bin:$PATH

# env prepare

RUN bash ./temporary/p_root.sh

USER jovyan

RUN bash -c '/bin/echo -e "y\n" | bash ./temporary/p_user.sh'\
    && rm -r temporary
