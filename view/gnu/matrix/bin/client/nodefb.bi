Type Tree##nameTree
    Public:
        value As datatype
        Declare Sub printPreorder()
        Declare Sub printPostorder()
        Declare Sub printInorder()
        Declare Function doesNodeExistInBST(searchValue As datatype) As Boolean
        Declare Function getBinaryTreeHeight() As Integer
	Declare Function getBinaryTreeSize() As Integer
        Declare Sub Insert(value As datatype)
	Declare Sub removeNode(value As datatype)
        Declare Destructor()
    Private:
    bstSize As Integer = 0
        nodeLeft As Tree##nameTree Ptr
        nodeRight As Tree##nameTree Ptr
	Declare Function getSize() As Integer
        Declare Function addNodeLeft(value As datatype) As Integer
        Declare Function addNodeRight(value As datatype) As Integer
        
-->	Declare Function kthSmallestNode(node As Tree##nameTree Ptr) As Tree##nameTree Ptr

End Type


Function Tree##nameTree.kthSmallestNode(node As Tree##nameTree Ptr) As Tree##nameTree Ptr
	Do While Not node.nodeLeft = 0
		node = node.nodeLeft
	Loop
	Return node
End Function
