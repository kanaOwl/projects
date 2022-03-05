Attribute VB_Name = "Module1122"
Sub Макрос2()
Dim wdApp As Object
Dim wdDoc As Object
Dim today As String
Application.ScreenUpdating = False
On Error GoTo ScanError
HomeDir$ = ThisWorkbook.Path
Worksheets("Основное").Activate
NameDBDoc$ = ActiveWorkbook.Name
Set wdApp = CreateObject("Word.Application")
    allStringMass% = Cells(Rows.Count, 2).End(xlUp).Row
    Addresslvl$ = ActiveWorkbook.Path
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    counterAllMass% = 10
    NameValueOfWord = Array("date_close", "date_close", "date_open", "stud_fio", "prog_name", "reg_number", "hours", "post_fio1", "post1", "post_fio2", "post2")
    ReDim NameValueOfExcel(0 To counterAllMass) As String
    NameColOfExcel = Array(9, 9, 8, 5, 3, 6, 11, 2, 3, 2, 3)
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
   For counterNameStudent% = 2 To allStringMass
        Addresslv2$ = Addresslvl + "\" + CStr(Range("B" + CStr(counterNameStudent))) + "\" + "KCN_Blank"
        Addresslv3$ = Addresslv2 + "\" + CStr(Range("I" + CStr(counterNameStudent)))
        Addresslv4$ = Addresslv3 + "\" + CStr(Range("E" + CStr(counterNameStudent)) + "_" + Left(Range("F" + CStr(counterNameStudent)), 2) + Right(Range("F" + CStr(counterNameStudent)), 3)) + ".docx"
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        If Dir(Addresslv2, vbDirectory) = "" And StrComp("КЦН", CStr(Range("B" + CStr(counterNameStudent)))) = 0 Then
            MkDir (Addresslv2)
        End If
        If Dir(Addresslv3, vbDirectory) = "" And StrComp("КЦН", CStr(Range("B" + CStr(counterNameStudent)))) = 0 Then
            MkDir (Addresslv3)
        End If
        If Dir(Addresslv4, vbDirectory) = "" And StrComp("КЦН", CStr(Range("B" + CStr(counterNameStudent)))) = 0 Then
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            For counter123% = 0 To 10
                Windows(NameDBDoc).Activate
                If counter123 < 7 Then
                    Worksheets("Основное").Activate
                    NameValueOfExcel(counter123) = Cells(counterNameStudent, NameColOfExcel(counter123)).Text
                ElseIf counter123 < 9 And counter123 > 6 Then
                    Worksheets("Подписанты").Activate
                    NameValueOfExcel(counter123) = Cells(2, NameColOfExcel(counter123)).Text
                ElseIf counter123 < 11 And counter123 > 8 Then
                    Worksheets("Подписанты").Activate
                    NameValueOfExcel(counter123) = Cells(3, NameColOfExcel(counter123)).Text
                End If
                    Worksheets("Основное").Activate
            Next
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            FileCopy Addresslv2 + ".docx", Addresslv4
            Set wdDoc = wdApp.Documents.Open(Addresslv4)
            For counter1234% = 0 To counterAllMass
                wdDoc.Range.Find.Execute FindText:=NameValueOfWord(counter1234), ReplaceWith:=NameValueOfExcel(counter1234)
            Next
            wdDoc.Save
            wdDoc.Close
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        End If
    Next
    Worksheets("Создать").Activate
    MsgBox "Загрузка завершена"
Exit Sub
ScanError:
    MsgBox "Необходимо провериь данные в таблице, возможно имеются некорректные данные"
    Exit Sub
    Resume Next
End Sub
