' Usage: ${UNIXAPP}[.vbs] [path to starting directory]
'        contents enclosed in square brackets optional

args = "-c" & " -l " & """/usr/share/script/code/cntlm/scanproxy.sh"""

' If there's a single argument, interpret it as the starting directory
If WScript.Arguments.Count = 1 Then
  dir = WScript.Arguments(0)
Else
  dir = ""
End If

WScript.CreateObject("Shell.Application").ShellExecute "bash", args, dir, "open", 0
