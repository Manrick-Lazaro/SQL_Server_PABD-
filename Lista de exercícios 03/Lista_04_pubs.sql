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