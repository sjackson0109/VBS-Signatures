'############################################################################
' Author: Simon Jackson
' Purpose: To call another VBScript file off a remote network resource, 
'     without leaving the end-user with an error message, stating network 
'     resource is not accessible.  Say their VPN drops etc.
'
' USAGE
'  Place this VBS File onto all WINDOWS client workstations (desktops/laptops) that are domain-joined.
'  Use Group Policy to pull this file down if that makes it easier.
'  The same GPO can also perform a scheduled task to run this file every hour.
'  Pass in the arguments to \\domainname\netlogon\signatures\signaturerollout.vbs
'  If your clients have access to any of your domain controllers (on site or via VPN)
'   then your clients will process the VBS and retrieve their AD user object attributes
'   then the VBS will merge their AD data with the relevant templates decided by the LiveSection of code.
'
' HISTORY
'	Version 1.1:  2020/04/23 - Used SHELL to execute a RUN method, passing networkPath
'	Version 1.0:  2020/04/08 - Initial version, hard-coded
'############################################################################
ON ERROR RESUME NEXT
Dim objShell, networkPath, signatureScript

Set objShell = Wscript.CreateObject("WScript.Shell")

networkPath = Wscript.Arguments(0)
signatureScript = "c:\windows\wscript.exe " & networkPath

objShell.Run signatureScript

Set objShell = Nothing