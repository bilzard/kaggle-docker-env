FROM gcr.io/kaggle-gpu-images/python:v132

RUN apt update && apt upgrade -y

WORKDIR /kaggle

# colordiff
RUN apt install -y colordiff && echo "alias diff=colordiff" >> ~/.bashrc

# fish
RUN apt-add-repository ppa:fish-shell/release-3 && \
    apt update && \
    apt install -y fish && \
    chsh -s /usr/bin/fish

# fisher
SHELL ["/usr/bin/fish", "-c"]
RUN curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher && \
    apt install -y fonts-powerline && \
    fisher install oh-my-fish/theme-bobthefish && \
    fisher install jethrokuan/z
SHELL ["/usr/bin/bash", "-c"]

# pytorch for RTX3090 Ti
RUN pip install torch==1.12.1+cu116 \
  torchvision==0.13.1+cu116 \
  torchaudio==0.12.1 \
  --extra-index-url https://download.pytorch.org/whl/cu116

# install pip requirements
COPY ./artifact/requirements.txt .
RUN pip install -U pip && pip install -r requirements.txt
RUN pip freeze > requirements.lock

# jupyter lab config
COPY ./artifact/jupyter_lab_config.py .
COPY ./artifact/overrides.json /opt/conda/share/jupyter/lab/settings/.

# git safe directory
RUN git config --global --add safe.directory "*"

# direnv
RUN apt install -y direnv
RUN echo 'export EDITOR=vim' >> ~/.bashrc && \
  echo 'eval "$(direnv hook bash)"' >> ~/.bashrc

WORKDIR /kaggle/working
