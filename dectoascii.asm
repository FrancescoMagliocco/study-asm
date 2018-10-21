section	.text
	global	_start
_start:
	sub	esp,	0xa
	mov	eax,	123
	mov	ebx,	0xa

	mov	ecx,	0xa

	.loop:
		cmp	eax,	0x0
		jz	.done

		mov	edx,	0x0
		div	ebx
		add	edx,	0x30

		mov	[esp+ecx],	dl
		loop	.loop
.done:
	mov	edx,	0xa
	
	sub	edx,	ecx	; amount of bytes to write
	
	add	esp,	ecx	; remove extra allocated bytes(?)

	mov	eax,	4	; sys_write
	mov	ebx,	2	; stdout
	mov	ecx,	esp	; bytes to write
	int	0x80

	mov	eax,	1	; sys_exit
	mov	ebx,	0	; exit code 0
	int	0x80
