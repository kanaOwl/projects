Attribute VB_Name = "Module111"
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
    counterAllMass% = 18
    NameValueOfWord = Array("date_close", "date_open", "date_open", "stud_fio", "prog_name", "reg_number", "hours", "post_fio1", "post1", "post_fio2", "post2", "post_fio3", "post3", "name_group", "name_group", "num_date", "num_date", "reg_num_let", "reg_num_let")
    ReDim NameValueOfExcel(0 To counterAllMass) As String
    NameColOfExcel = Array(9, 8, 8, 5, 3, 6, 11, 2, 3, 2, 3, 2, 3, 10, 10, 9, 9, 6, 6)
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    For counterNameStudent% = 2 To allStringMass
        Addresslv2$ = Addresslvl + "\" + CStr(Range("B" + CStr(counterNameStudent))) + "\" + "Diplom_Prikaz_ob_otkrytii"
        Addresslv3$ = Addresslv2 + "\" + CStr(Range("I" + CStr(counterNameStudent)))
        Addresslv4$ = Addresslv3 + "\" + CStr(Range("K" + CStr(counterNameStudent))) + ".docx"
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        If Dir(Addresslv2, vbDirectory) = "" And StrComp("Диплом", CStr(Range("B" + CStr(counterNameStudent)))) = 0 Then
            MkDir (Addresslv2)
        End If
        If Dir(Addresslv3, vbDirectory) = "" And StrComp("Диплом", CStr(Range("B" + CStr(counterNameStudent)))) = 0 Then
            MkDir (Addresslv3)
        End If
        If Dir(Addresslv4, vbDirectory) = "" And StrComp("Диплом", CStr(Range("B" + CStr(counterNameStudent)))) = 0 Then
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
             For counterOfNameValueOfExcel% = 0 To 18
                Windows(NameDBDoc).Activate
                If counterOfNameValueOfExcel < 7 Then
                    Worksheets("Основное").Activate
                    NameValueOfExcel(counterOfNameValueOfExcel) = Cells(counterNameStudent, NameColOfExcel(counterOfNameValueOfExcel)).Text
		ElseIf counterOfNameValueOfExcel > 6 And counterOfNameValueOfExcel < 13 Then
                    Worksheets("Подписанты").Activate
                    NameValueOfExcel(counterOfNameValueOfExcel) = Cells(2, NameColOfExcel(counterOfNameValueOfExcel)).Text
                ElseIf counterOfNameValueOfExcel > 12 And counterOfNameValueOfExcel < 15 Then
                    Worksheets("Основное").Activate
                    NameValueOfExcel(counterOfNameValueOfExcel) = Cells(counterNameStudent, NameColOfExcel(counterOfNameValueOfExcel)).Text
                ElseIf counterOfNameValueOfExcel > 14 And counterOfNameValueOfExcel < 17 Then
                    Worksheets("Основное").Activate
                    NameValueOfExcel(counterOfNameValueOfExcel) = Left(Left(CStr(Range("I" + CStr(counterNameStudent))), 5), 2) + Right(Left(CStr(Range("I" + CStr(counterNameStudent))), 5), 2)
                ElseIf counterOfNameValueOfExcel > 16 And counterOfNameValueOfExcel < 19 Then
                    Worksheets("Основное").Activate
                    NameValueOfExcel(counterOfNameValueOfExcel) = Left((Cells(counterNameStudent, NameColOfExcel(counterOfNameValueOfExcel)).Text), 2)
                End If
                Worksheets("Основное").Activate
            Next
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            FileCopy Addresslv2 + ".docx", Addresslv4
            Set wdDoc = wdApp.Documents.Open(Addresslv4)
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            QuantityStringOfTable% = 0
            For counterStudentOfTable% = 2 To allStringMass
                If StrComp(NameValueOfExcel(0), Cells(counterStudentOfTable, 9).Text) = 0 And StrComp(NameValueOfExcel(6), Cells(counterStudentOfTable, 11).Text) = 0 And StrComp("Диплом", CStr(Range("B" + CStr(counterStudentOfTable)))) = 0 Then
                    QuantityStringOfTable = QuantityStringOfTable + 1
                End If
            Next
            Symbol = InStr(wdDoc.Range(1), "tab")
            Set tblNew = wdDoc.Tables.Add(Range:=wdDoc.Range(Start:=Symbol + 4, End:=Symbol + 4), NumRows:=QuantityStringOfTable, NumColumns:=1) 'quantitySimbol$ = Len(NameValueOfExcel(4))'Set tblNew = wdDoc.Tables.Add(Range:=wdDoc.Range(Start:=1010 + quantitySimbol, End:=1010 + quantitySimbol), NumRows:=QuantityStringOfTable, NumColumns:=1)
            counterPositionStudentOfTable% = 2
            For counterStudentOfTable% = 2 To allStringMass
                If StrComp(NameValueOfExcel(0), Cells(counterStudentOfTable, 9).Text) = 0 And StrComp(NameValueOfExcel(6), Cells(counterStudentOfTable, 11).Text) = 0 And StrComp("Диплом", CStr(Range("B" + CStr(counterStudentOfTable)))) = 0 Then
                    tblNew.Cell(Row:=counterPositionStudentOfTable - 1, Column:=1).Range.InsertAfter Text:=Space(15) + Range("E" + CStr(counterStudentOfTable))
                    counterPositionStudentOfTable = counterPositionStudentOfTable + 1
                End If
            Next
            For counter1234% = 0 To counterAllMass
                wdDoc.Range.Find.Execute FindText:=NameValueOfWord(counter1234), ReplaceWith:=NameValueOfExcel(counter1234)
            Next
            wdDoc.Range.Find.Execute FindText:="yyear", ReplaceWith:=Year(Now)
            wdDoc.Range.Find.Execute FindText:="yyear", ReplaceWith:=Year(Now)
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            wdDoc.Save
            wdDoc.Close
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

