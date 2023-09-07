.data 
.text 

	addiu $2,$0,-1			# r2 = -1
	addi $1,$2,1			# r1 = ffffffff + 1 = 0
	addu $3,$1,$2			# r3 = r1 + r2 = -1

	add $4,$3,$1			# r4 = 0+ffffffff= ffffffff	
	
	#sub
	sub $4,$4,$3			# r4 = 0
	#subu
	subu $9,$4,$2			# r9 = 0-(-1) = 1
	
	slt $3,$9,$2			# r3 = 0(r2=-1 < r9 = 1)
	sltu $1,$9,$2			# r1 = 1 (r2 = -1 = ffffffff > r9 = 00000001)
	
	xor $9,$9,$9			# r9 = 0
	nor $9,$9,$9			# r9 = ffffffff
	and $2,$2,$0			# r2 = 00000000
	or $10,$8,$9			# r10 = ffffffff
	srl $10,$10,16			# r10 = 0000ffff
	sll $9,$9,16			# r9 = ffff0000
	
	ori $3,$3,16			# r3 = 00000010
	
	sra $9,$9,16			# r9 = ffffffff
	andi $10,$10,240		# r10 = 000000f0
	lui $9,4369				# r9 = 11110000
	
	sw $9,-12($0)			# -12 = 11110000
	
	slti $9,$9,1			# $9 = 0
	lw $6,-12($0)			# r6 = 11110000
	addiu $9,$0,1			# r9 = 1
	addi $10,$0,5			# r10 = 5
	
L1:	
	jal L3					# r31 = next addr = 64
	subu $10,$10,$9			# r10 = 3
	
L2:
	j L4
	
L3:
	subu $10,$10,$9			#r10 = 4
	jr $31
	
L4:
	
