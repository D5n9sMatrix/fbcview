#ifdef __fb_ver_major__
#Include "btree.bi"

MakeTree(Double, T1)		'make a double tree, with name T1
Dim b As Boolean			'b as boolean
Dim height As Integer		'height as integer
Dim T As TreeT1				'Dim tree to variable T
Dim pT As TreeT1 Ptr		'pT a pointer to TreeT1 T
pT = @T						'pT points to T

pT->value = 8				'root value

'insert values into tree
Insert(pT, 4)
Insert(pT, 12)
Insert(pT, 2)
Insert(pT, 6)
Insert(pT, 10)
Insert(pT, 14)
Insert(pT, 1)
Insert(pT, 3)
Insert(pT, 5)
Insert(pT, 7)
Insert(pT, 9)
Insert(pT, 11)
Insert(pT, 13)
Insert(pT, 15)
Insert(pT, 15.4)

'print tree
'printPreorder(pT)
printInorder(pT)
'printPostorder(pT)

'search for 6
b=doesNodeExistInBST(pT, 6)
Print "6 is found in tree ? " & b

'search for 5.4
b=doesNodeExistInBST(pT, 5.4)
Print "5.4 is found in tree ? " & b

'get tree height
height = getBinaryTreeHeight(pT)
Print "Binary Tree height=" & height

Sleep
End

#endif

#ifdef __fb_ver_minor__
#Macro MakeTree(datatype, nameTree)
Type Tree##nameTree
    Public:
        value As datatype
        Declare Sub printPreorder()
        Declare Sub printPostorder()
        Declare Sub printInorder()
        Declare Function doesNodeExistInBST(searchValue As datatype) As Boolean
        Declare Function getBinaryTreeHeight() As Integer
        Declare Sub Insert(value As datatype)
        Declare Destructor()
    Private:
        nodeLeft As Tree##nameTree Ptr
        nodeRight As Tree##nameTree Ptr
        Declare Function addNodeLeft(value As datatype) As Integer
        Declare Function addNodeRight(value As datatype) As Integer
End Type

Destructor Tree##nameTree()
	If this.nodeLeft <> 0 Then
		this.value = 0
		Delete this.nodeLeft
	EndIf
	If this.nodeRight <> 0 Then
		this.value = 0
		Delete this.nodeRight
	EndIf
End Destructor

Function Tree##nameTree.addNodeLeft(value As datatype) As Integer
	If this.nodeLeft = 0 Then
		this.nodeLeft = New Tree##nameTree
		this.nodeLeft->value = value
		Return 0
	EndIf
	Return -1
End Function

Function Tree##nameTree.addNodeRight(value As datatype) As Integer
	If this.nodeRight = 0 Then
		this.nodeRight = New Tree##nameTree
		this.nodeRight->value = value
		Return 0
	EndIf
	Return -1
End Function


Sub Tree##nameTree.printPreorder()
	If @this = 0 Then
		Return
	Endif
	Print this.value & " " 'process node
	this.nodeLeft->printPreorder() 'recurse on left
	this.nodeRight->printPreorder() 'recurse on right
End Sub

Sub Tree##nameTree.printPostorder()
	If @this = 0 Then
		Return
	Endif
	this.nodeLeft->printPreorder() 'recurse on left
	this.nodeRight->printPreorder() 'recurse on right
	Print this.value & " " 'process node
End Sub

Sub Tree##nameTree.printInorder()
	If @this = 0 Then
		Return
	Endif
	this.nodeLeft->printPreorder() 'recurse on left
	Print this.value & " " 'process node
	this.nodeRight->printPreorder() 'recurse on right	
End Sub

Function Tree##nameTree.doesNodeExistInBST(searchValue As datatype) As Boolean
    if @this = 0 Then
        Return False
    elseif this.value = searchValue Then
        Return True
    else
        ' if the node we're at is smaller than the value we're looking for, traverse on the right side
        if searchValue > this.value Then
            Return this.nodeRight->doesNodeExistInBST(searchValue)
        else
            ' if the node we're at is bigger than the value we're looking for, traverse the left side
            Return this.nodeLeft->doesNodeExistInBST(searchValue)
        Endif
    Endif	
End Function

Function Tree##nameTree.getBinaryTreeHeight() As Integer
	If @this = 0 Then
		Return -1
	EndIf

    Dim leftHeight As Integer = this.nodeLeft->getBinaryTreeHeight()
    Dim rightHeight As Integer = this.nodeRight->getBinaryTreeHeight()

    if leftHeight > rightHeight Then
        Return leftHeight + 1
    else
        return rightHeight + 1
    Endif	
End Function

Sub Tree##nameTree.Insert(value As datatype)		
		If this.nodeLeft = 0 Or this.nodeRight = 0 Then		
			If (value < this.value) Then
				this.addNodeLeft(value)
				Return
			Else
				this.addNodeRight(value)
				Return
			Endif
		EndIf

		If this.nodeLeft <> 0 Or this.nodeRight <> 0 Then
			If (value < this.value) Then
				this.nodeLeft->Insert(value)
			Else
				this.nodeRight->Insert(value)
			Endif
		EndIf		
End Sub
#Endmacro



'#Include "btree.bi"

MakeTree(Double, T1)		'make a double tree, with name T1
Dim b As Boolean			'b as boolean
Dim height As Integer		'height as integer
Dim T As TreeT1				'Dim tree to variable T

T.value = 8				'root value

'insert values into tree
T.Insert(4)
T.Insert(12)
T.Insert(2)
T.Insert(6)
T.Insert(10)
T.Insert(14)
T.Insert(1)
T.Insert(3)
T.Insert(5)
T.Insert(7)
T.Insert(9)
T.Insert(11)
T.Insert(13)
T.Insert(15)
T.Insert(15.4)

'T.printPreorder()
T.printInorder()
'T.printPostorder()

'search for 6
b=T.doesNodeExistInBST(6)
Print "6 is found in tree ? " & b

'search for 5.4
b=T.doesNodeExistInBST(5.4)
Print "5.4 is found in tree ? " & b

'get tree height
height = T.getBinaryTreeHeight()
Print "Binary Tree height=" & height

Sleep

#endif
