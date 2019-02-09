.data
	i:
		.word 0x0
	
	temporaire1:
		.word 0x0
		
	temporaire2:
		.word 0x0
		
.global func_s

func_s:	

	condition:
		cmp i, $10		;On fait 10-i et on met active cmp va activer les bon eflags
						;cmp va metre ZF a 1 si dst = src ou CF a 1 si dst < src 
						;Dans notre cas i est src et 10 dst
					
		jna forLoop		;cmp src, dst 	ZF 	CF	
							;dst = src 		1 	0
							;dst < src 		0 	1
							;dst > src 		0 	0 
							;On utilise jna qui va faire un jump si i est <= a 10
		
		ja fin			;Si i > 10 alors on termine le programme
		
	forLoop:
		mov %d, %a		;On met la valeure de d dans a 
		add %e, %a		;On additione la valeure de e a ce qui est dans a et on met le resultat dans a
		sub %b, %a		;On soustrait la valeure de b a ce qui est dans a et on met le resultat dans a
		
		mov %b, temporaire1		;Mettre b a l'adresse de l'etiquette temporaire1
		sub $1000, %temporaire1	;Soustraire 1000 du contenu de l'etiquette temporaire1
		
		mov %c, temporaire2		;Mettre c a l'adresse de l'etiquette temporaire2
		add $500, temporaire2 	;Additionner 500 du contenu de l'etiquette temporaire2
		
		cmp temporaire1, temporaire2	;Fait temporaire2 (c+500) - temporaire1(b-1000)
		ja ifStatement					;Fait un jump si le resultat de la comparaison est > 0
		jna elseStatement				;Fait un jump si le resultat de la comparaison est <= 0 
	
	ifStatement:
		sub $500, %c		;Soustraction de 500 de c et placer le resultat dans cas
		cmp %c, %b			;Fait b-c et active les bon flags
		jna increment		;Si b-c < 0 ( c > 0 sortir du if et finir la boucle for)
		sub $500, %b		;Sinon retirer 500 de b et palcer dans b et finir la boucle for
		jmp increment
		
	
	elseStatement:
		sub %e, %b			;Soustraire e de b et placer le resultat dans b-1000
		add $500, %d		;Ajouter 500 a b et palcer le resultat dans dans
		jmp increment		;Finir la boucle for
	
	increment:
		add %i, $1 		;Incremente i a de 1 a chaque iteration de la boucle
		jmp condition	;Sans condition a chaque fin de boucle va revenir a l'etape de condition
		
	
	fin:
		ret
