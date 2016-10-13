#NoEnv
#SingleInstance force
!F3::


bet365 := []
bet365.user := "olykaptilova"
bet365.pass := "tujhktnjdevth1"
bet365.url := "http://www.bet365.com/instantbet/default.asp?instantbet=1&participantid=1123102008&odds=2.850"
bet365.urlhistory := "https://members.bet365.com/Members/Authenticated/History/Sports/"
bet365.history := 1
bet365.id := "12/10/2016 12:15:12"

pwb:=setWbCom("bet365", "members.bet365.com")

If !pwb
   {
   pwb := ComObjCreate("InternetExplorer.Application") ;create IE Object
   pwb.visible:=true  ; Set the IE object to visible
   }
   pwb.Navigate(bet365.urlhistory)


   If vilka = 1   ;Если нужно проверить вилку
   {
   pwb.Navigate(bet365.url)
while pwb.busy or pwb.ReadyState != 4 ;Wait for page to load
   Sleep, 50

ComObjError(false)  ;Не показывать ошибки Com

;Логинимся если не залогинены
   If pwb.document.all.aJNL.innerText   ;Если есть текст Join Now
   {
      pwb.document.all.txtUserName.Value := bet365.user       ;логин
      pwb.document.all.txtPassword.Value := bet365.pass       ;пароль
      pwb.document.getElementById("aLGI").click()      ;вход
      while !(pwb.document.all.sbl.innerText)          ;Ждем когда появится баланс
      Sleep, 100
   } 
   
   pwb.document.all.tags("A")[11].click()               ;проверяем максимум
   while pwb.busy or pwb.ReadyState != 4                ;Wait for page to load
   Sleep, 50
;получаем параметры    
   bet365.odds:=pwb.document.all.do1001.innerText              ;Коэф 
   bet365.fora:=pwb.document.all.dl1001.innerText              ;Фора
   bet365.balance:=pwb.document.all.tags("FONT")[3].innerText  ;Баланс
   bet365.maximum:=pwb.document.all.Risk1001.value             ;Фора
   MsgBox % bet365.odds bet365.fora bet365.balance bet365.maximum
   }










   If bet365.history = 1   ;Если нужно проверить вилку
   {
   ;pwb.Navigate(bet365.urlhistory)
   while pwb.busy or pwb.ReadyState != 4 ;Wait for page to load
   Sleep, 50
   ComObjError(false)  ;Не показывать ошибки Com
   ;Логинимся если не залогинены
   If pwb.document.all.ctl00_main_login_lkLostLogin.innerText   ;Если есть текст Join Now
   {
      pwb.document.all.ctl00_main_login_UserNameText.Value := bet365.user       ;логин
      pwb.document.all.ctl00_main_login_PasswordText.Value := bet365.pass       ;пароль
      ;pwb.document.getElementById("ctl00_main_login_lkSbmt").click()      ;вход
      while !(pwb.document.all.ctl00_main_SportsHistorySearchControl_lblTitle.innerText)          ;Ждем когда появится баланс
      Sleep, 100
   } 

      while !(pwb.document.all.ctl00_main_SportsHistorySearchControl_lblTitle.innerText)   ;Ждем когда появится баланс
      Sleep, 100

      pwb.document.GetElementsByTagName("SELECT")[0].Value :="3" ;расчитанные ставки
      pwb.document.GetElementsByTagName("INPUT")[13].checked :=1 ;за 48 часов
      pwb.document.all.ctl00_main_SportsHistorySearchControl_dateSearchControl_lkGo.click()  ;показать историю

       while pwb.busy or pwb.ReadyState != 4 ;Wait for page to load
         Sleep, 100
      Loop, 3 {
      pwb.document.all.ctl00_main_SportsHistorySearchControl_btnShowMore.click() ;показать больше записей
      Sleep, 300 
      }
      table:= pwb.document.getElementByID("results").childnodes.length  
      MsgBox % table

}


   Return
   
  elements := pwb.document.getElementByID("results").childnodes.length 
  pwb.document.all.results.innerText 
   loop % (elements := pwb.document.getElementByID("results").childnodes).length ;stores elements for looping and gets length in same line
	MsgBox % elements[a_index-1].InnerTEXT


 


;***********second example*******************
loop % (elements := pwb.document.getElementsByTagName("address")).length  ;Stores elements for loop and gets length in same line
      if (elements[A_index-1].getAttribute("data-test-id") = "prospect.address")
         Address := elements[A_index-1].innertext
 

   
   
   

  ; pwb.document.documentElement.innerText ;Get All text on page
  ;pwb.document.all.tags("INPUT")[17].focus(Sincerely) ; Acts like clicking the link
  ;pwb.document.all.tags("INPUT")[13].fireEvent("onclick")  ; Sometimes needed in conjunction with click()
  ;SendInput Sincerely 
  ; Var:=pwb.document.all.txtUserName1.Value ;Unique ID -no dashes
  ; Var:=pwb.document.all.txtPassword1.Value ;Unique ID -no dashes

  ; Var:=pwb.document.all.dl1001.innerText ;Unique ID -no dashesSincerely
   
  ; MsgBox % Var
  ; pwb.document.all.txtUserName1.fireEvent("onclick")


   ;pwb.document.getElementByID("aLGI").click() ;Unique ID-with dashes
   
   ;pwb.document.documentElement.innerText ;Get All text on page
  ; pwb.document.all.tags("tagnameXXX")[8].click() ; Acts like clicking the link
;ClickLink(pwb,Text:="Accept")
;ClickLink(pwb,Text:="Bet Max")


   ;pwb.document.all.Risk1001.Value :="0.2" ;Unique ID -no dashes
;~ //Заполняем форму входа
                        ;~ document.getElementById("txtUserName1").value = command.login;
                        ;~ document.getElementById("txtUserName").value = command.login;
                        ;~ document.getElementById("txtPassword1").value = command.password;
                        ;~ document.getElementById("txtPassword").value = command.password;
                        ;~ gLi(); //давим кнопку или document.getElementById("aLGI").click();


ClickLink(PXL,Text=""){
ComObjError(false)
Links := PXL.Document.Links
Loop % Links.Length
   If (Links[A_Index-1].InnerText = Text ) { ; search for Text
      Links[A_Index-1].Click() ;click it when you find it
      break
   }
ComObjError(True)
}
   



;***********Function*******************
setWbCom(name=false, url=false) {
    ;   Set web browser COM pointer        ;   eserv_flag sets this.wb_eserv
    if (!name AND !url) {
        ;    Clear COM object
        return false
    }
    ;   Set defaults.  No promises.
    wb:=false
    For wb in ComObjCreate( "Shell.Application" ).Windows {
        Try {
            If ((InStr(wb.locationName, name) AND name) OR (InStr(wb.locationURL, url) AND url)) && InStr(wb.FullName, "iexplore.exe") {
                return wb
            }
        } Catch, e {
            if (e AND this.debug) {
                FileAppend, % "`r`nCOM Error: " . e, % this.debug_file
            }
        }
    }
    if (debug) {
        this.errorWindow("Failed to find web browser.`r`nName:`t" . name . "`r`nURL:`t" . url)
    }
    return false
}
     

Return  
