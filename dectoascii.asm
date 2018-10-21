section	.text
	global	_start
_start:
;	push	ecx
;	push	ebx

;	mov	ebp,		esp
	
	mov	ebx,		0xa
	sub	esp,		0xa	; allocate 10 bytes
	mov	eax,		123	;
	
	mov	ecx,		10	; counter
.loop:
	cmp	eax,		0xa	; eax < 10
	jl	.last

	div	ebx
	
	add	edx,		0x30	; edx + 48 to get ascii digit
	mov	[esp+i],	edx	; put ascii digit in esp at cur index
	dec	dword		[i]	; go back an index

	loop	.loop
	jmp	.done
.last:
	add	edx,		0x30
	mov	[esp+i],	edx

.done:
	mov	edx,	10
	sub	edx,	ecx
	add	esp,	ecx
	mov	ecx,	esp
	mov	eax,	4
	mov	ebx,	2
	int	0x80

	mov	eax,	1
	mov	ebx,	0
	int	0x80


;	mov	esp,		ebp

;	pop	ebx
;	pop	ecx
	;ret

	
section	.data
	i:	dd	10
