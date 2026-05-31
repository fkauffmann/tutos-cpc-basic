10 'rotation de palette
20 MODE 0: border 0
30 'init palette
40 DIM palette%(15)
50 FOR i%=0 TO 15:READ color%:palette%(i%)=color%:INK i%,color%:NEXT i%
60 DATA 0,1,2,11,20,23,26,25,24,15,16,6,7,8,5,4
70 'draw line
80 FOR i%=0 TO 640 STEP 4
90 PLOT i%,0,(i%/4) MOD 16:DRAW i%,400,(i%/4) MOD 16
100 NEXT i%
110 'cycle colors
120 i%=0:decalage%=0
130 INK ((i% + decalage%) MOD 16),palette%(i%)
140 i%=(i%+1) MOD 16
150 IF i%=0 THEN decalage%=(decalage%+1 MOD 16)
160 GOTO 130
170 