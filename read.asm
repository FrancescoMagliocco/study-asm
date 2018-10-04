section	.bss
	buf	resb	1	; 1000-byte buffer (in data section)

section	.data
	msg	db	"Enter something: "
	len	equ	$ - msg

section	.text
	global	_start

_start:
	mov	eax,	1	; sys_exit
	mov	ebx,	0	; exit status 0

	mov	ecx,	msg
	mov	edx,	len
	call	write
	call	read
	int	0x80

write:
	push	ebp
	push	eax
	push	ebx

	mov	ebp,	esp

	mov	eax,	4	; sys_write
	mov	ebx,	1	; stdout

	int	0x80

	mov	esp,	ebp

	pop	ebx
	pop	eax
	pop	ebp
	ret

read:
	push	ebp
	push	eax
	push	ebx
	push	ecx
	push	edx

	mov	ebp,	esp

loopa:
	mov	eax,	3	; sys_read
	mov	ebx,	0	; stdin
	mov	ecx,	buf	; buffer
	mov	edx,	4	; max length

	int	0x80

;	cmp	eax,	0	; end loop if read <= 0
;	jle	loopa

	push	ecx
	push	edx

	mov	ecx,	0x0a
	mov	edx,	1
	call	write

	pop	edx
	pop	ecx

	mov	ecx,	buf	; buffer
	mov	edx,	eax	; length
	call	write

	mov	esp,	ebp
	pop	edx
	pop	ecx
	pop	ebx
	pop	eax
	pop	ebp
;	call	write
	ret
