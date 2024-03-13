-- Lista de excercício 03 - Departamentos e Divisões

/*
	Exercício 2989 – Departamentos e Divisões

	Para cada departamento, mostrar o nome do departamento, o
	nome de suas divisões, com a respectiva média salarial e o
	maior salário de cada divisão. O resultado deve estar em ordem
	decrescente usando a média salarial.
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
	Departamento.nome AS NomeDepartamento, 
	Divisao.nome AS NomeDivisao, 
	ROUND( AVG(Salarios.Salario), 2) AS Media,  
	ROUND( MAX(Salarios.Salario), 2) AS Maior
FROM 
	Salarios
INNER JOIN 
	Departamento ON (Salarios.lotacao = Departamento.cod_dep)
INNER JOIN 
	Divisao ON (Salarios.lotacao_div = Divisao.cod_divisao)
GROUP BY 
	Departamento.nome , Divisao.nome 
ORDER BY 
	Media DESC





/*
	Exercício 2991 - Estatísticas dos Departamentos

	Para cada departamento da empresa, mostrar o nome dele, a
	quantidade de empregados lotados, a média salarial, o maior
	salário e o menor salário. O resultado deve estar em ordem
	decrescente por média salarial.
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
	ROUND( AVG(Salarios.Salario), 2) AS 'média salarias',  
	ROUND( MAX(Salarios.Salario), 2) AS 'maior salário',
	ROUND( MIN(Salarios.Salario), 2) AS 'menor salário'
FROM
	Salarios
JOIN 
	Departamento ON (Salarios.lotacao = Departamento.cod_dep)
GROUP BY
	Departamento.nome
ORDER BY
	'média salarias' DESC








/*
	Exercício 2992 – Divisões com Maiores Médias Salariais

	Listar as divisões com maiores médias salariais dentro de seus
	departamentos. A saída deverá apresentar o nome do departamento, 
	o nome da divisão com maior média salarial do departamento e a 
	média salarial da divisão. O resultado deve estar em ordem 
	decrescente usando a média salarial.
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
	Exercício 2997 – Pagamento dos Empregados

	Para cada empregado, listar nome do departamento, nome do
	empregado, salário bruto, total de descontos e salário líquido. A
	saída deve estar agrupada por departamento e divisão. Dentro
	de cada divisão, a lista de empregados deve estar de forma
	decrescente por salário líquido.
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
	Exercício 2999 – Maior Salário da Divisão

	Listar nome e salário líquido dos empregados que ganham
	mais que a média salarial de sua divisão. O resultado deve estar
	em ordem decrescente por salário.
	
	Dica: Você pode utilizar a função
	COALESCE(check_expression , 0) para substituir algum valor
	null por zero; além disso, você também pode utilizar a função
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



select * from Departamento
select * from Dependente
select * from Desconto
select * from Divisao
select * from Emp_desc
select * from Emp_venc
select * from Empregado
select * from Vencimento