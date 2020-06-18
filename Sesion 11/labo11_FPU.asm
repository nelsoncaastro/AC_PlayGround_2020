org 	100h

section .text

	xor 	si, si
	xor 	di, di

	finit   ; Poner los registros del FPU en su valor por defecto
	cmp 	si, prueba
	mov 	si, word [pa_x]
	mov 	[si_pirata], si
	mov 	si, 80d
	mov 	[si_pirata], si
	mov	di, pa_y

	call 	func_y

	call 	kb		; Utilizamos espera de alguna tecla

	int 	20h


func_y:
	mov 	[si_pirata], si
	cmp 	0, s_sub
	fld 	dword [si_pirata]
	fld 	dword [pa_x]
	fsub 		
	fstp	dword [s_sub]

	fld 	dword [linea_ab_m]	
	fmul
	fstp	dword [s_mul]

	fld 	dword [pa_y]
	fadd
	fstp	dword [s_sum]

	frndint
	fstp	dword [s_mul]
	fstp	dword [si_pirata]
	mov	di, word [si_pirata]
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
