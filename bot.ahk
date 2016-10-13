#NoEnv
;#Persistent
;#Warn All
;#Warn LocalSameAsGlobal, Off
#SingleInstance force

#Include %A_ScriptDir%\pinnacle.ahk
#Include %A_ScriptDir%\db.ahk

global db := new database()

pinn_api := new pinnacleapi()

!F2::
account := db.get_account("Pinnacle Sports")
if !account.err
   MsgBox  % account.id " " account.name " " account.login " " account.pass
else
   MsgBox  Error db
Return

!F3::
MsgBox, % pinn_api.get_client_balance()
;MsgBox, % get_client_balance()
Return

!F4::
pwb := ComObjCreate("InternetExplorer.Application") ;create IE Object
pwb.visible:=true  ; Set the IE object to visible
url := "http://www.bet365.com/instantbet/default.asp?instantbet=1&participantid=1123102008&odds=2.850"
MsgBox % urlq
; pwb.Navigate(url)
Return


