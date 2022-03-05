Attribute VB_Name = "Module1"
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
    counterAllMass% = 12
    NameValueOfWord = Array("date_close", "name_group", "prog_name", "hours", "reg_num_let", "num_date", "post1", "post_fio1", "post_fio1", "post_fio2", "post_fio2", "post_fio3", "post_fio3")
    ReDim NameValueOfExcel(0 To counterAllMass) As String
    NameColOfExcel = Array(9, 10, 3, 11, 6, 9, 3, 2, 2, 2, 2, 2, 2)
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    For counterNameStudent% = 2 To allStringMass
        Addresslv2$ = Addresslvl + "\" + CStr(Range("B" + CStr(counterNameStudent))) + "\" + "Diplom_Protokol"
        Addresslv3$ = Addresslv2 + "\" + CStr(Range("I" + CStr(counterNameStudent)))
        Addresslv4$ = Addresslv3 + "\" + CStr(Range("K" + CStr(counterNameStudent))) + ".docx"
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        If Dir(Addresslv2, vbDirectory) = "" And StrComp("Диплом", CStr(Range("B" + CStr(counterNameStudent)))) = 0 Then
            MkDir (Addresslv2)
        End If
        If Dir(Addresslv3, vbDirectory) = "" And StrComp("Диплом", CStr(Range("B" + CStr(counterNameStudent)))) = 0 Then
            MkDir (Addresslv3)
        End If
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        If Dir(Addresslv4, vbDirectory) = "" And StrComp("Диплом", CStr(Range("B" + CStr(counterNameStudent)))) = 0 Then
            For counter3block% = 0 To counterAllMass
                Windows(NameDBDoc).Activate
                If counter3block < 4 Then
                    Worksheets("Основное").Activate
                    NameValueOfExcel(counter3block) = Cells(counterNameStudent, NameColOfExcel(counter3block)).Text
                ElseIf counter3block < 5 Then
                    NameValueOfExcel(counter3block) = Left((Cells(counterNameStudent, NameColOfExcel(counter3block)).Text), 2)
                ElseIf counter3block < 6 Then
                    NameValueOfExcel(counter3block) = Left(Left(CStr(Range("I" + CStr(counterNameStudent))), 5), 2) + Right(Left(CStr(Range("I" + CStr(counterNameStudent))), 5), 2)
                ElseIf counter3block < 7 Then
                    Worksheets("Подписанты").Activate
                    NameValueOfExcel(counter3block) = Cells(2, NameColOfExcel(counter3block)).Text
                ElseIf counter3block < 9 Then
                    Worksheets("Подписанты").Activate
                    NameValueOfExcel(counter3block) = Cells(2, NameColOfExcel(counter3block)).Text
                ElseIf counter3block < 11 Then
                    Worksheets("Подписанты").Activate
                    NameValueOfExcel(counter3block) = Cells(3, NameColOfExcel(counter3block)).Text
                ElseIf counter3block < 13 Then
                    Worksheets("Подписанты").Activate
                    NameValueOfExcel(counter3block) = Cells(4, NameColOfExcel(counter3block)).Text
                End If
            Next
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            Worksheets("Основное").Activate
            quantitySimbol$ = Len(NameValueOfExcel(2))
            FileCopy Addresslv2 + ".docx", Addresslv4
            Set wdDoc = wdApp.Documents.Open(Addresslv4)
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            QuantityStringOfTable% = 1
            For counterStudentOfTable% = 2 To allStringMass
                If StrComp(NameValueOfExcel(0), Cells(counterStudentOfTable, 9).Text) = 0 And StrComp(Range("K" + CStr(counterNameStudent)), Cells(counterStudentOfTable, 11).Text) = 0 And StrComp("Диплом", CStr(Range("B" + CStr(counterStudentOfTable)))) = 0 Then
                    QuantityStringOfTable = QuantityStringOfTable + 1
                End If
            Next
            Symbol = InStr(wdDoc.Range(1), "tab")
            Set tblNew = wdDoc.Tables.Add(Range:=wdDoc.Range(Start:=Symbol + 5, End:=Symbol + 5), NumRows:=QuantityStringOfTable, NumColumns:=5, DefaultTableBehavior:=1, AutoFitBehavior:=1) 'Set tblNew = wdDoc.Tables.Add(Range:=wdDoc.Range(Start:=894, End:=894), NumRows:=QuantityStringOfTable, NumColumns:=5, DefaultTableBehavior:=1, AutoFitBehavior:=1)
            tblNew.Borders.OutsideLineStyle = 1
            tblNew.Borders.InsideLineStyle = 1
            tblNew.Cell(Row:=1, Column:=1).Range.InsertAfter Text:="№"
            tblNew.Cell(Row:=1, Column:=2).Range.InsertAfter Text:="Фамилия, имя, отчество"
            tblNew.Cell(Row:=1, Column:=3).Range.InsertAfter Text:="Результат"
            tblNew.Cell(Row:=1, Column:=4).Range.InsertAfter Text:="Рег.№ диплома"
            tblNew.Cell(Row:=1, Column:=5).Range.InsertAfter Text:="Рег.№ приложения к диплому"
            counterPositionStudentOfTable% = 2
            For counterStudentOfTable% = 2 To allStringMass
                If StrComp(NameValueOfExcel(0), Cells(counterStudentOfTable, 9).Text) = 0 And StrComp(Range("K" + CStr(counterNameStudent)), Cells(counterStudentOfTable, 11).Text) = 0 And StrComp("Диплом", CStr(Range("B" + CStr(counterStudentOfTable)))) = 0 Then
                    tblNew.Cell(Row:=counterPositionStudentOfTable, Column:=1).Range.InsertAfter Text:=CStr(counterPositionStudentOfTable - 1)
                    tblNew.Cell(Row:=counterPositionStudentOfTable, Column:=2).Range.InsertAfter Text:=Range("E" + CStr(counterStudentOfTable))
                    tblNew.Cell(Row:=counterPositionStudentOfTable, Column:=3).Range.InsertAfter Text:="Сдано"
                    tblNew.Cell(Row:=counterPositionStudentOfTable, Column:=4).Range.InsertAfter Text:=Range("F" + CStr(counterStudentOfTable))
                    tblNew.Cell(Row:=counterPositionStudentOfTable, Column:=5).Range.InsertAfter Text:=Left(Range("F" + CStr(counterStudentOfTable)), 3) + Right("00" + CStr(CInt(Right(Range("F" + CStr(counterStudentOfTable)), 3)) + 1), 3) 'Left+0+Right'
                    counterPositionStudentOfTable = counterPositionStudentOfTable + 1
                End If
            Next
            For counter1234% = 0 To counterAllMass
                wdDoc.Range.Find.Execute FindText:=NameValueOfWord(counter1234), ReplaceWith:=NameValueOfExcel(counter1234)
            Next
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

