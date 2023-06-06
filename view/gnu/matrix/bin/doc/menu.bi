#ifdef __fb_ver_major__
Private Sub MDIFormType.mnuFileOpen_Click(ByRef Sender As MenuItem)
	Form2.Show MDIForm
End Sub

Private Sub MDIFormType.mnuFileNew_Click(ByRef Sender As MenuItem)
	MsgBox "Place New Code here!"
End Sub
#endif
#ifdef __fb_ver_minor__
Private Sub MDIFormType.mnuFileOpen_Click(ByRef Sender As MenuItem)
	Dim frm As Form2Type Ptr
	frm = New Form2Type
	frm->Show MDIForm
End Sub

Private Sub MDIFormType.mnuFileNew_Click(ByRef Sender As MenuItem)
	Dim frm As Form2Type Ptr
	frm = New Form2Type
	frm->Show MDIForm
End Sub
#endif