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






/*
	3. Escreva um comando que exiba o nome da zona e a quantidade de bairros cadastrados em
	cada zona ordenado por nome de zona.
*/

SELECT Zona.Zona, count(*) as "Quantidade de bairros cadastrados." FROM Zona 
JOIN Bairro on (Zona.CodZona = Bairro.CodZona) GROUP BY Zona.Zona  






/*
	4. Escreva um comando que exiba o código, a descrição, a cidade e o estado dos imóveis
	ordenados por estado e cidade.
*/

SELECT CodImovel, Imovel, Cidade, Estado FROM Imovel
order by Estado, Cidade






/*
	5. Escreva um comando que exiba o código, a descrição, a área construída e o preço de venda
dos imóveis em ordem decrescente de preço por metro de área construída.
*/