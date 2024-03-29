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






/*
	3. Escreva um comando que exiba o nome da zona e a quantidade de bairros cadastrados em
	cada zona ordenado por nome de zona.
*/

SELECT Zona.Zona, count(*) as "Quantidade de bairros cadastrados." FROM Zona 
JOIN Bairro on (Zona.CodZona = Bairro.CodZona) GROUP BY Zona.Zona  






/*
	4. Escreva um comando que exiba o c�digo, a descri��o, a cidade e o estado dos im�veis
	ordenados por estado e cidade.
*/

SELECT CodImovel, Imovel, Cidade, Estado FROM Imovel
order by Estado, Cidade






/*
	5. Escreva um comando que exiba o c�digo, a descri��o, a �rea constru�da e o pre�o de venda
	dos im�veis em ordem decrescente de pre�o por metro de �rea constru�da.
*/

SELECT	CodImovel as c�digo, 
		Imovel as descri��o, 
		AreaConstruida as "Area Construida", 
		PrecoVenda/AreaConstruida as "pre�o de venda" 
FROM Imovel 
ORDER BY "pre�o de venda" DESC






/*
	6. Escreva um comando que exiba as cidades e o valor total dos im�veis existentes em cada
	cidade, listando apenas as cidades com mais de um im�vel.
*/

SELECT distinct Cidade, sum(Imovel.PrecoVenda) from Imovel group by Imovel.Cidade






/*
	7. Escreva um comando para apagar os corretores que n�o realizaram vendas.
*/

DELETE from Corretor 
WHERE Corretor.CodCorretor NOT IN (SELECT DISTINCT Venda.CodCorretor FROM Venda)






/*
	8. Escreva um comando para inserir um novo corretor.
*/

INSERT INTO Corretor (CodCorretor, Corretor, Comissao)
VALUES (4, 'Manrick', 1.5);