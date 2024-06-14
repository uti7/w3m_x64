#NoTrayIcon
#NoEnv
; Browse URLs with w3m in msys environment
; Usage: this.exe URL [/std]
; Option:
;   /std or -std
;     open in standard browser instead
;     configure w3m external browser settings as follows:
;     /path/to/here/launchW3m_msys.exe "%s" /std


w3mdir := A_ScriptDir
homedir := w3mdir . "\cyghome"
minttyrc := homedir . "\.minttyrc"

msysdir := "C:\msys64"
bindir := msysdir . "\usr\bin"
clTerminal := bindir . "\mintty.exe"

minttyCaption = w3m-portable

terminaloptions = --position right --position top -t %minttyCaption% -h error -w normal -i %A_ScriptName% -c %minttyrc% -e %bindir%\env.exe MSYS=enable_pcon MSYSTEM=MSYS
shcygexe := "/usr/bin/bash"
w3mcygexe := "w3m"

	EnvGet, _path, PATH
	_path .= ";" . bindir
	EnvSet, PATH, %_path%
	EnvSet, CYGWIN, nodosfilewarning
	;EnvSet, HOME, %homedir%
	SetWorkingDir, %w3mdir%

url = %1%
isStandard = %2% 

OutputDebug, % "url: " url ", isStd:" isStandard
IfNotExist, %clTerminal%
{
	Msgbox, has no the terminal`r`n%clTerminal%
	isStandard := "-std"
}

; for requests to open in an external browser (standard browser) from w3m
If(RegExMatch(isStandard, "^[/-]std$")){
	If(url = ""){
		url = http://www.google.co.jp
	}Else{
		; replace the file scheme in msys-path notation with windows-path notation.
		url := RegExReplace(url, "i)^(file:\/\/\/)(\w)\/", "$1$2:/")

		If(RegExMatch(url, "^(https?|file):\/\/")){
			; if hyphens are being escaped like "\-" when launching the external browser from w3m, stop doing that
			url := RegExReplace(url, "(\\|/)-", "-")
			url := RegExReplace(url, "\\([&=?%])", "$1")
		}
		
	}
	Run, open %url%
	Return
}

; mintty available
clW3m = %shcygexe% --login -c "%w3mcygexe% _CYGPATH_"

If(url = ""){
	url := "-B"
}Else{
	; substitute cyg-path with windows-path
	url := win2msyspath(url)
}
StringReplace, clW3m, clW3m, _CYGPATH_, '%url%', All
STYLE := "Normal"

; if instance of w3m already exists, open it there.
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
      Send, U^u
      SendRaw, %url%
      Send, {Enter}
    }
    Return
  }
  OutputDebug, %A_ScriptName%: WinWaitActive: timed out.
}

OutputDebug, %A_ScriptName%: %clTerminal% %terminaloptions% %clW3m%, %w3mdir%, %STYLE%
Run, %clTerminal% %terminaloptions% %clW3m%, %w3mdir%, %STYLE%

Return

win2msyspath(path)
{
	ret := RegExReplace(path, "i)^([a-z]):", "/$1")
	ret := RegExReplace(ret, "\\", "/")
	StringReplace, ret, ret, %A_Space%, \%A_Space%, All
	Return, ret
}
