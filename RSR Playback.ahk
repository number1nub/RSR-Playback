#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%
SetTitleMatchMode, 2


RTermPath := GetRTermPath()
RTermUrl  := "https://sourceforge.net/projects/realterm/files/latest/download"
Port      := 6
SendFile  := "C:\Users\rameen25365\Desktop\GVSequence.txt"
OptStr    := "baud=9600 port=6 linedly=500 sendfile=""[SendFile]"""
RSRPath   := "C:\Program Files (x86)\TerraVici Drilling Solutions\CS-SS-RSR Utility 9.1.3\CS-SS-RSR Utility 9.1.3.exe"



Run, %RsrPath%
WinWait, Rig Site Receiver, RSS Settings, 3
WinActivate, Rig Site Receiver, RSS Settings
WinWaitActive, Rig Site Receiver, RSS Settings, 3





ExitApp


GetRTermPath() {
	RTRegKey  := "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Realterm"
	RegRead, RTermPath, %RTRegKey%, DisplayIcon
	return ((ErrorLevel || !RTermPath) ? "C:\Program Files (x86)\BEL\Realterm\RealTerm.exe" : RTermPath	)
}