	org	100h

section .text

	mov 	dx, msg
	call 	print
	mov 	dx, nl
	call 	print
	mov 	dx, msg2
	call 	print
	mov 	dx, nl
	call 	print
	mov 	dx, msg3
	call 	print

	call 	kbwait

	int 	20h

texto:	mov 	ah, 00h
	mov	al, 03h
	int 	10h
	ret

print:	mov	ah, 09h
	int 	21h
	ret

kbwait: mov 	ax, 0000h
	int 	16h
	ret

section .data

msg	db 	"Hoy sali con los muchachos a beber$"
msg2	db 	"Y dije que de ti no iba a hablar$"
msg3	db 	"Son las cinco, ya va amanecer$"
len3 	equ	$-msg3
len2 	equ	msg3-msg2
len 	equ	msg2-msg
nl 	db 	0xA, 0xD, "$"
p_msg 	dw	msg, msg2, msg3