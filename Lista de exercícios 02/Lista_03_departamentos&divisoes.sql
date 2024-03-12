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


SELECT
	Departamento.nome AS 'nome do departamento',
	Divisao.nome AS 'Nome da divis�o',
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