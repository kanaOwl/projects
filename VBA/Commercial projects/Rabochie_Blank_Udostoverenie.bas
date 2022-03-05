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
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    counterAllMass% = 7
    NameValueOfWord = Array("date_close", "date_close", "stud_fio", "prog_name", "reg_number", "name_group", "num_date", "reg_num_let")
    ReDim NameValueOfExcel(0 To counterAllMass) As String
    NameColOfExcel = Array(9, 9, 5, 3, 6, 10, 9, 6)
    quantityStudentOfGroup% = 0
    counterDocument% = 1
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    Addresslvl$ = ActiveWorkbook.Path
    Addresslv2$ = Addresslvl + "\" + "Рабочие" + "\" + "Rabochie_Blank_Udostoverenie"
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    If Dir(Addresslv2, vbDirectory) = "" Then
        MkDir (Addresslv2)
    End If
    Windows(NameDBDoc).Activate
    Worksheets("Основное").Activate
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    For counterNameStudent% = 2 To allStringMass
        If StrComp("Рабочие", Range("B" + CStr(counterNameStudent))) = 0 Then
            For counter4block% = 0 To 7
                If counter4block < 6 Then
                    NameValueOfExcel(counter4block) = Cells(counterNameStudent, NameColOfExcel(counter4block)).Text
                ElseIf counter4block < 7 And counter4block > 5 Then
                    NameValueOfExcel(counter4block) = Left(Left(Range("I" + CStr(counterNameStudent)), 5), 2) + Right(Left(Range("I" + CStr(counterNameStudent)), 5), 2)
                ElseIf counter4block < 8 And counter4block > 6 Then
                    NameValueOfExcel(counter4block) = Left((Cells(counterNameStudent, NameColOfExcel(counter4block)).Text), 2)
                End If
            Next
            If quantityStudentOfGroup < 4 Then
                If quantityStudentOfGroup = 0 Then
                    Do While Dir(Addresslv2 + "\" + CStr(counterDocument) + ".docx", vbDirectory) <> ""
                        counterDocument = counterDocument + 1
                    Loop
                    FileCopy Addresslv2 + ".docx", Addresslv2 + "\" + CStr(counterDocument) + ".docx"
                    Set wdDoc = wdApp.Documents.Open(Addresslv2 + "\" + CStr(counterDocument) + ".docx")
                End If
                For counter1234% = 0 To counterAllMass
                    wdDoc.Range.Find.Execute FindText:=NameValueOfWord(counter1234), ReplaceWith:=NameValueOfExcel(counter1234)
                Next
		wdDoc.Range.Find.Execute FindText:="yyear", ReplaceWith:=Year(Now)
            End If
            If quantityStudentOfGroup = 3 Then
                wdDoc.Save
                wdDoc.Close
                quantityStudentOfGroup = 0
                counterDocument = counterDocument + 1
            ElseIf counterNameStudent = allStringMass Then
                wdDoc.Save
                wdDoc.Close
            Else
                quantityStudentOfGroup = quantityStudentOfGroup + 1
            End If
        End If
    Next
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    Worksheets("Создать").Activate
    MsgBox "Загрузка завершена"
Exit Sub
ScanError:
    MsgBox "Необходимо провериь данные в таблице, возможно имеются некорректные данные"
    Exit Sub
    Resume Next
End Sub
