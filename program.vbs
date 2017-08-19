
Set FSO = CreateObject("Scripting.FileSystemObject")
Set XHR = CreateObject("MSXML2.XMLHTTP")
Set WSH = WScript.CreateObject("WScript.Shell")

Select Case WScript.ScriptName
  Case "フォルダの一括作成・削除.vbs"      : Call CreateAndDeleteFolders
  Case "依頼フォルダリンクを更新.vbs"      : Call UpdateLinkToIraiFolders
  Case "依頼フォルダリンクを作成.vbs"      : Call UpdateLinkToIraiFolders
  Case "依頼フォルダリンクを一括作成.vbs"  : Call UpdateLinkToIraiFolders_All
  Case "リンク一覧表示.vbs"                : Call OpenLinkList
  Case Else         : 
End Select


Sub CreateAndDeleteFolders()
  Set fRoot = FSO.GetFile(WScript.ScriptFullName).ParentFolder.ParentFolder
  
  date0 =  DateAdd("m", 1, Date)
  date1 =  DateAdd("m", -2, Date)

  msgbox Right(Year(date0),2)
  msgbox Month(date1)

  for each file in fRoot.files
      msgbox file.name
      exit for
  next 

  MsgBox fRoot.Path
End Sub

Sub UpdateLinkToIraiFolders()
  url = "http://www.japannetbank.co.jp/service/payment/web_all/sample_zengin.csv"

  XHR.Open "GET", url, False
  XHR.Send
  If XHR.Status < 400 Then
      csv = XHR.responseText
      arr = Split(csv,",")
  End If 
  MsgBox csv
  For Each a In arr
    MsgBox a
    exit for
  Next
End Sub


Sub UpdateLinkToIraiFolders_All()
End Sub


Sub OpenLinkList()
  no = FSO.GetFile(WScript.ScriptFullName).ParentFolder.Name

  WSH.Run "https://www.google.co.jp/search?source=hp&q=" & no
End Sub


