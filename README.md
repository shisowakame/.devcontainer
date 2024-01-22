# .devcontainer
WSL上でdockerを使ってchainer環境を構築するためのレポジトリです。  
  
chainerを利用したいディレクトリの親ディレクトリ内でクローンを実行して下さい。  
(利用したいディレクトリと.devcontainerが同じディレクトリで置かれるようにする。)  
隠しファイルになっているのでls -all等を使わないと確認できません。注意して下さい。  
.devcontainerディレクトリ内に隠しファイル(.env)があります。  
ここに自分のIPアドレスを入力することで、コンテナ上でGUIが操作できるようになります。  
  
次にDockerDesktopのインストールとwslの連携も完了させます。  
  
IPアドレスを入力し終わったら、.devcontainer内で`docker-compose up -d --build`を実行してください。  
ビルドができたらコンテナに入って`xeyes`コマンドを入力して目が出てきたら、GUIの設定が完了。  
その後CUDAやchaienrのモジュールが必要なプログラム等を実行してchainerが動作するかを確認してください。  
