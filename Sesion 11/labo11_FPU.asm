org 	100h

section .text

	xor 	si, si
	xor 	di, di

	;mov 	si, 20h
	;mov 	[si_pirata], si

	mov     dx, msg
	call    w_strng

	mov     di, prueba
	call    w_32reg

	int 	20h



func_y:
	; [?] = 20 00 00 00
	; SI_PIRATA = 00000020h

	mov 	di, word [s_sub] ; Solo para revisar el valor de s_sub 0164h

	fld 	dword [si_pirata] ; 20h ST1
	fld 	dword [pa_x]	; 50h	ST0
	fsub 		
	fstp	dword [s_sub] ; 80 00 00 30 = -30  ST1-ST0

	finit 
	fld 	dword [s_sub]
	fld 	dword [linea_ab_m]	
	fmul
	fstp	dword [s_mul] ; 138.24‬

	fld 	dword [pa_y]
	fadd
	fstp	dword [s_sum]

	frndint
	fstp	dword [s_mul]
	fstp	dword [si_pirata]
	mov	di, word [si_pirata]
	ret

w_char: mov	ah, 02h
	mov	al, 00h
	int 	21h
	ret

w_strng:mov	ah, 09h
	int 	21h
	ret

w_32reg:
	mov 	ax, [di + 2h]
	mov	cx, 16d 

	mov 	dx, 0h
	div	cx
	add 	dx, '0'

	mov 	bl, dl ; El cuarto digito

	mov 	dx, 0h
	div	cx
	add 	dl, '0' 
	mov	bh, dl	; El tercer digito

	push 	bx

	mov 	dx, 0h
	div	cx
	add 	dx, '0'

	mov 	bl, dl ; El segundo digito

	mov 	dx, 0h
	div	cx
	add 	dl, '0' 
	mov	bh, dl	; El primer digito
	call 	w_char
	mov 	dl, bl
	call 	w_char
	pop 	bx
	mov	dl, bh 
	call	w_char
	mov 	dl, bl
	call 	w_char

	mov 	ax, [di]
	mov	cx, 16d 

	mov 	dx, 0h
	div	cx
	add 	dx, '0'

	mov 	bl, dl ; El cuarto digito

	mov 	dx, 0h
	div	cx
	add 	dl, '0' 
	mov	bh, dl	; El tercer digito

	push 	bx

	mov 	dx, 0h
	div	cx
	add 	dx, '0'

	mov 	bl, dl ; El segundo digito

	mov 	dx, 0h
	div	cx
	add 	dl, '0' 
	mov	bh, dl	; El primer digito
	call 	w_char
	mov 	dl, bl
	call 	w_char
	pop 	bx
	mov	dl, bh 
	call	w_char
	mov 	dl, bl
	call 	w_char

	mov 	dl, 'h'
	call 	w_char
	
	ret



section .data

prueba: dd 	12345678h 	; 0x78 0x56 0x34 0x12
pa_x: 	dd	80d
si_pirata: 	dd	0 	
pa_y: 	dd 	25d
pb_x: 	dd 	70d
pb_y:	dd	53d
linea_ab_m: 	dd 	-2.88
s_sub: 	dd 	0
s_mul: 	dd 	0
s_sum: 	dd 	0
s_rnd:	dd 	0


msg 	db 	"Valor de prueba: $"
nl	db 	0xA, 0xD, "$"

; AX = 1234h
; [?] = 0x34 0x12

; EAX = 12345678
; [?] = 0x78 0x56 0x34 0x12
