
Code Segment
assume CS:Code, DS:Data, SS:Stack
;Feladat: a képernyő közepére egy teli négyzet, dimenzióját paraméterként kapjuk

;Paraméter -> /1 - /9, minden egyéb esetben default, DE pl /16 esetén /1 fog futni mert csak egyjegyűre kezeltem, hogy beleférjek a 100 sorba
Start:
	mov di,82h
	mov al,"/"
	cmp [di],al
	jz Ellenoriz
	
	jmp Default
Ellenoriz:
	inc di
	mov al,[di]
	cmp al,"1"
	jl Default
	cmp al,"9"
	jg Default
	
	jmp NemDefault

Default:
	mov cl, 8
	mov ch, 0
	push cx
	jmp Init

NemDefault:
	sub al, 48
	mov cl, al
	mov ch, 0
	push cx

Init:
	mov ax, Code
	mov DS, AX
	
    mov ax, 03h ;képernyő törlés
	int 10h
	
FeladatStart:
	pop cx
	mov si, cx
	
	mov dh, 12 ;képernyő közepe
	mov dl, 39

	xor ax, ax
	mov bl, 2
	mov ax, cx
	div bl
	
	sub dh, al
	sub dl, al
	
	mov ah, 02h ;kurzor pozi
	mov bh, 0
	int 10h
	
Kulso:
    push cx ; verembe
	push dx
	
	mov cx,si
	Belso:
		mov ah, 02h
		mov dl, "*"
		int 21h

    loop Belso
	
	pop dx
    inc dh
    int 10h

	pop cx
    loop Kulso

    xor ax,ax
    int 16h

Program_Vege:
	mov ax, 4c00h
	int 21h


Code Ends

Data Segment

Data Ends

Stack Segment

Stack Ends
End Start

