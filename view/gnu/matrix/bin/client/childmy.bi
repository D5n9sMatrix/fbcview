#ifdef __fb_sse__
#Macro MakeTree(datatype, nameTree)
Type Tree##nameTree
    Public:
        value As datatype
        Declare Sub printPreorder()
        Declare Sub printPostorder()
        Declare Sub printInorder()
        Declare Function doesNodeExistInBST(value As datatype) As Boolean
        Declare Function getBinaryTreeHeight() As Integer
        Declare Sub Insert(value As datatype)
        Declare Function deleteValue(value As datatype) As Boolean
        Declare Destructor()
    Private:
        nodeLeft As Tree##nameTree Ptr
        nodeRight As Tree##nameTree Ptr
        Declare Function addNodeLeft(value As datatype) As Integer
        Declare Function addNodeRight(value As datatype) As Integer
        Declare Function searchParentNode(value As datatype) Byref As Tree##nameTree
        Declare Sub insertNode(node AS Tree##nameTree)
        Declare Function insertNodeLeft(node AS Tree##nameTree) As Integer
        Declare Function insertNodeRight(node AS Tree##nameTree) As Integer
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

Function Tree##nameTree.insertNodeLeft(node AS Tree##nameTree) As Integer
	If this.nodeLeft = 0 Then
		this.nodeLeft = @node
		Return 0
	EndIf
	Return -1
End Function

Function Tree##nameTree.insertNodeRight(node AS Tree##nameTree) As Integer
	If this.nodeRight = 0 Then
		this.nodeRight = @node
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

Function Tree##nameTree.doesNodeExistInBST(value As datatype) As Boolean
    if @this = 0 Then
        Return False
    elseif this.value = value Then
        Return True
    else
        ' if the node we're at is smaller than the value we're looking for, traverse on the right side
        if value > this.value Then
            Return this.nodeRight->doesNodeExistInBST(value)
        else
            ' if the node we're at is bigger than the value we're looking for, traverse the left side
            Return this.nodeLeft->doesNodeExistInBST(value)
        Endif
    Endif	
End Function

Function Tree##nameTree.searchParentNode(value As datatype) Byref As Tree##nameTree
    Static as Tree##nameTree Ptr p
    if this.value = value then
        Return *p
    else
        p = @this
        if value > this.value then
            Return this.nodeRight->searchParentNode(value)
        else
            Return this.nodeLeft->searchParentNode(value)
        end if
    end if
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

Sub Tree##nameTree.insertNode(node AS Tree##nameTree)
    If (node.value < this.value) Then
        If this.insertNodeLeft(node) = 0 Then
            Return
        Else
            this.nodeLeft->insertNode(node)
        End If
    Else
        If this.insertNodeRight(node) = 0 Then
            Return
        Else
            this.nodeRight->insertNode(node)
        End If
    End If    
End Sub

Function Tree##nameTree.deleteValue(value As datatype) As Boolean
    If (this.value = value) Or (this.doesNodeExistInBST(value) = False) Then
        Return False
    End If
    
    Dim Byref As Tree##nameTree parentNode = this.searchParentNode(value)
    if parentNode.nodeLeft->value = value then
        dim as Tree##nameTree ptr p = parentNode.nodeLeft
        parentNode.nodeLeft = p->nodeLeft
        p->nodeLeft = 0
        if p->nodeRight <> 0 then
            this.insertNode(*p->nodeRight)
            p->nodeRight = 0
        end if
        Delete p
    else
        dim as Tree##nameTree ptr p = parentNode.nodeRight
        parentNode.nodeRight = p->nodeRight
        p->nodeRight = 0
        if p->nodeLeft <> 0 then
            this.insertNode(*p->nodeLeft)
            p->nodeLeft = 0
        end if
        Delete p
    end if
    return True
End Function
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
Print
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

Print
b=T.deleteValue(6)
Print "6 is deleted in tree ? " & b
Print

T.printInorder()

Sleep

#endif