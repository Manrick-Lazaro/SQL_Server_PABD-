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
	Exercício 2997 – Pagamento dos Empregados

	Para cada empregado, listar nome do departamento, nome do
	empregado, salário bruto, total de descontos e salário líquido. A
	saída deve estar agrupada por departamento e divisão. Dentro
	de cada divisão, a lista de empregados deve estar de forma
	decrescente por salário líquido.
*/





select * from Departamento
select * from Dependente
select * from Desconto
select * from Divisao
select * from Emp_desc
select * from Emp_venc
select * from Empregado
select * from Vencimento