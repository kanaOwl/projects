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
    counterAllMass% = 11
    NameValueOfWord = Array("date_close", "date_close", "prog_name", "stud_fio", "prog_name", "reg_number", "hours", "name_group", "post_fio1", "post_fio1", "num_date", "reg_num_let")
    ReDim NameValueOfExcel(0 To counterAllMass) As String
    NameColOfExcel = Array(9, 9, 3, 5, 3, 6, 11, 10, 2, 2, 9, 6)
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
   For counterNameStudent% = 2 To allStringMass
        Addresslv2$ = Addresslvl + "\" + CStr(Range("B" + CStr(counterNameStudent))) + "\" + "Rabochie_Blank_Sertifikat"
        Addresslv3$ = Addresslv2 + "\" + CStr(Range("I" + CStr(counterNameStudent)))
        Addresslv4$ = Addresslv3 + "\" + CStr(Range("E" + CStr(counterNameStudent)) + "_" + Left(Range("F" + CStr(counterNameStudent)), 2) + Right(Range("F" + CStr(counterNameStudent)), 3)) + ".docx"
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        If Dir(Addresslv2, vbDirectory) = "" And StrComp("Рабочие", CStr(Range("B" + CStr(counterNameStudent)))) = 0 Then
            MkDir (Addresslv2)
        End If
        If Dir(Addresslv3, vbDirectory) = "" And StrComp("Рабочие", CStr(Range("B" + CStr(counterNameStudent)))) = 0 Then
            MkDir (Addresslv3)
        End If
        If Dir(Addresslv4, vbDirectory) = "" And StrComp("Рабочие", CStr(Range("B" + CStr(counterNameStudent)))) = 0 Then
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            For counter123% = 0 To 11
                Windows(NameDBDoc).Activate
                If counter123 < 8 Then
                    Worksheets("Основное").Activate
                    NameValueOfExcel(counter123) = Cells(counterNameStudent, NameColOfExcel(counter123)).Text
                ElseIf counter123 < 10 And counter123 > 7 Then
                    Worksheets("Подписанты").Activate
                    NameValueOfExcel(counter123) = Cells(2, NameColOfExcel(counter123)).Text
                ElseIf counter123 < 11 And counter123 > 9 Then
                    Worksheets("Основное").Activate
                    NameValueOfExcel(counter123) = Left(Left(CStr(Range("I" + CStr(counterNameStudent))), 5), 2) + Right(Left(CStr(Range("I" + CStr(counterNameStudent))), 5), 2)
                ElseIf counter123 < 12 And counter123 > 10 Then
                    Worksheets("Основное").Activate
                    NameValueOfExcel(counter123) = Left((Cells(counterNameStudent, NameColOfExcel(counter123)).Text), 2)
                End If
                Worksheets("Основное").Activate
            Next
            FileCopy Addresslv2 + ".docx", Addresslv4
            Set wdDoc = wdApp.Documents.Open(Addresslv4)
            For counter1234% = 0 To counterAllMass
                wdDoc.Range.Find.Execute FindText:=NameValueOfWord(counter1234), ReplaceWith:=NameValueOfExcel(counter1234)
            Next
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

