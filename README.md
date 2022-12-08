# Kaggle Docker Environment

Kaggle Notebookの実行環境のソースコード。ローカルマシン上でPublic Notebookの動作確認をするために作った。

## Requirements

- ubuntu 22.04で動作確認ずみ
- `cuda` に対応したGPU
- [Docker Engine](https://docs.docker.com/engine/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/overview.html)

## 使い方

### コンテナイメージのビルド&サービス起動

```
docker compose up -d --build
```

### コンテナのTTYにアタッチ

```
docker exec -it kaggle-jupyter fish 
```

## コンテナ内の資材構成

### ディレクトリ構成

- `/kaggle/input`: データセットを格納するディレクトリ
- `/kaggle/working`: ノートブックおよび実行結果を格納するディレクトリ

## カスタマイズしたところ

* [NVDashboard](https://github.com/rapidsai/jupyterlab-nvdashboard)プラグインによりコンテナ内のマシンリソースの使用率を可視化
* Jupyter Labを[共同編集モード](https://jupyterlab.readthedocs.io/en/stable/user/rtc.html#real-time-collaboration) (`--collaborative`)で起動している。複数のクライアントから接続してnotebookの実行状態を確認することができる
* Jupyter Labのデフォルトテーマを[Material Darker](https://github.com/oriolmirosa/jupyterlab_materialdarker)にした
