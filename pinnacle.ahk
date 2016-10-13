;#Persistent
;#Warn All
;#Warn LocalSameAsGlobal, Off
;#SingleInstance force

;#Include %A_ScriptDir%\lib\base64.ahk

#Include <base64>

class pinnacleapi
{

	pin_api_url_v1 := "https://api.pinnacle.com/v1/"
	pin_api_url_v2 := "https://api.pinnacle.com/v2/"

	__New() {
		account := db.get_account("Pinnacle Sports")
		if !account.err {
			;MsgBox  % account.id " " account.name " " account.login " " account.pass
			this.log_pass := "Basic " Base64(account.login ":" account.pass)
			MsgBox % "Pinnacle create key: " this.log_pass
		} else {
		   MsgBox  Error db
		   this.log_pass := null
		}

		return this
	}
	
	get_client_balance()
	{
		balance:=this.get_api(this.pin_api_url_v1, "client/balance", "")
		return % balance
	}

	get_api(api_url, resource, options) 
	{
		api := ComObjCreate("WinHTTP.WinHttpRequest.5.1")
		api.Open("GET", api_url resource options, false)
		api.SetRequestHeader("Authorization", this.log_pass)
		api.SetRequestHeader("Content-Type", "application/json")
		;api.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
		;Body = {"longUrl": "%long%"}
		;api.Send(Body)
		api.Send()
		;api.WaitForResponse()
		;api.Send("user=admin&pass=admin")
		;api.Send("{" . q . "longUrl" . q . ": " . q . url . q . "}")
		return % api.ResponseText
	}
}

; ============== Upload attachments ==============
; doc: http://requesttracker.wikia.com/wiki/REST#Ticket_History_Comment

/*
; ------ Upload single file
content_data =
(
id: 34
Action: comment
Text: the text comment
Attachment: test-20160315-a1.txt
)
objParam := { content: content_data
            , attachment_1: ["test-20160315-a1.txt"] }

; ------ Upload multiple files
content_data =
(
id: 34
Action: comment
Text: the text comment
Attachment: test-20160315-a1.txt
 test-20160315-b1.txt
)
objParam := { content: content_data
            , attachment_1: ["test-20160315-a1.txt"]
            , attachment_2: ["test-20160315-b1.txt"] }
CreateFormData(PostData, header_ContentType, objParam)

whr.Open("POST", baseUrl "/ticket/34/comment", true)
whr.SetRequestHeader("Content-Type", header_ContentType)
whr.Send(PostData)
whr.WaitForResponse()
MsgBox, % whr.ResponseText

ExitApp
Return
*/