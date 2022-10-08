
# w3m portable
                                                         1st. 2011-12-09
                                              rebuild on x64. 2017-08-14

## To start

	Do as follows either.

	(a) run w3m.bat
			or
	(b) run launchW3m.exe  

\* (a) Displays the console window for a moment, (b) does not display it.


## Prepare for new installation.

	Give the file proper permissions. In particular, folders with
	configuration files and history must be writable in the cygwin
	environment. (Recently, cygwin does not work with chmod etc. for
	FAT32)

	- Your base directory (example)
		/cygdrive/c/cast/app/w3m_x64

	- Your settings storage directory (example)
		/cygdrive/c/cast/app/w3m_x64/cyghome/.w3m/

	- Permission settings   

	```  
	# chmod -R 664 /cygdrive/c/cast/app/w3m_x64
	# find /cygdrive/c/cast/app/w3m_x64 -name \*.exe -print \
				 -exec chmod ug+x {} \;
	# find /cygdrive/c/cast/app/w3m_x64 -type d -print \
				 -exec chmod a+x {} \;
	```  

## Various setting examples

- Directory Settings (in Option Setting Pannel)

	- Directory corresponding to / (document root)  
		`/cygdrive/c/cast/app/w3m_x64`

- External Program Settings

	- Editor  
		`cygstart /cygdrive/c/cast/app/gvim64/gvim.exe \`cygpath -ad "%s"\` `

	- External Browser  
		`/launchW3m.exe "%s" /std`  


\* launchW3m.exe has a source (ahk script) in the tools folder  


- External Image Viewer

	- Put the following in ../.w3m/mailcap or /etc/mailcap 
		`image/*; /cygdrive/c/PROGRA~1/IRFANV~1/i_view32.exe `cygpath -d %s` `

- Bookmark management

	Edit `/.w3m/bookmark.html' directly.
	The basic method requires perl and cannot use key functions such as ESC-a

	\* The bookmark page when calling launchW3m.exe with no arguments also  
      appears as the first page.


## Remarks

- Only when the terminal is Ck used  
When the display is shifted due to the ambiguous width problem (of some
characters in Unicode).
If it is drawn with a half-width width, there will be no deviation, but
if it is not clear in .Xdefaults  

	```
	Ck*lineSpace: 8
	```  

If you increase the space between lines like this, the misalignment may
be eliminated even if the display is full-width.

- Only if the terminal is mintty used  
When only mintty.exe is started, bash + w3m window (so-called mintty
screen) and mintty's own console window is displayed separately (this is
cmd.exe's Similar to windows. input is not accepted).

If there is /bin/cygwin-console-helper.exe of cygwin main body, the
console will be output disappear (copy the same exe to the bin of the
base folder)


***
vim: noet ts=2 tw=72 ft=md :
