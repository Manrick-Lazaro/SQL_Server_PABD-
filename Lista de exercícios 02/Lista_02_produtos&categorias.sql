-- Lista de Exerc�cios 2 � Produtos e Categorias

/*
	Exerc�cio 2609 � Produtos por Categoria
	
	Como de costume o setor de vendas est� fazendo uma an�lise
	de quantos produtos temos em estoque, e voc� poder� ajudar
	eles.

	Ent�o seu trabalho ser� exibir o nome e a quantidade de
	produtos de cada uma categoria.
*/

SELECT Categories.name as Nome, count(*) as "Quantidade de produtos" FROM Categories
JOIN Products on (Categories.id = Products.id_categories) GROUP BY Categories.name






/*
	Exerc�cio 2617 � Fornecedor Ajax SA

	O setor financeiro encontrou alguns problemas na entrega de
	um dos nossos fornecedores, a entrega dos produtos n�o condiz
	com a nota fiscal.

	Seu trabalho � exibir o nome dos produtos e o nome do
	fornecedor, para os produtos fornecidos pelo fornecedor �Ajax
	SA�.
*/

SELECT Products.name, Providers.name FROM Products 
JOIN Providers ON Products.id_providers = Providers.id
WHERE Providers.name like 'Ajax SA'






/*
	Exerc�cio 2618 � Produtos Importados

	O setor de importa��o da nossa empresa precisa de um
	relat�rio sobre a importa��o de produtos do nosso fornecedor
	Sansul.

	Sua tarefa � exibir o nome dos produtos, o nome do fornecedor
	e o nome da categoria, para os produtos fornecidos pelo
	fornecedor �Sansul SA� e cujo nome da categoria seja ' Super
	Luxury'.
*/

SELECT 
	Products.name AS 'Nome do produto', 
	Providers.name AS 'Nome do fornecedor',
	Categories.name AS 'Nome da categoria'
FROM 
	Products
JOIN
	Providers ON Products.id_providers = Providers.id
JOIN 
	Categories ON Products.id_categories = Categories.id
WHERE 
	Providers.name = 'Sansul SA' AND Categories.name = 'Super Luxury'






/*
	Exerc�cio 2619 � Super Luxo

	A nossa empresa est� querendo fazer um novo contrato para o
	fornecimento de novos produtos superluxuosos, e para isso
	precisamos de alguns dados dos nossos produtos.

	Seu trabalho � exibir o nome dos produtos, nome dos
	fornecedores e o pre�o, para os produtos cujo pre�o seja maior
	que 1000 e sua categoria seja �Super Luxury�.
*/

SELECT 
	Products.name AS 'nome do produto',
	Providers.name AS 'nome do fornecedor',
	Products.price AS 'pre�o do produto'
FROM 
	Products
JOIN
	Providers ON (Products.id_providers = Providers.id)
JOIN 
	Categories on (Products.id_categories = Categories.id)
WHERE
	Products.price > 1000.00 
	AND
	Categories.id = (SELECT DISTINCT Categories.id FROM Categories WHERE Categories.name = 'Super Luxury')






/*
	Exerc�cio 2621 � Quantidades entre 10 e 20

	Na hora de entregar o relat�rio de quantos produtos a empresa
	tem em estoque, uma parte do relat�rio ficou corrompida, por
	isso o respons�vel do estoque lhe pediu uma ajuda, ele quer
	que voc� exiba os seguintes dados para ele.

	Exiba o nome dos produtos cujas quantidades estejam entre 10
	e 20 e cujo nome do fornecedor inicie com a letra �P�.
	Obs.: Os dados do banco de dados desta quest�o n�o est�o
	exatamente iguais ao do site.
*/

SELECT 
	Products.name AS 'nome do produto'
FROM 
	Products
JOIN 
	Providers on (Products.id_providers = Providers.id)
WHERE
	Products.amount BETWEEN 10 AND 20
	AND 
	Providers.name LIKE 'P%'


SELECT * FROM Products
SELECT * FROM Providers
SELECT * FROM Categories