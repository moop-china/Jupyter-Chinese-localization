FROM jupyter/base-notebook:latest

USER root

# env prepare
COPY ./files/* ./

RUN apt-get update && apt-get install -y fontconfig \
    ttf-mscorefonts-installer\
    texlive-xetex\
    latex-cjk-chinese\
    texlive-fonts-recommended\
    # vim 
    vim\
    && apt-get -y autoremove && apt-get -y autoclean

RUN conda update -n base conda \
    && conda install pandoc jupyter nbconvert matplotlib pandas seaborn

# another 
RUN bash p_root.sh

USER jovyan

RUN bash -c '/bin/echo -e "y\n" | bash p_user.sh'
