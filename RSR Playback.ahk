#NoEnv
#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%
SetTitleMatchMode, 2


rtPath  := "C:\Program Files (x86)\BEL\Realterm\RealTerm.exe"
port    := 6
sndFile := "C:\Users\rameen25365\Desktop\GVSequence.txt"
optStr  := "baud=9600 port=6 linedly=500 CR=1 LF=1 sendfile=""[SendFile]"""
RsrPath := "C:\Program Files (x86)\TerraVici Drilling Solutions\CS-SS-RSR Utility 9.1.3\CS-SS-RSR Utility 9.1.3.exe"



Run, %RsrPath%
WinWait, Rig Site Receiver, RSS Settings, 3
WinActivate, Rig Site Receiver, RSS Settings
WinWaitActive, Rig Site Receiver, RSS Settings, 3

