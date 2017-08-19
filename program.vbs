
Set FSO = CreateObject("Scripting.FileSystemObject")
Set XHR = CreateObject("MSXML2.XMLHTTP")
Set WSH = WScript.CreateObject("WScript.Shell")

Select Case WScript.ScriptName
  Case "�t�H���_�̈ꊇ�쐬�E�폜.vbs"      : Call CreateAndDeleteFolders
  Case "�˗��t�H���_�����N���X�V.vbs"      : Call UpdateLinkToIraiFolders
  Case "�˗��t�H���_�����N���쐬.vbs"      : Call UpdateLinkToIraiFolders
  Case "�˗��t�H���_�����N���ꊇ�쐬.vbs"  : Call UpdateLinkToIraiFolders_All
  Case "�����N�ꗗ�\��.vbs"                : Call OpenLinkList
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


