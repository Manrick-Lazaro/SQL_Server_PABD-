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



/*
	4. Crie um procedimento armazenado para inserir uma nova loja de livros. O comando deve
	apresentar uma mensagem de erro caso se tente inserir uma loja com código ou nome já
	existente. Apresente os comandos utilizados para executar este procedimento.
*/

ALTER PROCEDURE new_store
@id varchar(30), 
@name varchar(80),
@address varchar(60),
@city varchar(60),
@state varchar(60),
@zip varchar(60)
AS
	DECLARE 
		@name_exists varchar(80),
		@id_exists varchar(30),
		@error_name_msg varchar(300) = 'Usuário com este nome já existe.',
		@error_id_msg varchar(300) = 'Usuário com este código já esxite.';

	SELECT 
		@name_exists = stor_name
	FROM
		stores
	WHERE
		stor_name = @name
		
		
	SELECT 
		@id_exists = stor_id
	FROM
		stores
	WHERE	
		stor_id = @id

	IF (@name = @name_exists)
		BEGIN
			RAISERROR (@error_name_msg, 16, 1);
			RETURN;
		END
	ELSE IF (@id = @id_exists)
		BEGIN
			RAISERROR (@error_id_msg, 16, 1);
			RETURN 
		END

	INSERT 
		[dbo].[stores] ([stor_id], [stor_name], [stor_address], [city], [state], [zip])
	VALUES
		(@id, @name, @address, @city, @state, @zip)

EXEC new_store 
	'101', 
	'Santos do deus calor', 
	'788 Catamaugus Ave.', 
	'Seattle',
	'WA',
	'98056'
