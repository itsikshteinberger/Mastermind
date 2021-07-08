                                                     ; multi-segment executable file template.

data segment
    ; add your data here!   
     
    
    answer db ?,?,?,? 
    
    YourAnswer db ?,?,?,?
     
    bool db 0 
      
    pgiha db 0 
    
    isagain dw 10,13,10,13,9,"       Do you want to play again(y-yes,another char-no)?$"
    
    pkey db "To finish press any key...$"   
    
    Title1 dw 10,13,9,"      M   M  AA   SS TTTTT EEE RRR  M   M III N   N DD "
    Title2 dw 10,13,9,"      MM MM A  A S     T   E   R  R MM MM  I  NN  N D D"
    Title4 dw 10,13,9,"      M M M A  A  S    T   EEE RRR  M M M  I  N N N D D"
    Title5 dw 10,13,9,"      M   M AAAA   S   T   E   R R  M   M  I  N  NN D D"
    Title6 dw 10,13,9,"      M   M A  A SS    T   EEE R  R M   M III N   N DD$"
    
    guidance1 dw 10,13,10,13,,9,"            Hello, welcome to my mastermind game!"  
    guidance2 dw 10,13,9,"      In this game you will have to guess the secret code." 
    guidance3 dw 10,13,10,13,"1. The code consists of 4 deffrent colors."
     
    guidance4 dw 10,13,"2. You can input colors by digits (between 0 to 5)."
    guidance5 dw 10,13,"3. You have 9 turns."                                                           
    guidance6 dw 10,13,"4. ",1,"-one of your colors exist in the original code but the location is worng.   "
    guidance7 dw "  ",2,"-one of your colors exist in the original code with right location."
    guidance8 dw 10,13,"5. The secret code can be chosen by computer or by player2 (It's your choice)." 
    guidance9 dw "  6. If player1 fail so player2 win.$" 
    
    start1 dw 10,13,10,13,"Do you want the code will be chosen by player2 (y\n) ? $"
    start2 dw 10,13,10,13,"Player2 ,please input the secret code: $"  
    start3 dw 10,13,10,13,"When you're ready to start press any key.$"
    
    mone dw 10,13,10,13,'0',". Input your guess: $"
    
    writeanswer dw 9,"Your score is: $" 
    
    string dw 10,13,"                          Color list: $" 
    
    isMulty db 0  
    
    linedown dw 10,13,10,13,10,13,10,13,"$"
      
    won1 dw 10,13,10,13,10,13,9,9,9," W   W III N   N N   N EEE RRR    "
    won2 dw 10,13,9,9,9,            " W   W  I  NN  N NN  N E   R  R   "
    won3 dw 10,13,9,9,9,            " W   W  I  N N N N N N EEE RRR    "
    won4 dw 10,13,9,9,9,            " W W W  I  N  NN N  NN E   R R    "
    won5 dw 10,13,9,9,9,            "  W W  III N   N N   N EEE R  R   $"
    won6 dw 10,13,9," PPP  L    AA  Y   Y EEE RRR  11    III  SS   TTTTT H  H EEE"
    won7 dw 10,13,9," P  P L   A  A  Y Y  E   R  R  1     I  S       T   H  H E  "
    won8 dw 10,13,9," PPP  L   AAAA   Y   EEE RRR   1     I   S      T   HHHH EEE"
    won9 dw 10,13,9," P    L   A  A   Y   E   R R   1     I    S     T   H  H E  "
    won0 dw 10,13,9," P    LLL A  A   Y   EEE R  R 111   III SS      T   H  H EEE$"
    
    Lose1 dw 10,13,9,9,9,"   L   OO   SS EEE RRR   "
    Lose2 dw 10,13,9,9,9,"   L  O  O S   E   R  R  "
    Lose3 dw 10,13,9,9,9,"   L  O  O  S  EEE RRR   "
    Lose4 dw 10,13,9,9,9,"   L  O  O   S E   R R   "
    Lose5 dw 10,13,9,9,9,"   LLL OO  SS  EEE R  R  $"
    Lose6 dw 10,13,9," PPP  L    AA  Y   Y EEE RRR  22    III  SS   TTTTT H  H EEE"
    Lose7 dw 10,13,9," P  P L   A  A  Y Y  E   R  R   2    I  S       T   H  H E  "
    Lose8 dw 10,13,9," PPP  L   AAAA   Y   EEE RRR   2     I   S      T   HHHH EEE"
    Lose9 dw 10,13,9," P    L   A  A   Y   E   R R  2      I    S     T   H  H E  "
    Lose0 dw 10,13,9," P    LLL A  A   Y   EEE R  R 222   III SS      T   H  H EEE$"
     
   
ends

stack segment        
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here
    startofgame:   
    mov mone+8,'0'
    mov ismulty,0
    call clearscreen
    mov bl,10                ; \   change the color to lightgreen                             
    call changecolor         ;  \  by calling to the procedure who change the color by bl
    mov ah,9                 ;   > print rhe title ("mastermind")
    lea dx,Title1            ;  /
    int 21h                  ; /
                             
    mov bl,11                ; \  change the color to light blue                             
    call changecolor         ;  \ by calling to the procedure who change the color by bl
    lea dx,guidance1         ;  / print six rules
    int 21h                  ; /
                            
                            
    mov bl,14                ; \  change the color to yellow                             
    call changecolor         ;  \ by calling to the procedure who change the color by bl
    lea dx,start1            ;  / print: "Do you want the code will be chosen by player2 (y\n) ?"
    int 21h                  ; /
                            
                            
    isMulti: mov ah,7        ; \ input your
    int 21h                  ; /   answer
                            
    cmp al,'y'               ;  check if the answer is legal
    je multi                 ;  if the answer is 'y' than move on to "multi version"
    cmp al,'n'               ;     
    jne isMulti              ;  if the answer is illegal than input your answer again           
    mov ah,2                 ; \   
    mov dl,'n'               ;  > if the answer is legal than print it  
    int 21h                  ; / 
                            
    call createrandom        ; call the procedure who made random code by compter 
    jmp startPlay            ; jump to game start
                            
    multi: mov isMulty,1     ; \ 
    mov ah,2                 ;  \  if the answer is yes 
    mov dl,'y'               ;  /  than print 'y' on the screen
    int 21h                  ; / 
                            
    lea dx,start2            ; \
    mov ah,9                 ;  > print: "Player2 ,please input the secret code: "
    int 21h                  ; /
    call multiversion        ; call the procedure who read the secret code by player 2
    
    ; ===================================== ;
    ; the start of the game (guesses input) ;
    ; ===================================== ;
    
    startPlay: mov ah,9      ;  \
    lea dx,start3            ;   > print: "When you're ready to start press any key."
    int 21h                  ;  /  
                            
    mov ah,7                 ; \ wait for input
    int 21h                  ; / of any key
                            
    call clearscreen         ; call the procedure who cleen the screen
                            
    mov bl,15                ; change the color to white
    call changecolor         ; by calling to the procedure who change the color by bl   
    lea dx,string
    call printcolorlist      ; call the procedure who print the color list (numbers in colors)
                            
    mov cx,9                 ; for (int i=9; i>=1 ; i--)
    turn: inc mone+8         ; mone \\ the counter of the turns ( "{0}. Input your guess: ",mone)
                            
    mov bl,15                ; change the color to white                             
    call changecolor         ; by calling to the procedure who change the color by bl
                            
    mov ah,9                 ; \
    lea dx,mone              ;  > print: "{0}. Input your guess: ",mone
    int 21h                  ; / 
    call Inputguess          ; call the procedure who read yout answer (player1) 
                            
    mov bl,15                ; change the color to white                             
    call changecolor         ; by calling to the procedure who change the color by bl
                            
    lea dx,writeanswer       ; print :"Your score is: "
    int 21h                 
                            
    call check               ; call the procedure who check how much bool and how much pgiha you got
    mov bl,14                ; change the color to yellow                             
    call changecolor         ; by calling to the procedure who change the color by bl 
    call printcheck          ; call the procedure who print  for each pgiha and  for each bool
    cmp bool,4               ; \  if bool = 4 its mean that player1 Succeeded to guess all the code 
    je winner                ; /  so jump the final print of "winner"
    loop turn
    
    jmp Lose                 ; if you finished all your turn and bool still not equel to 4 its mean you lose 
    
    ; ==================== ;
    ; situation of victory ;
    ; ==================== ;
    
    winner: call clearScreen ; call the procedure who cleen the screen 
    mov ah,9                 ; \
    lea dx,linedown          ;  > The cursor goes four rows down
    int 21h                  ; /
    mov bl,10                ; change the color to green                            
    call changecolor         ; by calling to the procedure who change the color by bl
    mov ah,9                  
    cmp isMulty,0            ; if the game was not in multi version
    je printit1              ; than print only "winner" in printit1
    lea dx,won6              ; if the game was in multi player version
    int 21h                  ; than: first,  print :"player1 is the"
    
    printit1:
    lea dx,won1              ; \
    int 21h                  ;  > but we need to print "winner" Every situation of victory
    jmp End                  ; /
    
    ; ================= ;
    ; situation of loss ;
    ; ================= ;                 
                        
    lose:call clearScreen    ; call the procedure who cleen the screen
    mov ah,9                 ; \
    lea dx,linedown          ;  > The cursor goes four rows down
    int 21h                  ; /
    mov bl,10                ; change the color to green                             
    call changecolor         ; by calling to the procedure who change the color by bl
    mov ah,9                 ; if the game was not in multi version   
    cmp isMulty,0            ; than print only "loser" in printit1   
    je printit2              ; if the game was in multi player version than: print :"player2 is the winner"
    lea dx,lose6             ; \  
    int 21h                  ;  \ print the string : "player2 is the"
    lea dx,won1              ;  / print the string " "winner"
    int 21h                  ; /
    
    
    jmp end                  ; after you print the string jump to the end of this game
    
    printit2: mov bl,12      ; change the color to red                                
    call changecolor         ; by calling to the procedure who change the color by bl
    mov ah,9                 ; \
    lea dx,lose1             ;  > print :"loser" 
    int 21h                  ; /
                             
    
    
      
    End:
    mov bl,15       
    call changecolor
    mov ah,9
    lea dx,isagain
    int 21h
    mov ah,1
    int 21h   
    cmp al,'y'
    je startofgame
    mov bl,15         ; \
    call changecolor  ;  \
    mov dh, 23        ;   \
	mov dl, 1         ;    \
	mov bh, 0         ;     > print: "to finish press any key..." in the bottom of the screen
	mov ah, 2         ;    /
	int 10h           ;   /
    lea dx, pkey      ;  /
    mov ah, 9         ; /
    int 21h        ; output string at ds:dx 
     
    ; wait for any key....    
    mov ah, 7
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h         
    
    Inputguess PROC NEAR 
        
    ;=================================================================;
    ;   The procedure call to procedure that let you input your answer;
    ;   and check it if its diffrent from the other numbers           ;
    ;=================================================================;
   
    mov     bp, sp                   ; pointer to returning address whereas
                                     ; the procedure parameters are located below of it
                                     
    
                                     
    push ax              ; store registers                        
    push bx                          
    push cx                          
    push dx                          
                                     
    xor si,si            ;   si = 0            
                                     
    Input1: call print1  ; This call to the procedure that input your answer to the current index            
    call print2          ; This call to the procedure that print char in the color by the value of bl
                                             
    Input2: mov si,1     ; Add to the Index 1 
    call print1          ; This call to the procedure that input your answer to the current index
    mov al,[5]  
    cmp al,[4]           ; check if the current number is equal to the last numbers                    
    je Input2            ; if its equal make number again                    
    call print2          ; This call to the procedure that print char in the color by the value of bl
                                             
    Input3:mov si,2      ; Add to the Index 1                    
    call print1          ; This call to the procedure that input your answer to the current index                    
    mov al,[6]           ; \                   
    cmp al,[5]           ;  \                  
    je Input3            ;   > check if the current number is equal to the last numbers                
    cmp al,[4]           ;  /  if its equal make number again                
    je Input3            ; /                   
    call print2          ; This call to the procedure that print char in the color by the value of bl                     
                                             
    Input4:mov si,3      ; Add to the Index 1                    
    call print1          ; This call to the procedure that input your answer to the current index                    
    mov al,[7]           ; \
    cmp al,[6]           ;  \
    je Input4            ;   \
    cmp al,[5]           ;    > check if the current number is equal to the last numbers
    je Input4            ;   /  if its equal make number again
    cmp al,[4]           ;  /
    je Input4            ; /
    call print2          ; call to the procedure that print char in the color by the value of bl
                                             
                                             
                                             
    pop  dx              ; restore registers        
    pop  cx                                  
    pop  bx                                  
    pop  ax                                  
                                             
                                             
    ret                  ; return
                                             
    Inputguess ENDP                          
                                             
    Createrandom PROC NEAR  
        
    ;=================================================;                                 
    ; The procedure make four random diffrent numbers ;
    ; and put them in the memory site call answer     ;                                                                   
    ;=================================================;                 
    
    mov     bp, sp     ; pointer to returning address whereas
                       ; the procedure parameters are located below of it                                 
                                               
    push ax            ; store registers
    push bx                                  
    push cx                                  
    push dx                                  
                                             
                       
    xor si,si              ; si = 0 (=curindex)
                                             
    one: call createrand   ; call the procedure
                                             
                                             
    two: mov si,1      ; Add to the Index 1
    call createrand    ; call to the procedure that make random number between 0 to 5
    mov al,[1]         ; \                     
    cmp al,[0]         ;  > check if the current number is equal to the last numbers
    je two             ; /  if its equal make number again
                                            
                                             
    three:mov si,2     ; Add to the Index 1
    call createrand    ; call to the procedure that make random number between 0 to 5
    mov al,[2]         ;  \
    cmp al,[1]         ;   \  check if the current number is equal to the last numbers
    je three           ;    >  if its equal make number again
    cmp al,[0]         ;   /
    je three           ;  /
                                             
                                             
    four:mov si,3      ; Add to the Index 1                      
    call createrand    ; call to the procedure that make random number between 0 to 5
    mov al,[3]         ; \
    cmp al,[2]         ;  \
    je four            ;   \ check if the current number is equal to the last numbers
    cmp al,[1]         ;    > if its equal make number again
    je four            ;   /
    cmp al,[0]         ;  /
    je four            ; /
                                             
                                             
    pop  dx            ; restore registers        
    pop  cx                                  
    pop  bx                                  
    pop  ax                                  
                                             
                                             
    ret                ; return 
    
    Createrandom ENDP
    
    createrand PROC Near 
        
    ;================================================                  
    ; The procedure get the current index
    ; and craete random number in the current location
    ;================================================
    
    mov     bp, sp  ;   pointer to returning address whereas
                    ;   the procedure parameters are located below of it
                    
   
    
    
    push ax           ; store registers  
    push bx
    push cx
    push dx
    
    
    mov ah,2ch        ; \
    int 21h           ;  \
    mov bl,6          ;   \
    mov al,dl         ;    > create random number between 0 to 5
    xor ah,ah         ;   /  and put him into the current location in answer
    div bl            ;  /
    mov [si],ah       ; /
     
        
    pop  dx           ; restore registers
    pop  cx
    pop  bx
    pop  ax                 
    
    ret               ; return
    
    createrand ENDP
    
    print1 PROC NEAR  
        
    ;==================================================================
    ; The procedure get the current location 
    ; and read you answer and put it in the memory site call youranswer
    ;==================================================================    
    
    mov     bp, sp            ;   pointer to returning address whereas
                              ;   the procedure parameters are located below of it
                    
                     
        
    push ax                   ; store registers
    push bx 
    push cx
    push dx 
    
    again:                    ; \ 
    mov ah,7                  ;  \
    int 21h                   ;   \
    cmp al,'5'                ;    \
    jg again                  ;     > read your answer and check if it llegal
    cmp al,'0'                ;    /
    jl again                  ;   /
    mov [4+si],al             ;  /
    sub [4+si],'0'            ; /
    
    pop dx                    ; restore registers
    pop cx
    pop bx
    pop ax 
    
    ret                       ; return
        
    print1 ENDP
    
    
    print2 PROC NEAR 
        
    ;=====================================================================================
    ; The procedure get the current location and get the value of youranswer[currentindex]
    ; and print char in the color by the value of bl
    ;=====================================================================================
    
    mov     bp, sp  ;   pointer to returning address whereas
                    ;   the procedure parameters are located below of it
                    
                        
        
    push ax                ; store registers
    push bx 
    push cx
    push dx
    
     
    mov bl,[4+si]
    add bl,2              ; \
    call changecolor      ;  \ 
    mov dl,04             ;   > print char in the color of the
    mov ah,2              ;  /
    int 21h               ; /
    
    pop dx                ; restore registers
    pop cx
    pop bx
    pop ax 
                          ; return
    ret   
        
    print2 ENDP    
    
    check PROC NEAR
         
    ; ===================================================================================================== ;   
    ; The procedure get the memory site call youranswer                                                     ;
    ; and another memory site call answer.                                                                  ;
    ; The procedure compares the memory sites and add 1 to Pgiha                                            ;
    ; if one of your colors exist in the original code (your answer) but the location is worng.             ;
    ; and add 1 to Bool if one of your colors exist in the original code (your answer) with right location. ;
    ; (At the beginning of the procedure bool and pgiha reset                                               ;
    ; ===================================================================================================== ; 
      
    mov     bp, sp                    ;   pointer to returning address whereas
                                      ;   the procedure parameters are located below of it
                                      
                                          
                                      
    push ax                           ; store registers
    push bx 
    push cx
    push dx 
                                      ; si = curindex = 0
    xor si,si                         ; i = 4
    mov cx,4
    mov [9],0
    mov [8],0
    
    
    checking: mov al,[4+si]           ; 
                                      ; for (int i = 4; i > 0; i--)
    cmp al,[si]                       ; {
    je addBool                        ;   if (youranswer[5-i] == answer[5-i])
    jmp next                          ;       bool++;
    addBool: inc [8]                  ; }
    next: inc si                      ;
                                      ; now we know how much colors in
    loop checking                     ; the right location we have
    
    mov cx,4                          ; i = 4
    xor si,si                         ; si = curindex = 0
    
    checking1: mov al,[4+si]          ; for (int i = 4;i > 0; i--)
                                      ; {
    inc si                            ;  for (int j = 4;j > 0; j--)
    push cx                           ;  {
    push si                           ;   if (youranswer[5-i] == answer[5-j])
    mov cx,4                          ;      pgiha++;
    xor si,si                         ;  }
    checking2:mov bl,[4+si]           ; }
                                      ;
    cmp al,[si]                       ; Now, if you pay attention a memory site pgiha 
    jne next1                         ; consist of colors in right location(bool) and
    inc [9]                           ; colors in worng location(pgiha), while we need
    next1:inc si                      ; just the colors in worng loctaion(pgiha)
    loop checking2                    ; so we know that pgiha = pgiha + bool
    pop si                            ; We need to subtract bool from pgiha
    pop cx                            
                                      
    loop checking1                    
    
    mov al,[8]                        ; \  al = bool   ;
    sub [9],al                        ; /  pgiha -=bool; (and now we got just colors in worng location)
    
    pop dx                ; restore registers
    pop cx
    pop bx
    pop ax 
                          ; return
    ret
       
    check ENDP
    
    clearScreen PROC NEAR 
    ; ============================================================== ;
    ; The procedure clears the screen by the action for this purpose ; 
    ; ============================================================== ;    
        
    mov     bp, sp  ;   pointer to returning address whereas
                    ;   the procedure parameters are located below of it
                    
                        
        
    push ax                ; store registers
    push bx 
    push cx
    push dx 
        
    mov ax,03h            ; This ruling clears the screen
    int 10h               ; by 10h
     
    pop dx                ; restore registers
    pop cx
    pop bx
    pop ax 
                          ; return
    ret
    
    clearScreen ENDP
    
     
    
    changecolor Proc NEAR 
    ; ============================================================= ;   
    ; The procedure change the color of the text by the value of bl ;
    ; ============================================================= ;
        
    mov     bp, sp ;   pointer to returning address whereas
                   ;   the procedure parameters are located below of it
                                               
    push ax         ; store registers
    push bx 
    push cx
    push dx
    
    mov cx,0755h    ; the best way to change the text color is when the value of the hastmer is like in the start
    mov ah, 9                         
    mov al,0        ;avoding extra characters    
    int 10h                               
    
    pop dx          ; restore registers
    pop cx
    pop bx
    pop ax 
                          
    ret             ; return 
    
    changecolor Endp
    
    multiversion Proc NEAR 
    ; ========================================================================================================= ;
    ; The procedure let to player2 to input his secret code (if pleyer1 choose to play in multi player version) ;    
    ; ========================================================================================================= ;
       
    mov     bp, sp ;   pointer to returning address whereas
                   ;   the procedure parameters are located below of it
                                               
    push ax         ; store registers
    push bx 
    push cx
    push dx    
    
    mov ah,2
    mov dl,'X'
    
    InputAns1: call print1  ; This call to the procedure that input your answer to the current index 
    int 21h           
                                             
    InputAns2: mov si,1     ; Add to the Index 1 
    call print1             ; This call to the procedure that input your answer to the current index
    mov al,[4+si]     
    cmp al,[4]              ; check if the current number is equal to the last numbers                    
    je InputAns2            ; if its equal make number again
    int 21h                       
                                                
    InputAns3:mov si,2      ; Add to the Index 1                    
    call print1             ; This call to the procedure that input your answer to the current index                    
    mov al,[4+si]           ; \                   
    cmp al,[5]              ;  \                  
    je InputAns3            ;   > check if the current number is equal to the last numbers                
    cmp al,[4]              ;  /  if its equal make number again                
    je InputAns3            ; / 
    int 21h                              
                                                
    InputAns4:mov si,3         ; Add to the Index 1                    
    call print1             ; This call to the procedure that input your answer to the current index                    
    mov al,[4+si]           ; \
    cmp al,[6]              ;  \
    je InputAns4            ;   \
    cmp al,[5]              ;    > check if the current number is equal to the last numbers
    je InputAns4            ;   /  if its equal make number again
    cmp al,[4]              ;  /
    je InputAns4            ; / 
    int 21h
    
    mov cx,4                           ; \
    xor si,si                          ;  \      now the secret code of player2 available
    transition: mov al,[4+si]          ;   \     
    mov [4+si],0                       ;    >    in YOURANSWER memory site and now we move
    mov [si],al                        ;   /
    inc si                             ;  /      this code to Answer memory site
    loop transition                    ; /
            
    pop dx          ; restore registers
    pop cx
    pop bx
    pop ax 
                          
    ret             ; return 
    
    multiversion Endp
    
    printCheck Proc NEAR
          
    ; ============================================================= ;  
    ; The procedure gets the value of bool and value of pgiha and   ;
    ; print  BOOL times and  PGIHA times in yellow                ;
    ; ============================================================= ;   
        
    mov     bp, sp           ;   pointer to returning address whereas
                             ;   the procedure parameters are located below of it
                                                        
    push ax                  ; store registers
    push bx 
    push cx
    push dx
     
    
    mov cl,[8]               ; i=bool
    mov ah,2                 ; to print the 
    cmp [8],0                ; if bool = 0 than there
    je nextstep              ;    is no print of  
    mov bl,14                ; change the color to yellow                               
    call changecolor         ; by calling to the procedure who change the color by bl
                             
    printscore1: mov dl,2    ; now, the value of dl is  
    int 21h                  ; and its print  
    loop printscore1         ; x(=Bool) times
    
    nextstep:mov cl,[9]      ; i = pgiha
    
    cmp [9],0                ; if pgiha = 0 than there
    je return                ;    is no print of    
    
    printscore2: mov dl,1    ; now, the value of dl is  
    int 21h                  ; and its print            
    loop printscore2         ; x(=pgiha) times            
    
    return:
    pop dx                   ; restore registers
    pop cx                  
    pop bx                  
    pop ax                  
                                   
    ret                      ; return 
    
    printcheck Endp
    
    printcolorlist PROC NEAR 
        
    ; ============================================================= ;
    ; The procedure print "ColorList: 0 1 2 3 4 5"                  ;
    ;                                 ^ ^ ^ ^ ^ ^                   ;
    ;                       color by the value of each number       ;
    ; ============================================================= ;     
        
    mov     bp, sp ;   pointer to returning address whereas
                   ;   the procedure parameters are located below of it
                                               
    push ax         ; store registers
    push bx 
    push cx
    push dx    
        
    mov ah,9        ; \
                    ;  > ptint: "color list:"
    int 21h         ; /
    
    
    mov cx,6              ;  for (i=cx=6; i>0 ; i-- )
    mov bl,1              ;  {
    mov dl,'0'            ;    console.write(dl + ""); (int the color of the value dl);
    printcolor: mov ah,2  ;    console.write(" ");
    inc bl                ;    dl++
    call changecolor      ;  }
    int 21h               ;
    inc dl                ;
    push dx               ;
    mov dl,' '            ;
    int 21h               ;
    pop dx                ;                    
    loop printcolor       ;
    
    pop dx          ; restore registers
    pop cx
    pop bx
    pop ax 
                          
    ret             ; return    
        
    printcolorlist Endp     
    
      
ends
    
    
end start ; set entry point and stop the assembler.