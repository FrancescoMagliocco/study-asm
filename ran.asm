section .data
	num:	dd 0
section	.text
	global	_start
_start:
	

; test

	mov	ecx,	123
	; 123 / 10 = 12 % 3
	; 12 / 10 = 1 % 2
	; 1 / 10 = 0
	add	ecx,	0x30
	mov	[num],	ecx

	mov	ecx,	num

	mov	eax,	4
	mov	ebx,	2
	mov	edx,	1
	int	0x80

	mov	eax,	1
	mov	ebx,	0
	int	0x80




	rdrand	eax				; gen ran num in eax

	mov	ebp,		esp		; store cur esp in ebp
	sub	esp,		4		; allocate 4 bytes in esp
	mov	ebx,		esp		; store base of esp in ebx
	mov	ecx,		0		; counter for loop
.loop:
	; I'm thinking this didn't work beacuse [eax+ecx] is using the content
	; of both registers.
;	mov	edx,		[eax+ecx]	; mov first byte + ecx
						; (counter) in [eax] to edx

	mov	edx,		[eax]		; mov first in [eax] to edx
	inc	eax				; eax += 1

	; [esp+ecx] is using the content of both registers?
;	mov	[esp+ecx],	edx		; mov edx into first byte + ecx
						; (counter) of [esp]

	; this is confusing me a bit, would this be moving the content of edx
	; to the first byte of [esp]?  Or moving the address of edx, to the
	; first byte [esp]?
	mov	[esp],		edx
	inc	esp				; esp += 1
	inc	ecx				; inc ecx (counter) for loop
	cmp	ecx,		4		; if ecx < 4, jump to .loop
	jl	.loop

	mov	esp,		ebp		; restore original esp
	mov	ecx,		ebx		; mov ebx to ecx (Bytes to
						; write)

	mov	eax,		4		; sys_write
	mov	ebx,		2		; stdout
	mov	edx,		4		; Amount of bytes to write
	int	0x80				; syscall

	mov	eax,		1		; sys_exit
	mov	ebx,		0		; exit code 0
	int	0x80				; syscall
