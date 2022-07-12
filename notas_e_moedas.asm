.data
	valor: .float 576.73
	notasValor: .word 10000, 5000, 2000, 1000, 500, 200
	moedasValor: .word 100, 50, 25, 10, 5, 1

	scale: .float 100
	
	notas: .asciiz  "NOTAS:\n"
	moedas: .asciiz "MOEDAS:\n"
	
	textNota: .asciiz " nota(s) de R$ "
	textMoeda: .asciiz " moeda(s) de R$ "
	textNewLine: .asciiz "\n"
.text
	#CARREGAR NOTAS E MOEDAS * 100
	la $s1, notasValor
	la $s2, moedasValor
	
	#CARREGAR VALOR E MULTILPICAR POR 100
	#carregando como float
	l.s $f1, valor
	l.s $f2, scale
	
	#multiplicando por 100 e convertendo pra inteiro
	mul.s $f1, $f1, $f2
	cvt.w.s $f1, $f1
	
	cvt.w.s $f2, $f2
	
	#s0 contem o valor inteiro
	mfc1 $s0, $f1
	mfc1 $s3, $f2

main:
	# i = 0
	addi $t0, $zero, 0
	
	li $v0, 4
	la $a0, notas
	syscall
	
	while1: 
		bgt $t0, 20, exit1
		
		#argumento 0 = valor
		addi $a0, $s0, 0
		#argumento 1 = nota[i]
		lw $a1, 0($s1)
	
		jal calcula_nota		
		
		addi $t0, $t0, 4 #i += 4
		addi $s1, $s1, 4
		
		j while1
	
	exit1:
	
	li $v0, 4
	la $a0, moedas
	syscall
	
	addi $t0, $zero, 0
	while2: 
		bgt $t0, 20, exit2
		
		#argumento 0 = valor atual
		addi $a0, $s0, 0
		#argumento 1 = moeda[i]
		lw $a1, 0($s2)
		
		jal calcula_moeda
		
		addi $t0, $t0, 4 #i += 4
		add $s2, $s2, 4
		
		j while2
	
	exit2:
	
	li $v0, 10
	syscall
	#Fim de Código
	
calcula_nota:
	#a0 = valor ; a1 = nota atual

	move $t8, $a0 #valor em t8
	move $t9, $a1 #nota atual em t9
	
	div $t8, $t9
	#separando inteiro de LO em t2
	mflo $a0 #quantidade de notas
	
	#mudando o valor para o resto que temos agora
	mfhi $s0 #restante
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	#print_nota(Quantidade, Nota)
	jal print_nota
	
	lw $ra, 0($sp)
	
	jr $ra
	
print_nota:

	li $v0, 1
	#a0 já tem o valor da quantidade
	syscall
	
	li $v0, 4
	la $a0, textNota
	syscall
	
	li $v0, 1
	div $a0, $a1, $s3
	syscall
	
	li $v0, 4
	la $a0, textNewLine
	syscall

	jr $ra

calcula_moeda:

	#a0 = valor ; a1 = nota atual

	move $t8, $a0 #valor em t8
	move $t9, $a1 #nota atual em t9
	
	div $t8, $t9
	#separando inteiro de LO em t2
	mflo $a0 #quantidade de moedas
	
	#mudando o valor para o resto que temos agora
	mfhi $s0 #restante
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	#print_moeda(Quantidade, Moeda)
	jal print_moeda
	
	lw $ra, 0($sp)
	
	jr $ra
	
print_moeda:

	li $v0, 1
	#a0 já tem o valor da quantidade
	syscall
	
	li $v0, 4
	la $a0, textMoeda
	syscall
	
	#Valor das moedas
	li $v0, 2
	mtc1 $a1, $f12
	div.s $f12, $f12, $f2
	syscall 

	li $v0, 4
	la $a0, textNewLine
	syscall

	jr $ra


