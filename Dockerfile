FROM gcr.io/kaggle-gpu-images/python:v122

RUN apt update && apt upgrade -y

WORKDIR /kaggle
COPY ./artifact/jupyter_lab_config.py .
COPY ./artifact/requirements.txt .

RUN pip install -U pip && pip install -r requirements.txt
RUN pip freeze >| requirements.lock

COPY ./artifact/overrides.json /opt/conda/share/jupyter/lab/settings/.

RUN apt install -y colordiff && echo "alias diff=colordiff" >> ~/.bashrc

# fish & fisher
RUN apt-add-repository ppa:fish-shell/release-3 && \
    apt update && \
    apt install -y fish && \
    chsh -s /usr/bin/fish
SHELL ["/usr/bin/fish", "-c"]
RUN curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher && \
    apt install -y fonts-powerline && \
    fisher install oh-my-fish/theme-bobthefish && \
    fisher install jethrokuan/z

WORKDIR /kaggle/working