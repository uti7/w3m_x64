#NoTrayIcon
#NoEnv
; w3m-portableでURLを開く
; Usage: this.exe URL [/std]
; オプション  /std or -std をつけると標準のブラウザで開く
; w3mの外部ブラウザ設定欄に次のように指定する
;   /launchW3m.exe "%s" /std

w3mdir := A_ScriptDir
bindir := w3mdir . "\bin"
homedir := w3mdir . "\cyghome"
clTerminal := bindir . "\mintty.exe"

minttyCaption = w3m-portable
;cygw3mdir := win2cygpath(w3mdir)
;cygbindir := win2cygpath(bindir)

;terminalconf := cygw3mdir . "/.minttyrc"
;terminaloptions = -c  %terminalconf% -t w3m -h error -w normal -e

terminaloptions = -t %minttyCaption% -h error -w normal -i %A_ScriptName% -e
shcygexe := "sh"
w3mcygexe := "w3m"

	EnvGet, _path, PATH
	_path .= ";" . bindir
	EnvSet, PATH, %_path%
	EnvSet, CYGWIN, nodosfilewarning
	EnvSet, HOME, %homedir%
	SetWorkingDir, %w3mdir%

url = %1%
isStandard = %2% 

OutputDebug, % "url: " url ", isStd:" isStandard
IfNotExist, %clTerminal%
{
	Msgbox, has no the terminal`r`n%clTerminal%
	isStandard := "-std"
}

; w3m から 外部ブラウザ（標準ブラウザ）で開く要求の場合
If(RegExMatch(isStandard, "^[/-]std$")){
	If(url = ""){
		url = http://www.google.co.jp
	}Else{
		; cyg path 表記の fileスキームをwin path 表記に
		url := RegExReplace(url, "i)^(file:\/\/\/)cygdrive\/(\w)\/", "$1$2:/")

		If(RegExMatch(url, "^(https?|file):\/\/")){
			; マイナスを \- とエスケープしている？＞w3mからextenal browser時
			; ならば\ を消す
			url := RegExReplace(url, "\\", "")
		}
		
	}
	Run, open %url%
	Return
}

; w3mで開く
; mintty available
clW3m = %shcygexe% --login -c "%w3mcygexe% _CYGPATH_"

If(url = ""){
	url := "-B"
}Else{
	; win path の場合 cyg pathにする
	url := win2cygpath(url)
}
StringReplace, clW3m, clW3m, _CYGPATH_, '%url%', All
STYLE := "Normal"

;msgbox, %clTerminal% %terminaloptions% %clW3m%, %w3mdir%
;Clipboard = %clTerminal% %terminaloptions% %clW3m%

; 既にw3mが存在する場合はそこで開く
SendMode,Input

IfWinExist, %minttyCaption% ahk_class mintty
{
  WinActivate
  WinWaitActive, %minttyCaption% ahk_class mintty,, 2
  If ErrorLevel = 0
  {
    If(url = "-B"){
      Send, {Esc}b
    }
    Else{
      SendRaw, U%url%
      Send, {Enter}
    }
    Return
  }
  OutputDebug, %A_ScriptName%: WinWaitActive: timed out.
}
Run, %clTerminal% %terminaloptions% %clW3m%, %w3mdir%, %STYLE%

/*
	mintty.exeだけを起動するとbash＋w3mのウィンドウ（所謂minttyの画面）と
	は別にmintty自身のコンソールウィンドウが表示される（こちらはcmd.exeの
	ウィンドウと同様のもの。入力は受け付けない）。

	cygwin本体の/bin/cygwin-console-helper.exeをw3m基底フォルダのbinへコ
	ピーするとコンソールは出力されなくなるので次の処理は不要

＊minttyのコンソールウィンドウが表示されたら隠す処理

WinWait, %clTerminal% ahk_class ConsoleWindowClass,, 10
If ErrorLevel <> 0
{
  MsgBox, WinWait timed out.
  Return
}
Else
  Winhide
*/

Return

win2cygpath(path)
{
	ret := RegExReplace(path, "i)^([a-z]):", "/cygdrive/$1")
	ret := RegExReplace(ret, "\\", "/")
	StringReplace, ret, ret, %A_Space%, \%A_Space%, All
	Return, ret
}
