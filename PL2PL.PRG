*   Obsíugiwane standardy:
*   L - Latin 2 (CP852)
*   M - Mazovia
*   W - Windows EE (CP1250)
*   I - ISO Latin 2 (ISO-8859-2)
*   B - Bez polskich znaczk¢w
*   E - Emulacja programowa (tylko wydruki)
/*
'cp852'         => [164, 143, 168, 157, 227, 224, 151, 141, 189, 165, 134, 169, 136, 228, 162, 152, 171, 190],
'mazovia'       => [143, 149, 144, 156, 165, 163, 152, 160, 161, 134, 141, 145, 146, 164, 162, 158, 166, 167],
'windows-1250'  => [165, 198, 202, 163, 209, 211, 140, 143, 175, 185, 230, 234, 179, 241, 243, 156, 159, 191],
'iso-8859-2'    => [161, 198, 202, 163, 209, 211, 166, 172, 175, 177, 230, 234, 179, 241, 243, 182, 188, 191],
*/             

 REQUEST HB_CODEPAGE_PL852
 REQUEST HB_CODEPAGE_PLMAZ
 REQUEST HB_CODEPAGE_PLWIN
 REQUEST HB_CODEPAGE_PLISO

*------------------------------------------------------------------------------*
Function pl2pl(cStr,cFrom,cTo)
*------------------------------------------------------------------------------*

#IfDef __HARBOUR__
 Local aTran:={{'L','PL852'},;
               {'M','PLMAZ'},;
               {'W','PLWIN'},;
               {'I','PLISO'}}
 Local cCPFrom:='',  cCPTo:='', nPoz, cStrTran
 
 If cFrom==cTo
    Return cStr
 EndIf  

 If (nPoz:=AScan(aTran,{|x| x[1]==cFrom}))>0
     cCPFrom:=aTran[nPoz][2]
 EndIf

 If (nPoz:=AScan(aTran,{|x| x[1]==cTo}))>0
     cCPTo:=aTran[nPoz][2]
 EndIf

 cStrTran:=Hb_translate(cStr,cCPFrom,cCPTo)

#Else

 Local aChar := {{"§","è","®","ù","„","‡","ó","ç","Ω","•","Ü","©","à","‰","¢","ò","´","æ"},; //L Latin 2 (CP852)
                 {"è","ï","ê","ú","•","£","ò","†","°","Ü","ç","ë","í","§","¢","û","¶","ß"},; //M Mazovia
                 {"•","∆"," ","£","—","”","å","è","Ø","π","Ê","Í","≥","Ò","Û","ú","ü","ø"},; //W Windows EE (CP1250)
                 {"°","∆"," ","£","—","”","¶","¨","Ø","±","Ê","Í","≥","Ò","Û","∂","º","ø"},; //I ISO Latin 2 (ISO-8859-2)
                 {"A","C","E","L","N","O","S","Z","Z","a","c","e","l","n","o","s","z","z"},; //B Bez
                 {"A,","C'","E,","L/","N'","O'","S'","Z'","Z-","a,","c'","e,","l/","n'","o'","s'","z'","z:"}}  //E Emulacja
 Local nPoz
 Local i:=0
 Local cChar  :=''
 Local cStrTran:=''
 Local nLen   :=Len(cStr)
 Local nFrom  :=If(Empty(cFrom),1,Max(1,At(cFrom,'LMWIBE')))
 Local nTo    :=If(Empty(cTo  ),1,Max(1,At(cTo,  'LMWIBE')))

 For i:=1 To nLen
     cChar:=SubStr(cStr,i,1)
     If (nPoz:=aScan(aChar[nFrom],cChar)) == 0
        cStrTran+=cChar
     Else
        cStrTran+=aChar[nTo,nPoz]
     EndIf
 Next i

#EndIf

Return cStrTran
