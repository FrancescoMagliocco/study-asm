; vim: ft=nasm st=8 sts=8 sw=8

section	.data
	greeting:		db	"Number Guessing Game", 0x0a
	greetingL:		equ	$ - greeting

	mingen:		db	"Minimum generated number? "
	mingenL:		equ	$ - mingen
	maxgen:		db	"Maximum generated number? "
	maxgenL:		equ	$ - maxgen

	maxe:			db	"Maximum must be higher than minimum!", 0x0a
	maxeL:		equ	$ - maxe
	
	; not sure if these are being defined(?) correctly
	min:			dd	0
	max:			dd	0
	buf:			times	1	dd	0	; buf is allocated 4 byte?
	; buf:	times	100	dw	0		; buf is allocated 100 bytes?

section	.text
	global	_start

_start:
	mov	eax,	1	; sys_exit
	mov	ebx,	0	; exit status 0

.greeting:
	mov	ecx,	greeting
	mov	edx,	greetingL
	call	Write
	jmp	.mingen

;.byteamount:
;	mov	ecx,	byteamount
;	mov	edx,	byteamountL
;	call	Write

.mingen:
	mov	ecx,	mingen
	mov	edx,	mingenL
	call	Write
	
	mov	edi,	min	; moves address of min to edi?
	call	Read
	
	jmp	.maxgen

.regenmax:
	mov	ecx,	maxe
	mov	edx,	maxeL
	call	Write

.maxgen:
	mov	ecx,	maxgen
	mov	edx,	maxgenL
	call	Write
	
	mov	edi,	max	; moves address of max to edi?
	call	Read

	mov	ecx,	min
	mov	edx,	4
	call Write
	
	mov	ecx,	max
	; edx was previously set
	call Write

	mov	eax,	1	; sys_exit
	mov	ebx,	0	; exit status 0
	int	0x80
	

Write:
	push	eax
	push	ebx

	mov	eax,	4	; sys_write
	mov	ebx,	2	; stdout
	int	0x80

	pop	ebx
	pop	eax
	ret

Read:
	push	eax
	push	ebx

	mov	eax,	3	; sys_read
	mov	ebx,	0	; stdin
	
	mov	esi,	buf	; either address of min, or max
	movsw			; moves address of content at edi to to address of
				;	content at esi (buf)
	
	mov	ecx,	buf	; destination
					; either address of min, or max?
	mov	edx,	4	; max length
	int	0x80

;	call	Write

	cmp	eax,	edx	; all bytes read?

	; jb (jump if below) is used for unsigned
	jb	.readsuc	; jump if below

	.readfail:	mov	eax,	1	; sys_exit
			mov	ebx,	1	; exit status 1
			int	0x80

	.readsuc:	pop	ebx
			pop	eax
	ret

