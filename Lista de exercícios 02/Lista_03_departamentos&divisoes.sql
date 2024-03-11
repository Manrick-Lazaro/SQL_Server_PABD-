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
	Departamento ON (Empregado.gerencia_cod_dep = Departamento.cod_dep)
INNER JOIN
	Divisao ON (Departamento.cod_dep = Divisao.cod_dep)
GROUP BY
	Departamento.nome , Divisao.nome 
ORDER BY 
	Departamento.nome , Divisao.nome 





/*
	Exerc�cio 2991 - Estat�sticas dos Departamentos

	Para cada departamento da empresa, mostrar o nome dele, a
	quantidade de empregados lotados, a m�dia salarial, o maior
	sal�rio e o menor sal�rio. O resultado deve estar em ordem
	decrescente por m�dia salarial.
*/

select * from Departamento
select * from Dependente
select * from Desconto
select * from Divisao
select * from Emp_desc
select * from Emp_venc
select * from Empregado
select * from Vencimento