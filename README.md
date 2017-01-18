# おれおれjenkins

---


# RUN

## jenkin 起動

- 下準備と起動

```
./init.sh
docker-compose build
docker-compose up -d
```

- web uiへアクセス

http://localhost:8080/my-site/

- unlock code 取得してweb uiへ入力

```
docker-compose exec master cat /var/jenkins_home/secrets/initialAdminPassword
```

- 好みのpluginをインストール(ssh slaves pluginは必須)

- 終わったら、admin アカウント作成

## 認証情報の登録

無事jenkinsが立ち上がったら認証情報を登録します。


左メニュー「jenkinsの設定」 > 左メニュー「認証情報」

認証情報一覧が出るので、ドメインが `(global)` となっているところに登録します。

<dl>
<dt>種類</dt>
<dd>SSHユーザー名と秘密鍵</dd>
<dt>スコープ</dt>
<dd> グローバル</dd>
<dt> ユーザー名</dt>
<dd> root</dd>
<dt>秘密鍵</dt>
<dd>Jenkinsマスター上のファイルから</dd>
<dt> ファイル </dt>
<dd>/var/key</dd>
</dl>

その他は空白でok

※鍵は ```slave/id_key``` をdocker-composeで起動時に```/var/key``` にマウントしてます。

## スレーブの登録

左メニュー「Jenkinsの管理」 > ノードの管理 > 左メニュー「新規ノードの作成」

ノード名に 適当にわかり易い名前、ここではslave1とします。

Permanent Agent にチェック入れてok

<dl>
<dt>リモートFSルート</dt>
<dd>とりあえず ```/var/tmp``` を入力しておきます。 お好みの環境に合わせてください。</dd>
<dt>ラベル</dt>
<dd>ジョブを実行するノードを指定するのに使用します。にここではdocker-hostと入れておきます。</dd>
<dt>起動方法<dt>
<dd>SSH経由でUnixマシンのスレーブエージェントを起動</dd>
<dt>ホスト<dt>
<dd>slave (docker-composeのmasterにリンクした名前です)</dd>
<dt>認証情報</dt>
<dd>先に作成した`root`を選択</dd>
</dl>

保存を押すと、slaveにエージェントのインストールが開始され、数分のうちに利用可能になります


## ジョブ実行

docker runする簡単なジョブを登録してテストします。

フリースタイルの場合
実行するノードを制限にチェックを入れ、先に登録したノードのラベルの `docker-host` を入力

以下ジョブを登録し実行します。

```
docker run --rm hello-world
```

ビルド結果を参照して、dockerのhello-worldが表示されてれば成功。

ホストのdockerを使用するのでホストでビルドしたすべてのdockerイメージが利用可能です。
