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
	Departamento ON (Empregado.gerencia_cod_dep = Departamento.cod_dep)
INNER JOIN
	Divisao ON (Departamento.cod_dep = Divisao.cod_dep)
GROUP BY
	Departamento.nome , Divisao.nome 
ORDER BY 
	Departamento.nome , Divisao.nome 





/*
	Exercício 2991 - Estatísticas dos Departamentos

	Para cada departamento da empresa, mostrar o nome dele, a
	quantidade de empregados lotados, a média salarial, o maior
	salário e o menor salário. O resultado deve estar em ordem
	decrescente por média salarial.
*/

select * from Departamento
select * from Dependente
select * from Desconto
select * from Divisao
select * from Emp_desc
select * from Emp_venc
select * from Empregado
select * from Vencimento