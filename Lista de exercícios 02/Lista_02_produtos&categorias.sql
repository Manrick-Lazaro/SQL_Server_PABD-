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

