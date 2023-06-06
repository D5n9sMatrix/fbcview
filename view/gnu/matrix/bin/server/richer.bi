#include "file.bi"
Function tally(somestring As String,partstring As String,arr() As Long) As Long
      Dim As Long i,j,ln,lnp,count
      If Instr(somestring,partstring)=0 Then Return 0
      ln=Len(somestring)
      lnp=Len(partstring)
      Redim arr(1 To ln)'start with a big enough array to handle all circumstances
      count=0
      i=-1
      Do
            i+=1
            If somestring[i] <> partstring[0] Then Continue Do
            If somestring[i] = partstring[0] Then 'might be!
                  For j=0 To lnp-1 
                        If somestring[j+i]<>partstring[j] Then Continue Do 'not this time!
                  Next j
            End If
            ' if got here then a partstring has been found
            count+=1
            arr(count)=i+1 
            i=i+lnp-1
      Loop Until i>=ln-1 
      Redim Preserve arr(1 To count)'resize the output array
      Return count
End Function

Sub showabit(s As String,position As Long,delim As String) ' only to view some characters.
      Dim As String  g
      Locate Csrlin-1,50
      For n As Long=position-20 To position+20 +Len(delim)
            If n=position-1 Then Color 5
            If n=position+Len(delim)-1 Then Color 15
           if n<=len(s)-1 then 
                 if s[n]=0 then s[n]=asc("-")
           Print Chr(s[n]);
           end if
      Next n
      Print
End Sub


Function loadfile(file as string) as String
	If FileExists(file)=0 Then Print file;" not found":Sleep:end
   dim as long  f=freefile
    Open file For Binary Access Read As #f
    Dim As String text
    If Lof(f) > 0 Then
      text = String(Lof(f), 0)
      Get #f, , text
    End If
    Close #f
    return text
end Function


dim as string file="C:\Users\Computer\Desktop\fb\FreeBASIC-1.09.0-winlibs-gcc-9.3.0\bin\libexec\gcc\x86_64-w64-mingw32\9.3.0\cc1.exe"

Dim As String s=loadfile(file)
dim as double t
Randomize

      t=timer
      Color 15
      
      
      Dim As String LookFor=".dll"
      Print "Look for ";LookFor
      
      Redim As Long i()
      Var num=tally(s,LookFor,i())
      
      If num Then
            Print "position ","    found";Tab(59);"string near sought string"
            For n As Long=Lbound(i) To Ubound(i)
                  Print i(n);Tab(20);Mid(s,i(n),Len(LookFor)):showabit(s,i(n),LookFor)
            Next
            Print "tally = ";num
      Else
            Print "not found"
      End If
      Print
      print "Total time taken ";timer-t;"  seconds"
      Print "Press any key to end"
      Sleep
     
     
