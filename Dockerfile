FROM gcr.io/kaggle-gpu-images/python:v122

RUN apt update && apt upgrade -y

WORKDIR /kaggle
COPY ./artifact/jupyter_lab_config.py .
COPY ./artifact/requirements.txt .

RUN pip install -U pip && pip install -r requirements.txt
RUN pip freeze >| requirements.lock

COPY ./artifact/overrides.json /opt/conda/share/jupyter/lab/settings/.

RUN apt install -y colordiff && echo "alias diff=colordiff" >> ~/.bashrc