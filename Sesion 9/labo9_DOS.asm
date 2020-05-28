org 	100h

section .text

	xor 	si, si 	;lo mimso que: mov si, 0000h
lupi:	call 	kb
	mov	[300h+si], al ; CS:0300h en adelante
	inc 	si

mostrar:;mov	byte [300h+si], "$" ; Agregamos el caracter $ para usar la INT 21h/09h
	;call 	w_strng

	;call 	kb	; solo detenemos la ejecución
	int 	20h

kb: 	mov	ah, 1h
	int 	21h

w_strng:mov	ah, 09h
	mov 	dx, 300h
	int 	21h
	ret
