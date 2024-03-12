-- Lista de excercício 03 - Departamentos e Divisões

/*
	Exercício 2989 – Departamentos e Divisões

	Para cada departamento, mostrar o nome do departamento, o
	nome de suas divisões, com a respectiva média salarial e o
	maior salário de cada divisão. O resultado deve estar em ordem
	decrescente usando a média salarial.
*/

SELECT 
	Departamento.nome AS 'Nome do Departamento', 
	Divisao.nome AS 'Nome das divisão', 
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
	Exercício 2991 - Estatísticas dos Departamentos

	Para cada departamento da empresa, mostrar o nome dele, a
	quantidade de empregados lotados, a média salarial, o maior
	salário e o menor salário. O resultado deve estar em ordem
	decrescente por média salarial.
*/

SELECT
	Departamento.nome AS 'nome do departamento',
	COUNT(*) AS 'quantidade de empregados',
	ROUND( AVG(Vencimento.valor), 2) AS 'média salarias',  
	ROUND( MAX(Vencimento.valor), 2) AS 'maior salário',
	ROUND( MIN(Vencimento.valor), 2) AS 'menor salário'
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
	'média salarias' DESC





/*
	Exercício 2992 – Divisões com Maiores Médias Salariais

	Listar as divisões com maiores médias salariais dentro de seus
	departamentos. A saída deverá apresentar o nome do departamento, 
	o nome da divisão com maior média salarial do departamento e a 
	média salarial da divisão. O resultado deve estar em ordem 
	decrescente usando a média salarial.
*/


SELECT
	Departamento.nome AS 'nome do departamento',
	Divisao.nome AS 'Nome da divisão',
	MAX (Vencimento.valor) AS 'maior valor'	
FROM
	Emp_venc
JOIN
	Empregado ON (Emp_venc.matr = Empregado.matr)
JOIN 
	Departamento ON (Empregado.lotacao = Departamento.cod_dep)
JOIN
	Divisao ON (Departamento.cod_dep = Divisao.cod_dep)
JOIN
	Vencimento ON (Emp_venc.cod_venc = Vencimento.cod_venc)
GROUP BY
	Divisao.nome, Departamento.nome


select * from Departamento
select * from Dependente
select * from Desconto
select * from Divisao
select * from Emp_desc
select * from Emp_venc
select * from Empregado
select * from Vencimento