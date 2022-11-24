# Kaggle Docker Environment

Kaggle Notebookの実行環境のソースコードです。
手元でPublic Notebookの動作確認をするために作りました。
dockerコンテナをベースとして開発する場合の参照実装としてお使いください。

## Requirements

- ubuntu: 22.04
- `cuda` に対応したGPU
- [Docker Engine](https://docs.docker.com/engine/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/overview.html)

動作確認はしてませんが、Linux特有の設定はしていないはずなので別のOSでも動くかもしれません。

## Install

1. RequirementsにあるDocker Engine, Docker Compose, NVIDIA Container Toolkitを公式手順でインストールする。
2. 本リポジトリを任意の場所にクローンし、カレントディレクトリを移動する
3. コンテナをビルドしてサービスを起動する `docker compose up --build`

サーバ上の`localhost:8888`ポートでjupyter lab環境が起動します。終了時は`docker compose up`を実行したターミナルで`Ctrl-C`を押してください。

## コンテナ内のディレクトリ構成

- `/kaggle/input`: データセットを保持するディレクトリ。ホストマシン上の`./input`と同期していて、コンテナを終了させても内容は残ります（read-onlyではないので注意）。
- `/kaggle/working`: ノートブックおよび実行結果を保持するディレクトリ。ホストマシン上の`./working`と同期していて、コンテナを終了させても内容は残ります。

## 運用イメージ

Public Notebookをこの環境で動かす場合、

1. dockerコンテナを起動する `docker compose up`
2. ホストマシン上で依存しているKaggleのデータセットをKaggle APIで取得し、`./input`ディレクトリ内に展開する
3. Kaggleのnotebookページからダウンロードしたipynb形式のファイルをjupyter labの管理画面からアップロードする。アップロードしたノートブックはコンテナ内の`/kaggle/working`に配下に置かれる
4. notebookを手動でステップ実行する。inputのパスが元のnotebookと異なる場合は適宜書き換える
5. notebookの実行結果（モデルの重みなど）はホストマシン上の`./working`ディレクトリ配下に保持される
6. 実行完了後、コンテナを削除して状態を初期化する `docker compose rm`（コンテナの状態を保持したい場合はこの手順は不要です）

Tips: `input`ディレクトリにデータセットをダウンロードするさい、データセットのURLの末尾の名前と一致させておくと元のNotebookのパスを変更する必要がないので便利です。ただし、ユーザのデータセットをダウンロードする場合は名前の重複に注意する必要があります。

## その他カスタマイズしたところ

* Jupyter Labのデフォルトテーマを[Material Darker](https://github.com/oriolmirosa/jupyterlab_materialdarker)にした
* Jupyter Labを[共同編集モード](https://jupyterlab.readthedocs.io/en/stable/user/rtc.html#real-time-collaboration) (`--collaborative`)で起動している。複数のクライアントから接続してnotebookの実行状態を確認することができる

## 参考

本リポジトリを作った経緯などは以下のブログに記載しています。
- [Kaggle Notebook実行環境と仮想環境の運用について](https://bilzard.hatenablog.com/entry/2022/11/24/083754)
