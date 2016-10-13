#NoEnv

#Include <DBA>

;global db := null ; current db connection
;global connectionStrings := "Server=localhost;Port=3306;Database=skynet;Uid=skynetuser;Pwd=oleg2304;"

class database
{
	db := null ; current db connection
	connectionStrings := "Server=s7.thehost.com.ua;Port=3306;Database=skynet;Uid=skynetuser;Pwd=oleg2304;"

	__New() {
		db := DBA.DataBaseFactory.OpenDataBase("MySQL", this.connectionStrings)
		if(IsObject(db)) {
			;MsgBox,64, Connection, Successful connect to a DB.
			this.db := db
		} else {
			MsgBox,64, No Connection, You must connect to a DB to use this command.
			this.db := null
		}			
		return this
	}
	
	get_account(name) {
		account := []
		if(IsObject(this.db))
		{
			rs := this.db.OpenRecordSet("SELECT * FROM buki WHERE name = '" name "'")
			account.id := rs["id"]
			account.name := rs["name"] 
			account.login := rs["login"]
			account.pass := rs["pass"]
			account.err := false
		} else {
			account.err := true
			MsgBox,64, No Connection, You must connect to a DB to use this command.
		}
		return account
	}

}





;			rs := db.Query("SELECT * FROM buki WHERE name = '" name "'")
;			id := rs["id"]
;			name := rs["name"] 
;			login := rs["name"]
;			pass := rs["pass"]
;			MsgBox  %id% " " %name% " " %login% " " %pass%
			;columnCount := rs.Columns.Count()
			;for each, row in rs.Rows
			;{
			;	Loop, % columnCount
			;		msgbox % row[A_index]
			;}
		
		
		;MsgBox  % account.id " " account.name " " account.login " " account.pass
		;MsgBox  %account.id% " " %account.name% " " %account.login% " " %account.pass%
			
		   ;while(!rs.EOF){   
;			  name := rs["name"] 
;			  id := rs["id"]  ; column-name oder Index

;			  MsgBox %name% %id%
;			  rs.MoveNext()
		   ;}
		   ;rs.Close()
		   
		;rs := currentDB.Query("SELECT * FROM buki WHERE name = 'Pinnacle Sports'")
		; name := currentDB.SingleSelect("SELECT name FROM table1 WHERE id = '1'")
		;MsgBox %rs.["name"]% 
		;currentDB.Close()
	;}

		;~ if(IsObject(currentDB))
		;~ {
		   ;~ MsgBox,64, Connection, Successful connect to a DB.

		   ;~ try {
			  ;~ rs := currentDB.OpenRecordSet("SELECT * FROM buki")
			  ;~ if(IsObject(rs))
			  ;~ ShowRecordSet("ResultsLV", rs)
		   ;~ } catch e {
			  ;~ MsgBox,16, Error, % "OpenRecordSet Failed.`n`n" ExceptionDetail(e) ;state := "!# " e.What " " e.Message
		   ;~ }


	;			if(state != "")
	;				SB_SetText(state)
		;~ }else {
		   ;~ MsgBox,16, Error, No Connection avaiable. Please connect to a db first!
		;~ }
				
		