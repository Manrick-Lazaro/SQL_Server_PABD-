-- Lista de Exercícios 1

/*
	1. Escreva um comando que exiba o código, o nome e o percentual de comissão dos corretores
	em ordem decrescente de percentual de comissão.
*/

SELECT CodCorretor as código, Corretor as nome, Comissao as "percentual de comissão" FROM Corretor ORDER BY Comissao DESC