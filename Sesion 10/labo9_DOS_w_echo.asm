org 	100h

section .text

	mov 	dx, msg
	call 	w_strng

	xor 	si, si 	;lo mimso que: mov si, 0000h
lupi:	call 	kb
	cmp 	al, "$"
	je	mostrar
	mov	[300h+si], al ; CS:0300h en adelante
	inc 	si
	jmp 	lupi

mostrar:mov 	dx, nl
	call	w_strng
	mov	byte [300h+si], "$"
	mov 	dx, 300h
	call 	w_strng

	call 	kb	; solo detenemos la ejecución
	int 	20h

texto:	mov 	ah, 00h
	mov	al, 03h
	int 	10h
	ret

kb: 	mov	ah, 1h
	int 	21h
	ret

w_strng:mov	ah, 09h
	int 	21h
	ret

section .data

msg 	db 	"Ingrese su mensaje: $"
nl	db 	0xA, 0xD, "$"