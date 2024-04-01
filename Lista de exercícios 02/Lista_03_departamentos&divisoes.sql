-- Lista de excerc�cio 03 - Departamentos e Divis�es

/*
	Exerc�cio 2989 � Departamentos e Divis�es

	Para cada departamento, mostrar o nome do departamento, o
	nome de suas divis�es, com a respectiva m�dia salarial e o
	maior sal�rio de cada divis�o. O resultado deve estar em ordem
	decrescente usando a m�dia salarial.
*/

SELECT 
	Departamento.nome AS 'Nome do Departamento', 
	Divisao.nome AS 'Nome das divis�o', 
	ROUND( AVG(Vencimento.valor), 2) AS Media,  
	ROUND( MAX(Vencimento.valor), 2) AS Maior
FROM
	Emp_venc
INNER JOIN
	Empregado ON (Emp_venc.matr = Empregado.matr)
INNER JOIN
	Vencimento ON (Emp_venc.cod_venc = Vencimento.cod_venc)
INNER JOIN 
	Departamento ON (Empregado.lotacao = Departamento.cod_dep)
INNER JOIN
	Divisao ON (Departamento.cod_dep = Divisao.cod_dep)
GROUP BY
	Departamento.nome , Divisao.nome 
ORDER BY 
	Media desc 





/*
	Exerc�cio 2991 - Estat�sticas dos Departamentos

	Para cada departamento da empresa, mostrar o nome dele, a
	quantidade de empregados lotados, a m�dia salarial, o maior
	sal�rio e o menor sal�rio. O resultado deve estar em ordem
	decrescente por m�dia salarial.
*/

SELECT
	Departamento.nome AS 'nome do departamento',
	COUNT(*) AS 'quantidade de empregados',
	ROUND( AVG(Vencimento.valor), 2) AS 'm�dia salarias',  
	ROUND( MAX(Vencimento.valor), 2) AS 'maior sal�rio',
	ROUND( MIN(Vencimento.valor), 2) AS 'menor sal�rio'
FROM
	Emp_venc
JOIN
	Empregado ON (Emp_venc.matr = Empregado.matr)
JOIN
	Vencimento ON (Emp_venc.cod_venc = Vencimento.cod_venc)
JOIN 
	Departamento ON (Empregado.lotacao = Departamento.cod_dep)
GROUP BY
	Departamento.nome
ORDER BY
	'm�dia salarias' DESC





/*
	Exerc�cio 2992 � Divis�es com Maiores M�dias Salariais

	Listar as divis�es com maiores m�dias salariais dentro de seus
	departamentos. A sa�da dever� apresentar o nome do departamento, 
	o nome da divis�o com maior m�dia salarial do departamento e a 
	m�dia salarial da divis�o. O resultado deve estar em ordem 
	decrescente usando a m�dia salarial.
*/


WITH 
	Salarios(matr, nome, lotacao_div, lotacao, Salario ) AS
(
	SELECT 
		Empregado.matr, 
		Empregado.nome,
		Empregado.lotacao_div, 
		Empregado.lotacao,
		coalesce ( ( 
			SELECT 
				sum(Vencimento.valor)
			FROM 
				Emp_venc 
			INNER JOIN
				Vencimento ON Emp_venc.cod_venc = Vencimento.cod_venc
			WHERE 
				(Emp_venc.matr = Empregado.matr)
		), 0) -
		coalesce ( ( 
			SELECT 
				sum(Desconto.valor)
			FROM 
				Emp_desc 
			INNER JOIN
				Desconto ON Emp_desc.cod_desc = Desconto.cod_desc
			WHERE 
				(Emp_desc.matr = Empregado.matr)
		), 0) as Salario
	from Empregado
)
SELECT 
	Departamento.nome as NomeDep, 
	Divisao.nome as NomeDiv, 
	Round( avg(Salarios.Salario), 2) as Media,  
	Round( max(Salarios.Salario), 2) as Maior
FROM 
	Salarios
INNER JOIN 
	Departamento on (Salarios.lotacao = Departamento.cod_dep)
INNER JOIN 
	Divisao on (Salarios.lotacao_div = Divisao.cod_divisao)
GROUP BY 
	Departamento.nome , Divisao.nome 
ORDER BY 
	Departamento.nome , Divisao.nome






/*
	Exerc�cio 2997 � Pagamento dos Empregados

	Para cada empregado, listar nome do departamento, nome do
	empregado, sal�rio bruto, total de descontos e sal�rio l�quido. A
	sa�da deve estar agrupada por departamento e divis�o. Dentro
	de cada divis�o, a lista de empregados deve estar de forma
	decrescente por sal�rio l�quido.
*/

WITH 
	Salarios(matr, nome, lotacao_div, lotacao, Salario ) AS
(
	SELECT 
		Empregado.matr, 
		Empregado.nome,
		Empregado.lotacao_div, 
		Empregado.lotacao,
		coalesce ( ( 
			SELECT 
				sum(Vencimento.valor)
			FROM 
				Emp_venc 
			INNER JOIN
				Vencimento ON Emp_venc.cod_venc = Vencimento.cod_venc
			WHERE 
				(Emp_venc.matr = Empregado.matr)
		), 0) -
		coalesce ( ( 
			SELECT 
				sum(Desconto.valor)
			FROM 
				Emp_desc 
			INNER JOIN
				Desconto ON Emp_desc.cod_desc = Desconto.cod_desc
			WHERE 
				(Emp_desc.matr = Empregado.matr)
		), 0) as Salario
	from Empregado
) SELECT * FROM Salarios





/*
	Exerc�cio 2991 - Estat�sticas dos Departamentos

	Para cada departamento da empresa, mostrar o nome dele, a
	quantidade de empregados lotados, a m�dia salarial, o maior
	sal�rio e o menor sal�rio. O resultado deve estar em ordem
	decrescente por m�dia salarial.
*/

WITH 
	Salarios(matr, nome, lotacao_div, lotacao, Salario ) AS
(
	SELECT 
		Empregado.matr, 
		Empregado.nome,
		Empregado.lotacao_div, 
		Empregado.lotacao,
		coalesce ( ( 
			SELECT 
				sum(Vencimento.valor)
			FROM 
				Emp_venc 
			INNER JOIN
				Vencimento ON Emp_venc.cod_venc = Vencimento.cod_venc
			WHERE 
				(Emp_venc.matr = Empregado.matr)
		), 0) -
		coalesce ( ( 
			SELECT 
				sum(Desconto.valor)
			FROM 
				Emp_desc 
			INNER JOIN
				Desconto ON Emp_desc.cod_desc = Desconto.cod_desc
			WHERE 
				(Emp_desc.matr = Empregado.matr)
		), 0) as Salario
	FROM 
		Empregado
) 
SELECT
	Departamento.nome AS 'nome do departamento',
	COUNT(*) AS 'quantidade de empregados',
	ROUND( AVG(Salarios.Salario), 2) AS 'm�dia salarias',  
	ROUND( MAX(Salarios.Salario), 2) AS 'maior sal�rio',
	ROUND( MIN(Salarios.Salario), 2) AS 'menor sal�rio'
FROM
	Salarios
JOIN 
	Departamento ON (Salarios.lotacao = Departamento.cod_dep)
GROUP BY
	Departamento.nome
ORDER BY
	'm�dia salarias' DESC








/*
	Exerc�cio 2992 � Divis�es com Maiores M�dias Salariais

	Listar as divis�es com maiores m�dias salariais dentro de seus
	departamentos. A sa�da dever� apresentar o nome do departamento, 
	o nome da divis�o com maior m�dia salarial do departamento e a 
	m�dia salarial da divis�o. O resultado deve estar em ordem 
	decrescente usando a m�dia salarial.
*/

WITH 
	Salarios(matr, nome, lotacao_div, lotacao, Salario ) AS
(
	SELECT 
		Empregado.matr, 
		Empregado.nome,
		Empregado.lotacao_div, 
		Empregado.lotacao,
		coalesce ( ( 
			SELECT 
				sum(Vencimento.valor)
			FROM 
				Emp_venc 
			INNER JOIN
				Vencimento ON Emp_venc.cod_venc = Vencimento.cod_venc
			WHERE 
				(Emp_venc.matr = Empregado.matr)
		), 0) -
		coalesce ( ( 
			SELECT 
				sum(Desconto.valor)
			FROM 
				Emp_desc 
			INNER JOIN
				Desconto ON Emp_desc.cod_desc = Desconto.cod_desc
			WHERE 
				(Emp_desc.matr = Empregado.matr)
		), 0) as Salario
	FROM 
		Empregado
) ,
RankDivisao AS
(
	SELECT 
		Departamento.nome AS NomeDepartamento,
		Divisao.nome AS NomeDivisao,
		AVG(Salarios.salario) AS MediaSalarial,
		ROW_NUMBER() OVER(PARTITION BY Departamento.nome ORDER BY AVG(Salarios.salario) DESC) AS RankDivisao
	FROM
		Salarios
	JOIN
		Departamento ON (Departamento.cod_dep = Salarios.lotacao)
	JOIN
		Divisao ON (Divisao.cod_divisao = Salarios.lotacao_div)
	GROUP BY
		Divisao.nome, Departamento.nome
) 
SELECT 
	RankDivisao.NomeDepartamento,
	RankDivisao.NomeDivisao,
	RankDivisao.MediaSalarial
FROM
	RankDivisao
WHERE 
	RankDivisao.RankDivisao = 1
ORDER BY
	RankDivisao.MediaSalarial DESC







/*
	Exerc�cio 2997 � Pagamento dos Empregados

	Para cada empregado, listar nome do departamento, nome do
	empregado, sal�rio bruto, total de descontos e sal�rio l�quido. A
	sa�da deve estar agrupada por departamento e divis�o. Dentro
	de cada divis�o, a lista de empregados deve estar de forma
	decrescente por sal�rio l�quido.
*/

WITH 
	Salarios(matr, nome, lotacao_div, lotacao, salario_bruto, desconto, salario_liquido ) AS
(
	SELECT 
		Empregado.matr, 
		Empregado.nome,
		Empregado.lotacao_div, 
		Empregado.lotacao,
		coalesce ( (
			SELECT TOP 1
				Vencimento.valor
			FROM
				Emp_venc
			INNER JOIN
				Vencimento ON Emp_venc.cod_venc = Vencimento.cod_venc
			WHERE
				emp_venc.matr = Empregado.matr
		), 0) as salario_bruto,
		coalesce ( (
			SELECT TOP 1
				Desconto.valor
			FROM
				Emp_desc
			INNER JOIN
				Desconto ON Emp_desc.cod_desc = Desconto.cod_desc
			WHERE 
				Emp_desc.matr = Empregado.matr
		), 0) as desconto,
		coalesce ( ( 
			SELECT top 1
				Vencimento.valor
			FROM 
				Emp_venc 
			INNER JOIN
				Vencimento ON Emp_venc.cod_venc = Vencimento.cod_venc
			WHERE 
				(Emp_venc.matr = Empregado.matr)
		), 0) -
		coalesce ( ( 
			SELECT top 1
				Desconto.valor
			FROM 
				Emp_desc 
			INNER JOIN
				Desconto ON Emp_desc.cod_desc = Desconto.cod_desc
			WHERE 
				(Emp_desc.matr = Empregado.matr)
		), 0) as salario_liquido
	FROM 
		Empregado
),
DivisaoPorSalario AS
(
	SELECT 
		Departamento.nome AS Nome_Departamento,
		Divisao.Nome AS Divisao,
		Salarios.nome AS Nome_Empregado,
		Salarios.salario_bruto AS Salario_Bruto,
		Salarios.desconto AS Desonto,
		Salarios.salario_liquido AS Salario_Liquido,
		ROW_NUMBER() 
			OVER 
			(
				PARTITION BY 
					Divisao.nome 
				ORDER BY
					Salarios.salario_liquido DESC
			) AS Rank_Salario_Divisao
	FROM
		Salarios
	INNER JOIN 
		Departamento ON (Departamento.cod_dep = Salarios.lotacao)
	INNER JOIN 
		Divisao ON (Divisao.cod_divisao = Salarios.lotacao_div)
)
SELECT 
	Nome_Departamento,
	Nome_Empregado,
	Salario_Bruto,
	Desonto,
	Salario_Liquido
FROM	
	DivisaoPorSalario
WHERE 
	Rank_Salario_Divisao IS NOT NULL
ORDER BY 
	Salario_Liquido DESC







/*
	Exerc�cio 2999 � Maior Sal�rio da Divis�o

	Listar nome e sal�rio l�quido dos empregados que ganham
	mais que a m�dia salarial de sua divis�o. O resultado deve estar
	em ordem decrescente por sal�rio.
	
	Dica: Voc� pode utilizar a fun��o
	COALESCE(check_expression , 0) para substituir algum valor
	null por zero; al�m disso, voc� tamb�m pode utilizar a fun��o
	ROUND(value, 2) para exibir os valores com 2 casas decimais.
*/

WITH SalariosLiquidos AS (
    SELECT 
        Empregado.matr,
        Empregado.nome AS Nome,
        Empregado.lotacao_div,
        COALESCE(
            (SELECT TOP 1 Vencimento.valor
            FROM Emp_venc
            INNER JOIN Vencimento ON Emp_venc.cod_venc = Vencimento.cod_venc
            WHERE Emp_venc.matr = Empregado.matr), 0) -
            COALESCE(
            (SELECT TOP 1 Desconto.valor
            FROM Emp_desc
            INNER JOIN Desconto ON Emp_desc.cod_desc = Desconto.cod_desc
            WHERE Emp_desc.matr = Empregado.matr), 0) AS SalarioLiquido
    FROM 
        Empregado
),
MediasSalarios AS (
    SELECT 
        lotacao_div,
        AVG(SalarioLiquido) AS MediaSalarioDivisao
    FROM 
        SalariosLiquidos
    GROUP BY 
        lotacao_div
)
SELECT 
    S.Nome,
    ROUND(S.SalarioLiquido, 2) AS SalarioLiquido
FROM 
    SalariosLiquidos S
JOIN 
    MediasSalarios M ON S.lotacao_div = M.lotacao_div
WHERE 
    S.SalarioLiquido > M.MediaSalarioDivisao
ORDER BY 
    S.SalarioLiquido DESC;