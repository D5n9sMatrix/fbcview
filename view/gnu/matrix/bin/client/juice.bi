#ifdef __fb_quote__
Function Tree##nameTree.kthSmallestNode(node As Tree##nameTree Ptr) As Tree##nameTree Ptr
	Do While Not node->nodeLeft = 0
		node = node->nodeLeft
	Loop
	Return node
End Function
#endif