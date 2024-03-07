-- Lista de Exercícios 1

/*
	1. Escreva um comando que exiba o código, o nome e o percentual de comissão dos corretores
	em ordem decrescente de percentual de comissão.
*/

SELECT CodCorretor as código, Corretor as nome, Comissao as "percentual de comissão" FROM Corretor ORDER BY Comissao DESC






/*
	2. Escreva um comando que exiba o código e a descrição dos imóveis com uma área construída
	compreendida entre uma faixa (valor inicial e valor final) fornecida como parâmetro, ordenado
	pela descrição do imóvel.
*/

SELECT CodImovel as código, Imovel as descrição FROM Imovel WHERE AreaConstruida BETWEEN 180 and 300 ORDER BY Imovel desc 




