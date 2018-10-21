section	.text
	global	_start
_start:
;	push	ecx
;	push	ebx

;	mov	ebp,		esp
	
	sub	esp,		0xa	; allocate 10 bytes
	mov	eax,		123	;
	
	mov	ecx,		10	; counter
.loop:
	mov	edx,		0x0	; zero edx
	mov	ebx,		0xa	; divisor
	cmp	eax,		0xa	; eax < 10
	jb	.last

	div	ebx
	mov	ebx,		[i]
	
	add	edx,		0x30	; edx + 48 to get ascii digit
	mov	[esp+ebx],	edx	; put ascii digit in esp at cur index
	dec	dword		[i]	; go back an index

	loop	.loop
	jmp	.done
.last:
	add	eax,		0x30	; eax + 48 to get ascii digit
	mov	ebx,		[i]
	mov	[esp+ebx],	eax	; put ascii digit in esp at cur index

.done:
	mov	edx,		10	; esp was allocated 10 bytes
	sub	edx,		ecx	; amount of bytes used
	add	esp,		ecx	; de-allocate(?) the unused bytes
	mov	ecx,		esp	; bytes to write
	mov	eax,		4	; sys_write
	mov	ebx,		2	; stdout
	int	0x80			; syscall

	mov	eax,		1	; sys_exit
	mov	ebx,		0	; exit code 0
	int	0x80			; syscall


;	mov	esp,		ebp

;	pop	ebx
;	pop	ecx
	;ret

	
section	.data
	i:	dd	10
