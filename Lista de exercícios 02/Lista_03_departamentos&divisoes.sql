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
	Departamento.nome , Divisao.nome 




select * from Departamento
select * from Dependente
select * from Desconto
select * from Divisao
select * from Emp_desc
select * from Emp_venc
select * from Empregado
select * from Vencimento