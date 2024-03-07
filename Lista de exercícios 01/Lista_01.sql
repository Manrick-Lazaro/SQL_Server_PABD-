-- Lista de Exerc�cios 1

/*
	1. Escreva um comando que exiba o c�digo, o nome e o percentual de comiss�o dos corretores
	em ordem decrescente de percentual de comiss�o.
*/

SELECT CodCorretor as c�digo, Corretor as nome, Comissao as "percentual de comiss�o" FROM Corretor ORDER BY Comissao DESC






/*
	2. Escreva um comando que exiba o c�digo e a descri��o dos im�veis com uma �rea constru�da
	compreendida entre uma faixa (valor inicial e valor final) fornecida como par�metro, ordenado
	pela descri��o do im�vel.
*/

SELECT CodImovel as c�digo, Imovel as descri��o FROM Imovel WHERE AreaConstruida BETWEEN 180 and 300 ORDER BY Imovel desc 




