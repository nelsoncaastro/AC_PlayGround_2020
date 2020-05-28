org	100h

section .text

	call 	texto  	;iniciamos modo texto

	xor 	si, si 	;lo mimso que: mov si, 0000h
lupi:	call 	kb
	cmp 	al, "$"
	je	mostrar
	mov	[300h+si], al ; CS:0300h en adelante
	inc 	si
	jmp 	lupi

mostrar:call 	w_strng

	call 	kb	; solo detenemos la ejecución

	int 	20h

texto:	mov 	ah, 00h
	mov	al, 03h
	int 	10h
	ret

kb:	mov	ah, 00h ;subrutina que detiene la ejecución hasta recibir
	int 	16h	;algun carácter en el buffer del teclado
	ret		;este carácter lo guarda en el registro AL

w_strng:mov	ah, 13h
	mov 	al, 01h ; asigna a todos los caracteres el atributo de BL,
			; actualiza la posición del cursor
	mov 	bh, 00h ; número de página
	mov	bl, 00001111b ; atributo de caracter
	mov	cx, si ; tamaño del string (SI, porque todavía guarda la última posición)
	mov	dl, 10h ; columna inicial
	mov	dh, 7h	; fila inicial
	; Como esta interrupción saca el string de ES:BP, tenemos que poner los valores correcpondientes
	push 	cs ; Segmento actual en el que está guardado nuestro string
	pop	es ; Puntero al segmento que queremos 
	mov	bp, 300h ; Dirección inicial de nuestra cadena de texto

	int 10h
	ret
