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

