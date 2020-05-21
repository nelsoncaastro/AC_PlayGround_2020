	org 	100h

section .text

	call 	texto	
	call 	phrase
	call	kbwait

	int 	20h

texto:	mov 	ah, 00h
	mov	al, 03h
	int 	10h
	ret

cursor: mov	ah, 01h
	mov 	ch, 00000000b
	mov 	cl, 00001110b
		;   IRGB
	int 	10h
	ret

w_char:	mov 	ah, 09h
	mov 	al, cl
	mov 	bh, 0h
	mov 	bl, 00001111b
	mov 	cx, 1h
	int 	10h
	ret

kbwait: mov 	ax, 0000h
	int 	16h
	ret

m_cursr:mov 	ah, 02h
	mov 	dx, di  ; columna (DL) DX = ---- ---- 0000 0000
	add	dl, 19d ; añadir el offset de la columna
	mov 	dh, 5d ; fila
	mov 	bh, 0h
	int 	10h
	ret

m_cursr2:mov 	ah, 02h
	mov 	dx, di  ; columna (DL) DX = ---- ---- 0000 0000
	add	dl, 40d ; añadir el offset de la columna
	sub 	dl, len ; restar el offset de la memoria
	mov 	dh, 12d ; fila
	mov 	bh, 0h
	int 	10h
	ret

m_cursr3:mov 	ah, 02h
	mov 	dx, di  ; columna (DL) DX = ---- ---- 0000 0000
	add	dl, 10d ; añadir el offset de la columna
	sub 	dl, len+len2 ; restar el offset de la memoria
	mov 	dh, 20d ; fila
	mov 	bh, 0h
	int 	10h
	ret

;choose m_cursr
c_m_cursr:
	;if di>0 && di<len
	cmp 	di, len
	jnb	c_l2
	call	m_cursr
	jmp 	s_c
	;if di>len && di<(len+len2)
c_l2:	cmp	di, len+len2 
	jnb	c_l3
	call 	m_cursr2
	jmp 	s_c
	;if di>(len+len2) && di<(len+len2+len3)
c_l3:	cmp 	di, length
	jnb	s_c
	call	m_cursr3	
s_c:	ret

phrase:	mov 	di, 0d ; contador: la celda de donde sacamos chars
			; contador: columna donde vamos a mover el cursor
lupi:	mov 	cl, [msg+di]
	call    c_m_cursr
	call 	w_char
	inc	di
	cmp 	di, length
	jl	lupi
	ret


section .data
msg	db 	"Hoy sali con los muchachos a beber"
msg2	db 	"Y dije que de ti no iba a hablar"
msg3	db 	"Son las cinco, ya va amanecer "
len3 	equ	$-msg3
len2 	equ	msg3-msg2
len 	equ	msg2-msg
length 	equ 	len+len2+len3
