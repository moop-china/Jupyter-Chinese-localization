FROM jupyter/datascience-notebook:7f1482f5a136

LABEL maintainer="Lirongfan <lirongfan@orientsoft.cn>"

USER root

COPY ./files/ ./

RUN apt-get update\
    && apt-get install -y fontconfig \
    ttf-mscorefonts-installer\
    texlive-xetex\
    latex-cjk-chinese\
    texlive-fonts-recommended\
    # vim\
    language-pack-zh-hans language-pack-zh-hans-base\
    && apt-get -y autoremove && apt-get -y autoclean\
    && rm -rf /var/lib/apt/lists/*

# $HOME is '/home/jovyan'
RUN bash -c '/bin/echo -e "y\n" | bash ./temporary/config.sh'