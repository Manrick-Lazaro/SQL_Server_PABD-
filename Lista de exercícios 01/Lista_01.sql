-- Lista de Exerc�cios 1

/*
	1. Escreva um comando que exiba o c�digo, o nome e o percentual de comiss�o dos corretores
	em ordem decrescente de percentual de comiss�o.
*/

SELECT CodCorretor as c�digo, Corretor as nome, Comissao as "percentual de comiss�o" FROM Corretor ORDER BY Comissao DESC