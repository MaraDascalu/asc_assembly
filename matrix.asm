// Suma elementelor pare dintr-o matrice
.data
	n:		.long 4
	lineIndex: 	.space 4
	columnIndex: 	.space 4
	sum:		.space 4
	formatPrint:	.asciz "Suma este %d\n"
	newLine:	.asciz "\n"
	matrix:	.long 10, 12, 13, 1, 5, 17, 18, 2, 13, 4, 11, 6, 0, 9, 3, 5
	zero:		.long 0
	two:		.long 2
	
.text

.global main

main:

	lea matrix, %edi
	movl $0, lineIndex
	movl $0, sum
	
for_lines:
	movl lineIndex, %ecx
	cmp %ecx, n
	je afisare
	movl $0, columnIndex
	for_columns:
		movl columnIndex, %ecx
		cmp %ecx, n
		je cont_for_lines
		movl lineIndex, %eax
		mull n
		add columnIndex, %eax
		movl (%edi, %eax, 4), %ebx
		
		movl %ebx, %eax
		divl two
		cmp %edi, zero
		je suma
		
			
	cont_for_columns:
		add $1, columnIndex
		jmp for_columns
		
cont_for_lines:

	mov $4, %eax
	mov $1, %ebx
	mov $newLine, %ecx
	mov $2, %edx
	int $0x80
	
	add $1, lineIndex
	jmp for_lines
	
suma:
	add %ebx, sum
	jmp cont_for_columns	
	
afisare:
	
	push $sum
	push $formatPrint
	call printf
	pop %ebx
	pop %ebx
	
	push $0
	call fflush
	pop %ebx
			
et_exit:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
