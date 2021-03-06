org 	100h

section .text

	xor 	si, si
	xor 	di, di

	mov     dx, msg
	call    w_strng

	mov     di, prueba
	call    w_32reg

	mov 	dx, nl	
	call 	w_strng

	mov 	di, prueba_doble
	call 	w_64reg
	
	mov 	dx, nl	
	call 	w_strng

	call func_y

	int 	20h



func_y:
	; [?] = 20 00 00 00
	; SI_PIRATA = 00000020h
	mov 	di, word [s_sub] ; Solo para revisar el valor de s_sub 0164h

	mov 	byte [si_pirata], 79d

	finit
	fld 	dword [si_pirata] ; 4Fh ST1
	fld 	dword [pa_x]	; 50h	ST0
	fsub 		
	fst	dword [s_sub] ; 80 00 00 30 = -30  ST1-ST0
	mov	dx, msg_sub
	call 	w_strng
	mov 	di, s_sub
	call	w_32reg
	mov 	dx, nl	
	call 	w_strng

	fld 	dword [linea_ab_m]	
	fmul
	fst 	dword [s_mul]	
	mov	dx, msg_mul
	call 	w_strng
	mov 	di, s_mul
	call	w_32reg
	mov 	dx, nl	
	call 	w_strng

	fld 	dword [pa_y]	
	fadd
	fst 	dword [s_sum]
	fst 	qword [double]

	mov	dx, msg_sum
	call 	w_strng

	mov 	di, s_sum
	call	w_32reg

	mov 	dx, nl	
	call 	w_strng

	mov 	di, double
	call 	w_64reg

	ret

w_char: mov	ah, 02h
	mov	al, 00h
	int 	21h
	ret

w_strng:mov	ah, 09h
	int 	21h
	ret

c_add:
	cmp	dl, 9 
	ja      more
	add 	dl, '0'	
	jmp 	c_add_e
more:	add 	dl, 37h
c_add_e:ret


w_32reg:
	add 	di, 2h
	mov 	si, 0h	
lupi_32:
	mov 	ax, [di]
	mov	cx, 16d 

	mov 	dx, 0h
	div	cx
	call 	c_add

	mov 	bl, dl ; El octavo digito

	mov 	dx, 0h
	div	cx
	call 	c_add
	mov	bh, dl	; El septimo digito

	push 	bx

	mov 	dx, 0h
	div	cx
	call 	c_add

	mov 	bl, dl ; El sexto digito

	mov 	dx, 0h
	div	cx
	call 	c_add
	mov	bh, dl	; El quinto digito
	call 	w_char
	mov 	dl, bl
	call 	w_char
	pop 	bx
	mov	dl, bh 
	call	w_char
	mov 	dl, bl
	call 	w_char

	sub 	di, 2h
	inc	si	
	cmp 	si, 2h
	jb	lupi_32

	mov 	dl, 'h'
	call 	w_char

	ret

w_64reg:
	add 	di, 6h
	mov 	si, 0h	
lupi_64:	
	mov 	ax, [di]
	mov	cx, 16d 

	mov 	dx, 0h
	div	cx
	call 	c_add

	mov 	bl, dl ; El cuarto digito

	mov 	dx, 0h
	div	cx
	call 	c_add
	mov	bh, dl	; El tercer digito

	push 	bx

	mov 	dx, 0h
	div	cx
	call 	c_add

	mov 	bl, dl ; El segundo digito

	mov 	dx, 0h
	div	cx
	call 	c_add
	mov	bh, dl	; El primer digito
	call 	w_char
	mov 	dl, bl
	call 	w_char
	pop 	bx
	mov	dl, bh 
	call	w_char
	mov 	dl, bl
	call 	w_char
	sub 	di, 2h
	inc	si	
	cmp 	si, 4h
	jb	lupi_64
	
	mov 	dl, 'h'
	call 	w_char

	ret


section .data

prueba: dd 	12345678h 	; 0x78 0x56 0x34 0x12
prueba_doble: 	dq	0x123456789ABCDEF0

si_pirata: 	dd	0 	
double:		dq	0

pa_x: 	dd	50h ;80d
pa_y: 	dd 	25h ;25d
pb_x: 	dd 	46h ;70d
pb_y:	dd	35h ;53d
linea_ab_m: 	dd -2.88

msg_sub db 	"Valor de resta: $"
s_sub: 	dd 	0
msg_mul db 	"Valor de multiplicacion: $"
s_mul: 	dd 	0
msg_sum db 	"Valor de suma: $"
s_sum: 	dd 	0
msg_rnd db 	"Valor de redondeo: $"
s_rnd:	dd 	0


msg 	db 	"Valor de prueba: $"
nl	db 	0xA, 0xD, "$"

; AX = 1234h
; [?] = 0x34 0x12

; EAX = 12345678
; [?] = 0x78 0x56 0x34 0x12
