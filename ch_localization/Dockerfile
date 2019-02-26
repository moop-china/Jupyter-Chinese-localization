FROM jupyter/base-notebook:latest

LABEL maintainer="Lirongfan <lirongfan@orientsoft.cn>"

USER root

# env prepare
COPY ./files/* ./

RUN conda update conda \
    && conda env create -f environment.yml \
    && echo "source activate ch_localization" > ~/.bashrc 

ENV PATH /opt/conda/envs/ch_localization/bin:$PATH

RUN apt-get update && apt-get install -y fontconfig \
    ttf-mscorefonts-installer\
    texlive-xetex\
    latex-cjk-chinese\
    texlive-fonts-recommended\
    vim\
    && apt-get -y autoremove && apt-get -y autoclean

# another 
RUN bash ./temporary/p_root.sh

USER jovyan

RUN bash -c '/bin/echo -e "y\n" | bash ./temporary/p_user.sh'\
    && rm -r temporary
