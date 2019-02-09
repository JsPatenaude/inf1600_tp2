.data
	i:
		.word 0x0
	
	temporaire1:
		.word 0x0
		
	temporaire2:
		.word 0x0
		
.global func_s

;//a mit dans aucun registre
;//e mit dans eax
;//b mit dans ebx
;//c mit dans ecx
;//d mit dans edx
;//temporaire1 mit dans ax (accumulateur)
;//i mit dans cx (registre pour compteur)


func_s:	

	condition:
		mov i, %cx		;//mettre i dans register cx (qui est utile pour faire compteurs)
		cmp $10, %cx	;//On fait 10-i et on met active cmp va activer les bon eflags
						;//cmp va metre ZF a 1 si dst = src ou CF a 1 si dst < src 
						;//Dans notre cas i est src et 10 dst
					
		jna forLoop		;//cmp src, dst 	ZF 	CF	
							;//dst = src 		1 	0
							;//dst < src 		0 	1
							;//dst > src 		0 	0 
							;//On utilise jna qui va faire un jump si i est <= a 10
		
		ja fin			;//Si i > 10 alors on termine le programme
		
	forLoop:
		mov d, %edx		;//met valeur de d dans registre edx
		mov %edx, a		;//On met la valeure du registre edx dans a
		mov e, %eax		;//e mis dans eax
		add %eax, a		;//On additione la valeure de e a ce qui est dans a et on met le resultat dans a
		mov b, %ebx
		sub %ebx, a		;//On soustrait la valeure de b a ce qui est dans a et on met le resultat dans a
		
		mov %ebx, temporaire1	;//Mettre b a l'adresse de l'etiquette temporaire1
		subl $1000, temporaire1	;//Soustraire 1000 du contenu de l'etiquette temporaire1
		
		mov c, %ecx				;//mettre c dans register ecx
		mov %ecx, temporaire2	;//Mettre contenu ecx a l'adresse de l'etiquette temporaire2
		addl $500, temporaire2 	;//Additionner 500 du contenu de l'etiquette temporaire2
		
		mov temporaire1, %ax			;//mettre temporaire1 dans le registre ax (est un accumulateur, utile pour utilisation logique ou arithmetique)
		cmp %ax, temporaire2	;//Fait temporaire2 (c+500) - temporaire1(b-1000)
		ja ifStatement					;//Fait un jump si le resultat de la comparaison est > 0
		jna elseStatement				;//Fait un jump si le resultat de la comparaison est <= 0 
	
	ifStatement:
		sub $500, %ecx		;//Soustraction de 500 de c et placer le resultat dans c
		cmp %ecx, %ebx			;//Fait b-c et active les bon flags
		jna increment		;//Si b-c < 0 ( c > 0 sortir du if et finir la boucle for)
		sub $500, %ebx		;//Sinon retirer 500 de b et palcer dans b et finir la boucle for
		jmp increment
		
	
	elseStatement:
		sub %eax, %ebx			;//Soustraire e de b et placer le resultat dans b-1000
		add $500, %edx		;//Ajouter 500 a b et palcer le resultat dans dans
		jmp increment		;//Finir la boucle for
	
	increment:
		add $1, %cx 		;//Incremente i a de 1 a chaque iteration de la boucle
		jmp condition	;//Sans condition a chaque fin de boucle va revenir a l'etape de condition
		
	
	fin:
ret
