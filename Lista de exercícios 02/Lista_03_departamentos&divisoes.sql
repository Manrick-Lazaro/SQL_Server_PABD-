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