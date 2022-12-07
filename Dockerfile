FROM gcr.io/kaggle-gpu-images/python:v122

WORKDIR /kaggle/working
RUN mkdir -p /kaggle/input
COPY ./artifact/jupyter_lab_config.py /kaggle/.

RUN apt update && apt upgrade -y
RUN pip install -U pip && pip install \
    fastprogress \
    japanize-matplotlib \
    nb-black \
    jupyterlab_materialdarker
RUN pip freeze >| /kaggle/requirements.lock

COPY ./artifact/overrides.json /opt/conda/share/jupyter/lab/settings/.
