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




/*
	5. Crie um procedimento armazenado para apagar as lojas de livros que não realizaram vendas.
	Apresente os comandos utilizados para executar este procedimento.
*/

CREATE PROCEDURE delete_store_with_lass_than_null_sales AS
	DELETE FROM	
		stores	
	WHERE
		stor_id NOT IN (SELECT DISTINCT stor_id FROM sales)
		

EXEC delete_store_with_lass_than_null_sales



/*
	6. Crie um procedimento armazenado para listar os livros da editora com maior quantidade de
	títulos editados. Apresentar a listagem incluindo a editora, o título do livro e o nome dos
	autores.
*/

CREATE PROCEDURE list_books_by_top_publisher AS
BEGIN
    WITH top_publisher AS (
        SELECT TOP 1 WITH TIES pub_id
        FROM titles
        GROUP BY pub_id
        ORDER BY COUNT(*) DESC
    )
    SELECT 
        publishers.pub_name AS editora,
        titles.title AS titulo_livro,
        STRING_AGG(authors.au_lname, ', ') AS nome_autores
    FROM 
        titles
    INNER JOIN 
        publishers ON publishers.pub_id = titles.pub_id
    INNER JOIN 
        titleauthor ON titles.title_id = titleauthor.title_id
    INNER JOIN 
        authors ON titleauthor.au_id = authors.au_id
    WHERE 
        titles.pub_id IN (SELECT pub_id FROM top_publisher)
    GROUP BY 
        publishers.pub_name, titles.title;
END;

EXEC list_books_by_top_publisher



/*
	7. Crie um procedimento armazenado que retorne em um parâmetro de saída o nome do autor
	cujo valor médio de custo dos seus livros seja o mais alto. Apresentar os comandos para
	acionar o procedimento e mostrar o nome do autor.
*/

CREATE PROCEDURE get_author_with_highest_avg_cost
    @author_name VARCHAR(100) OUTPUT
AS
BEGIN
    SELECT TOP 1 @author_name = 
        authors.au_lname
    FROM 
        authors
    INNER JOIN 
        titleauthor ON authors.au_id = titleauthor.au_id
    INNER JOIN 
        titles ON titleauthor.title_id = titles.title_id
    GROUP BY 
        authors.au_lname
    ORDER BY 
        AVG(titles.price) DESC;
END;

DECLARE @author VARCHAR(100);
EXEC get_author_with_highest_avg_cost @author OUTPUT;
SELECT 'Autor com valor médio de custo mais alto: ' + COALESCE(author, 'Nenhum autor encontrado') AS 'Autor';



/*
	8. Crie um procedimento armazenado para apresentar a lista de títulos nos quais a soma dos
	royalties sobre as vendas que os autores têm direito difere de 100%.
*/
CREATE PROCEDURE list_titles_with_unequal_royalties
AS
BEGIN
    SELECT 
        titles.title_id,
        titles.title,
        SUM(titleauthor.royaltyper) AS total_royalties
    FROM 
        titles
    INNER JOIN 
        titleauthor ON titles.title_id = titleauthor.title_id
    GROUP BY 
        titles.title_id, titles.title
    HAVING 
        ABS(SUM(titleauthor.royaltyper) - 100) > 0.001; -- Verificando se a diferença é maior que 0.1%
END;

EXEC list_titles_with_unequal_royalties;

/*
	9. Crie um procedimento armazenado que liste o nome e o telefone dos autores que não têm
	livros publicados. Apresente os comandos utilizados para executar este procedimento.
*/

CREATE PROCEDURE list_authors_without_books
AS
BEGIN
    SELECT 
        au_fname + ' ' + au_lname AS nome_autor,
        phone AS telefone
    FROM 
        authors
    WHERE 
        au_id NOT IN (SELECT DISTINCT au_id FROM titleauthor);
END;

EXEC list_authors_without_books;



/*
10. Crie um procedimento armazenado que retorne o valor total vendido por um livro passado
como parâmetro. Apresente os comandos utilizados para executar este procedimento.
*/

CREATE PROCEDURE get_total_sales_by_book
    @book_title VARCHAR(255),
    @total_sales MONEY OUTPUT
AS
BEGIN
    SELECT @total_sales = SUM(qty * price)
    FROM sales
    WHERE title_id = (SELECT title_id FROM titles WHERE title = @book_title);
END;

DECLARE @total_sales MONEY;
EXEC get_total_sales_by_book 'Nome do Livro', @total_sales OUTPUT;
SELECT @total_sales AS 'Total de Vendas';



/*
11. Crie um procedimento armazenado que retorne o valor total de royalties devido a um autor
passado como parâmetro. Apresente os comandos utilizados para executar este procedimento.
*/

CREATE PROCEDURE get_total_royalties_by_author
    @author_id VARCHAR(255),
    @total_royalties MONEY OUTPUT
AS
BEGIN
    SELECT @total_royalties = SUM(royaltyper * price * qty)
    FROM titleauthor
    INNER JOIN titles ON titleauthor.title_id = titles.title_id
    INNER JOIN sales ON titles.title_id = sales.title_id
    WHERE titleauthor.au_id = @author_id;
END;

DECLARE @total_royalties MONEY;
EXEC get_total_royalties_by_author 'ID do Autor', @total_royalties OUTPUT;
SELECT @total_royalties AS 'Total de Royalties';



/*
12. Crie um procedimento armazenado que retorne o valor total de royalties devidos por uma
editora passada como parâmetro. Apresente os comandos utilizados para executar este
procedimento.
*/

CREATE PROCEDURE get_total_royalties_by_publisher
    @publisher_id VARCHAR(255),
    @total_royalties MONEY OUTPUT
AS
BEGIN
    SELECT @total_royalties = SUM(titleauthor.royaltyper * titles.price * sales.qty)
    FROM titleauthor
    INNER JOIN titles ON titleauthor.title_id = titles.title_id
    INNER JOIN sales ON titles.title_id = sales.title_id
    WHERE titles.pub_id = @publisher_id;
END;

DECLARE @total_royalties MONEY;
EXEC get_total_royalties_by_publisher 'ID da Editora', @total_royalties OUTPUT;
SELECT @total_royalties AS 'Total de Royalties';