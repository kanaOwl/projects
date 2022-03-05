Attribute VB_Name = "Module1"
Sub Макрос2()
Dim wdApp As Object
Dim wdDoc As Object
Dim today As String
Application.ScreenUpdating = False
On Error GoTo ScanError
HomeDir$ = ThisWorkbook.Path
NameDBDoc$ = ActiveWorkbook.Name
Worksheets("Основное").Activate
Set wdApp = CreateObject("Word.Application")
    allStringMass% = Cells(Rows.Count, 2).End(xlUp).Row
    Addresslvl$ = ActiveWorkbook.Path
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    counterAllMass% = 28
    NameValueOfWord = Array("date_close", "date_close", "date_close", "date_close", "date_close", "date_open", "date_open", "stud_fio", "stud_fio", "prog_name", "prog_name", "prog_name", "reg_number", "reg_number", "name_group", "name_group", "hours", "post_fio1", "post_fio1", "post1", "post1", "post_fio2", "post_fio2", "post2", "post2", "num_date", "num_date", "reg_num_let", "reg_num_let")
    ReDim NameValueOfExcel(0 To counterAllMass) As String
    NameColOfExcel = Array(9, 9, 9, 9, 9, 8, 8, 5, 5, 3, 3, 3, 6, 6, 10, 10, 11, 2, 2, 3, 3, 2, 2, 3, 3, 9, 9, 6, 6)
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    For counterNameStudent% = 2 To allStringMass
        Addresslv2$ = Addresslvl + "\" + CStr(Range("B" + CStr(counterNameStudent))) + "\" + "Diplom_Blank"
        Addresslv3$ = Addresslv2 + "\" + CStr(Range("I" + CStr(counterNameStudent)))
        Addresslv4$ = Addresslv3 + "\" + CStr(Range("E" + CStr(counterNameStudent)) + "_" + Left(Range("F" + CStr(counterNameStudent)), 2) + Right(Range("F" + CStr(counterNameStudent)), 3)) + ".docx"
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        If Dir(Addresslv2, vbDirectory) = "" And StrComp("Диплом", CStr(Range("B" + CStr(counterNameStudent)))) = 0 Then
            MkDir (Addresslv2)
        End If
        If Dir(Addresslv3, vbDirectory) = "" And StrComp("Диплом", CStr(Range("B" + CStr(counterNameStudent)))) = 0 Then
            MkDir (Addresslv3)
        End If
        If Dir(Addresslv4, vbDirectory) = "" And StrComp("Диплом", CStr(Range("B" + CStr(counterNameStudent)))) = 0 Then
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
             For counter123% = 0 To counterAllMass
                Windows(NameDBDoc).Activate
                If counter123 < 17 Then
                    Worksheets("Основное").Activate
                    NameValueOfExcel(counter123) = Cells(counterNameStudent, NameColOfExcel(counter123)).Text
                ElseIf counter123 < 21 And counter123 > 16 Then
                    Worksheets("Подписанты").Activate
                    NameValueOfExcel(counter123) = Cells(2, NameColOfExcel(counter123)).Text
                ElseIf counter123 < 25 And counter123 > 20 Then
                    Worksheets("Подписанты").Activate
                    NameValueOfExcel(counter123) = Cells(3, NameColOfExcel(counter123)).Text
                ElseIf counter123 < 27 And counter123 > 24 Then
                    Worksheets("Основное").Activate
                    NameValueOfExcel(counter123) = Left(Left(CStr(Range("I" + CStr(counterNameStudent))), 5), 2) + Right(Left(CStr(Range("I" + CStr(counterNameStudent))), 5), 2)
                ElseIf counter3block < 29 And counter123 > 26 Then
                    Worksheets("Основное").Activate
                    NameValueOfExcel(counter123) = Left((Cells(counterNameStudent, NameColOfExcel(counter123)).Text), 2)
                End If
             Next
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
             FileCopy Addresslv2 + ".docx", Addresslv4
             Set wdDoc = wdApp.Documents.Open(Addresslv4)
                For counterOfWord% = 0 To counterAllMass
                    wdDoc.Range.Find.Execute FindText:=NameValueOfWord(counterOfWord), ReplaceWith:=NameValueOfExcel(counterOfWord)
                Next
                wdDoc.Range.Find.Execute FindText:="yyear", ReplaceWith:=Year(Now)
                wdDoc.Range.Find.Execute FindText:="yyear", ReplaceWith:=Year(Now)
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

