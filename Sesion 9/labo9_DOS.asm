org 	100h

section .text

	xor 	si, si 	;lo mimso que: mov si, 0000h
lupi:	call 	kb
	cmp 	al, "$"
	je	mostrar
	mov	[300h+si], al ; CS:0300h en adelante
	inc 	si
	jmp 	lupi

mostrar:mov	byte [300h+si], "$"
	call 	w_strng

	call 	kb	; solo detenemos la ejecución
	int 	20h

kb: 	mov	ah, 7h
	int 	21h
	ret

w_strng:mov	ah, 09h
	mov 	dx, 300h
	int 	21h
	ret
