args = "-c" & " -l " & """DISPLAY=:0 terminator"""

If WScript.Arguments.Count = 1 Then
	dir = WScript.Arguments(0)
Else
	dir = ""
End If

WScript.CreateObject("Shell.Application").ShellExecute "bash", args, dir, "open", 0
