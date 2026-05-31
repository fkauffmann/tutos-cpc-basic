10 'PEOPLE LIST SORTED BY BIRTH YEAR'
20 mode 2
30 t0 = time
40 maxpeople=10
50 dim people$(maxpeople,3)
60 restore 420
70 'READ DATA INTO ARRAY
80 for i=1 to maxpeople
90 read firstname$, lastname$, birthyear%
100 people$(i,0)=firstname$
110 people$(i,1)=lastname$
120 people$(i,2)=str$(birthyear%)
130 next
<<<<<<< HEAD
140 'CALL SORT
150 gosub 260
160 'DISPLAY DATA
170 print "FIRSTNAME","LASTNAME","BIRTH " + chr$(241)
180 print "---------","--------","-------"
190 for i=1 to maxpeople
200 print people$(i,0), people$(i,1), people$(i,2)
210 next
220 t=(TIME-t0)/300
230 print string$(33, "-")
240 print "Execution : ";t;"sec"
250 end
260 'SORT LOGIC
270 for i = 1 to maxpeople
280 currentyear = val(people$(i,2))
290 for j = 1 to maxpeople
300 nextyear = val(people$(j,2))
310 if currentyear < nextyear then gosub 350
320 next j
330 next i
340 return
350 'SWAP ROWS
360 tmp0$=people$(i,0): tmp1$=people$(i,1): tmp2$=people$(i,2)
370 people$(i,0)=people$(j,0): people$(i,1)=people$(j,1): people$(i,2)=people$(j,2)
380 people$(j,0)=tmp0$: people$(j,1)=tmp1$: people$(j,2)=tmp2$
390 return
400 'DATA'
410 data Fabrice,Kauffmann,1972
420 data Isaac,Newton,1643
430 data Albert,Einstein,1879
440 data Neil,Armstring,1930
450 data Buzz,Aldrin,1930
460 data Keanu,Reeves,1964
470 data Patrick,Stewart,1940
480 data Fidel,Castro,1926
490 data Yasser,Arafat,1929
500 data Philip K.,Dick,1928
510 
=======
140 'DISPLAY HEADER
150 print "FIRSTNAME","LASTNAME","BIRTH " + chr$(241)
160 print "---------","--------","-------"
170 'CALL SORT
180 gosub 270
190 'DISPLAY DATA
200 for i=1 to maxpeople
210 print people$(i,0), people$(i,1), people$(i,2)
220 next
230 t=(TIME-t0)/300
240 print string$(33, "-")
250 print "Execution : ";t;"sec"
260 end
270 'SORT LOGIC
280 for i = 1 to maxpeople
290 currentyear = val(people$(i,2))
300 for j = 1 to maxpeople
310 nextyear = val(people$(j,2))
320 if currentyear < nextyear then gosub 360
330 next j
340 next i
350 return
360 'SWAP ROWS
370 tmp0$=people$(i,0): tmp1$=people$(i,1): tmp2$=people$(i,2)
380 people$(i,0)=people$(j,0): people$(i,1)=people$(j,1): people$(i,2)=people$(j,2)
390 people$(j,0)=tmp0$: people$(j,1)=tmp1$: people$(j,2)=tmp2$
400 return
410 'DATA'
420 data Fabrice,Kauffmann,1972
430 data Isaac,Newton,1643
440 data Albert,Einstein,1879
450 data Neil,Armstrong,1930
460 data Buzz,Aldrin,1930
470 data Keanu,Reeves,1964
480 data Patrick,Stewart,1940
490 data Fidel,Castro,1926
500 data Yasser,Arafat,1929
510 data Philip K.,Dick,1928
520 
>>>>>>> 453b35f (Fixed a bug in the sort logic)
