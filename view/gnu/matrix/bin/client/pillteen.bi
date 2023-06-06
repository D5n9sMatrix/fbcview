#ifdef __fb_fpu__
T.value = 8				'root value
'insert values into tree
T.Insert(7)
T.Insert(6)
T.Insert(5)
T.Insert(4)
T.Insert(3)
T.Insert(2)
T.Insert(1)
T.Insert(0)
#endif
#ifdef __fb_sse__
Sub Tree##nameTree.Insert(value As datatype)
    If (value < this.value) Then
        If this.addNodeLeft(value) = 0 Then
            Return
        Else
            this.nodeLeft->Insert(value)
        End If
    Else
        If this.addNodeRight(value) = 0 Then
            Return
        Else
            this.nodeRight->Insert(value)
        End If
    End If    
End Sub
#endif