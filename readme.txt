# vim: se ts=2 tw=72 ft=memo :

■w3m portable
																															2011-12-09
																									x64で再構築	2017-08-14
起動

	次のいずれかで行う

	a) w3m.bat を実行
	b) launchW3m.exe を実行

	※a)は一瞬コンソールが表示される、b)は表示されない


新規インストールの場合

	ファイルに適切なパーミッションを与える。
	特に設定ファイルや履歴のあるフォルダがcygwin環境的に書き込み可能でなけ
	ればならない(最近のcygwinはFAT32に対してchmodなどが効かない)

	+ 基底フォルダ(例)
	/cygdrive/c/cast/app/w3m_x64

	+ 設定フォルダ
	/cygdrive/c/cast/app/w3m_x64/cyghome/.w3m/

	+ パーミッション設定

	# chmod -R 664 /cygdrive/c/cast/app/w3m_x64

	# find /cygdrive/c/cast/app/w3m_x64 -name \*.exe -print \
	#      -exec chmod ug+x {} \;

	# find /cygdrive/c/cast/app/w3m_x64 -type d -print \
	#      -exec chmod a+x {} \;

各種設定例

+ コンパネの「/ であらわされるディレクトリ」

	/cygdrive/c/cast/app/w3m_x64

+ 外部テキストエディタ

	コントロールパネルの「利用するエディタ」欄で下記のように設定

	/cygdrive/C/cast/app/vim/gvim/gvim.exe "`cygpath -w %s`"


+ 外部ブラウザ

	コントロールパネルの「外部ブラウザ」欄で下記のように設定

	launchW3m.exe "%s" /std
	
		※ launchW3m は toolsフォルダにソース(ahkスクリプト)がある

+ 外部画像ビューア

	.../.w3m/mailcap または  /etc/mailcap で以下のようにする

	image/*; /cygdrive/c/PROGRA~1/IRFANV~1/i_view32.exe `cygpath -d %s`

+ ブックマーク登録

	/.w3m/bookmark.html を直接編集する
	(正規の方法では perl を必要とする、ESC-a なども使えない)

	※ブックマークページは launchW3m.exe を引数なしで起動したとき
		にも初期ページとして表示される

■(端末がckの場合のみ）
	Unicodeにおける一部の文字の）曖昧な幅の問題によって表示がズレる場合
	
	半角幅で描画されればズレないのだが、埒が明かない場合は
	.Xdefaults で
	Ck*lineSpace: 8
	のように行間を大きくすると全角表示のままでもズレなくなるかもしれない

■(端末がminttyの場合のみ）
	mintty.exeだけを起動するとbash＋w3mのウィンドウ（所謂minttyの画面）と
	は別にmintty自身のコンソールウィンドウが表示される（こちらはcmd.exeの
	ウィンドウと同様のもの。入力は受け付けない）。

	cygwin本体の/bin/cygwin-console-helper.exeがあればコンソールは出力され
	なくなる（同exeを基底フォルダのbinへコピーする）

以上
