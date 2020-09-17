#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%
SetTitleMatchMode, 2



RSRPath   := "C:\Program Files (x86)\TerraVici Drilling Solutions\CS-SS-RSR Utility 9.1.3\CS-SS-RSR Utility 9.1.3.exe"


if (rtID:=WinExist("RealTerm: Serial Capture Program")) {
	if (m("ico:!", "RealTerm is already running. Make sure you don't try to use the same port.`n", "Do you want to switch to the active window (NO to start new instance)?", "btn:yn") = "YES") {
		WinActivate, ahk_id %rtID%
		ExitApp
	}
}
if (!WinExist("Rig Site Receiver", "RSS Settings") && FileExist(RSRPath)) {
	Run, %RsrPath%
	WinWait, Rig Site Receiver, RSS Settings, 3
	WinActivate, Rig Site Receiver, RSS Settings
	WinWaitActive, Rig Site Receiver, RSS Settings, 3
}

RunIt()

ExitApp



RunIt(sendFile:="", port:="") {
	sendFile := sendFile ? sendFile : GetSFilePath()
	port := port ? port : GetPort()
	rtPath := GetRTermPath()
	OptStr := "baud=9600 port=" port " linedly=1500 sendfile=""" sendFile """"
	
	try {
		Run, % """" rtPath """ " OptStr
	} catch e {
		m("ico:!", "Somehting went wrong:`n", e.message, e.what)
	}
	IniWrite, %port%, config.ini, PreviousSettings, port
	IniWrite, %rtPath%, config.ini, PreviousSettings, RTPath
}



;*[TODO: Prompt to DL if not installed?]
;~ DLUrl := "https://sourceforge.net/projects/realterm/files/latest/download"

GetRTermPath() {
	IniRead, RTermPath, config.ini, PreviousSettings, RTPath, ERR
	if (FileExist(RTermpath) && RTermPath != "ERR") 
		return RTermPath
	RTRegKey  := "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Realterm"
	RegRead, RTermPath, %RTRegKey%, DisplayIcon
	return ((ErrorLevel || !RTermPath) ? "C:\Program Files (x86)\BEL\Realterm\RealTerm.exe" : RTermPath)
}



GetSFilePath() {
	sendFile := FileExist(def:=A_ScriptDir "\res\GVSequence.txt") ? def : ""
	FileSelectFile, sendfile,, %def%,, Text Documents (*.txt)
	if (ErrorLevel || !sendfile) {
		m("ico:!", "Goodbye")
		ExitApp
	}
	return sendFile
}



GetPort() {
	IniRead, port, config.ini, PreviousSettings, port, 7
	InputBox, port, RSR Playback, Enter port number to send raw GVs from:,,,,,,,, %port%
	if (ErrorLevel || !port) {
		m("ico:!", "Goodbye")
		ExitApp
	}
	return port
}