section	.data
	msg	db	"Hello, world!", 0x0a
	len	equ	$ - msg

section	.text
	global	_start

_start:
	mov	ecx,	msg
	mov	edx,	len
	call	write
	mov	eax,	1
	mov	ebx,	0
	int	0x80

write:
	push	ebp
	push	eax
	push	ebx

	mov	ebp,	esp

	mov	eax,	4
	mov	ebx,	1
	; ecx is required to already have the bytes to write
	; edx is required to already have the amount of bytes to write
	int	0x80

	mov	esp,	ebp
	pop	ebx
	pop	eax
	pop	ebp
	ret
