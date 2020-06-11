org 	100h

section .text

	call 	grafico	; Llamada a iniciar modo grafico 13h

	mov 	cx, 100d ; Columna 
	mov	dx, 100d ; Fila
	call 	pixel

	call 	kb		; Utilizamos espera de alguna tecla

	int 	20h

grafico:mov	ah, 00h
	mov	al, 13h
	int 	10h
	ret

pixel:	mov	ah, 0Ch
	mov	al, 1010b
	int 	10h
	ret

kb: 	mov	ah, 00h
	int 	16h
	ret

section .data