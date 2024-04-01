/*
	1. Crie um procedimento armazenado para exibir o código do livro, o título do livro e o nome do
	autor, por ordem crescente de título do livro e nome de autor. Apresente os comandos
	utilizados para executar este procedimento.
*/

CREATE PROCEDURE show_title_data
AS	
	WITH 
		title_table(cod_title, name_title, name_author) AS
	(
		SELECT 
			titles.title_id,
			titles.title,
			(
				SELECT		
					STRING_AGG(authors.au_lname, ', ')
				FROM
					titleauthor
				INNER JOIN 
					authors ON authors.au_id = titleauthor.au_id
				WHERE 
					titleauthor.title_id = titles.title_id
			) AS name_author
		FROM
			titles
	) 
	SELECT
		cod_title AS id_titulo, 
		name_title AS nome_titulo, 
		name_author AS nome_autor
	FROM
		title_table
	ORDER BY
		name_title, name_author

EXEC show_title_data



/*
	2. Crie um procedimento armazenado para exibir código do livro, o título do livro e a quantidade
	de autores do livro, ordenando por título do livro. Apresente os comandos utilizados para
	executar este procedimento.
*/

CREATE PROCEDURE title_count_authors AS
	WITH title_table(id_title, name_title, qtt_authors) AS
	(
		SELECT
			titles.title_id,
			titles.title,
			(
				SELECT 
					COUNT(*)
				FROM
					titleauthor
				INNER JOIN 
					authors ON authors.au_id = titleauthor.au_id
				WHERE
					titles.title_id = titleauthor.title_id
			)
		FROM
			titles
	)
	SELECT
		id_title,
		name_title,
		qtt_authors AS quantity_authors
	FROM
		title_table
	ORDER BY
		name_title

EXEC title_count_authors



/*
	3. Crie um procedimento armazenado para retornar como resultado a quantidade de editoras com
	mais de 5 livros editados. Apresente os comandos utilizados para executar este procedimento.
*/

CREATE PROCEDURE quantity_publishers_whith_more_than_5_titles AS
	DECLARE 
		@quantity int
	
	SELECT	
		@quantity = COUNT(*)
	FROM
	(
		SELECT	
			titles.pub_id
		FROM
			titles
		GROUP BY
			pub_id
		HAVING
			COUNT(*) > 5
	) AS publishers_with_more_than_5_titles

	RETURN @quantity

DECLARE @value int 

EXEC @value = quantity_publishers_whith_more_than_5_titles

PRINT @value