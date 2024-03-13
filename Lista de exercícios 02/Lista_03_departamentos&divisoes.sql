-- Lista de excerc�cio 03 - Departamentos e Divis�es

/*
	Exerc�cio 2989 � Departamentos e Divis�es

	Para cada departamento, mostrar o nome do departamento, o
	nome de suas divis�es, com a respectiva m�dia salarial e o
	maior sal�rio de cada divis�o. O resultado deve estar em ordem
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
	Exerc�cio 2997 � Pagamento dos Empregados

	Para cada empregado, listar nome do departamento, nome do
	empregado, sal�rio bruto, total de descontos e sal�rio l�quido. A
	sa�da deve estar agrupada por departamento e divis�o. Dentro
	de cada divis�o, a lista de empregados deve estar de forma
	decrescente por sal�rio l�quido.
*/





select * from Departamento
select * from Dependente
select * from Desconto
select * from Divisao
select * from Emp_desc
select * from Emp_venc
select * from Empregado
select * from Vencimento