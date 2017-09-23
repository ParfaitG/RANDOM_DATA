Option Explicit

' EXCEL VBA

Sub BuildRandomData()
On Error GoTo ErrHandle
    Dim j As Integer, i As Integer, x As Integer
    Dim new_wb As Workbook
    Dim var As Variant
    Dim strFile As String
    Dim epoch As Long: epoch = DateDiff("s", #1/1/1970#, Now())
    
    Application.ScreenUpdating = False
    For j = 1 To 10
        Set new_wb = Workbooks.Add
        
        With new_wb.Worksheets("Sheet1")
            i = 1
            For Each var In Array("ID", "GROUP", "NUM1", "NUM2", "BOOL", "DATE")
                .Cells(1, i) = var
                i = i + 1
            Next var
            
            x = Rnd(-1)
            Randomize 47
                
            For i = 2 To 20
                .Cells(i, 1) = CInt(15 * Rnd() + 1)                              ' ID
                .Cells(i, 2) = Chr(CInt(Int((90 - 65 + 1) * Rnd())) + 65)        ' GROUP
                .Cells(i, 3) = Rnd()                                             ' NUM1
                .Cells(i, 4) = Rnd() * 100                                       ' NUM2
                .Cells(i, 5) = CBool(Round(Rnd(), 0))                            ' BOOL
                .Cells(i, 6) = DateAdd("s", CLng(Int((epoch + 1) * Rnd())), _
                                       CDate("1/1/1970 00:00:00"))               ' DATE
            Next i
        End With
        
        strFile = ThisWorkbook.Path & "\RandomData" & j & ".csv"
        If Len(Dir(strFile, vbDirectory)) > 0 Then
            Kill strFile
        End If
        
        new_wb.SaveAs Filename:=strFile, FileFormat:=xlCSV, CreateBackup:=False
                
        new_wb.Close SaveChanges:=False
    Next j

    Application.ScreenUpdating = True
    MsgBox "Successfully outputted csv files!", vbInformation

ExitHandle:
    Set new_wb = Nothing
    Exit Sub

ErrHandle:
    MsgBox Err.Number & " - " & Err.Description, vbCritical
    Application.ScreenUpdating = True
    Resume ExitHandle

End Sub
