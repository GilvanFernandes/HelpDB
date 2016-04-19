--Entrar banco
psql                                                                                                                 

--Lista todas as bases
psql -l            

--Parâmetro: Nome usuário
psql -U <nome-usuario>


--Mostra estrutura da tabela
\d nometabela

--Lista tabelas
\dt

--Lista indices
\di

--Lista sequências
\ds

--Lista views
\dv

--Ajuda geral dos comandos do psql
\?

--Conectar na base
\ c nome-da-base

--Mostrar as funcões
\df+

--Vai saber quem ultima sequencia
select * from tabela_campos-da-sequencia_seq                                                                         

--Concertar as sequencia
select setval('nome da sequence', (select max(campo do sequencial) from tabela)::integer);

--Criar template da base
create database nome_da_base_nova template base_de_origem;

--Importa os arquivos com delimitador)
copy bensbage from '/<caminho>/<nome-do-arquivo>.csv' delimiter '|';                                                 

--Exporta dados da base para algum arquivo
copy () to '/home/usuarios/teste.csv' with delimiter ';';

--Lista os processos rolando
select * from pg_stat_activity;

--Matar o processo
select * from pg_terminate_backend(PID do processo);

--Dump de uma tabela com insert
pg_dump -U postgres -h <host> <base> -t <tabela> --inserts > /<nome>.sql                                             

--Rastaurar uma tabela especifica
pg_restore -U usuario -h ip_servidor -a -t tabela_especifica -d nome_do_banco arquivo.dump                           

--Restautar uma base inteira
pg_restore -U postgres -d <nome-da-base> /var/www/nome_do_arquivo.pgbkp                                              

--Dump de uma base
pg_dump dbname -h localhost -U postgres > backup.sql                                                                 

--Dump de schema especifico
pg_dump -U postgres --schema nome_do_schema schema_estrutura > /home/usuarios/schema2.sql                          

--Verificar tipo de enconding de entrada de informacao que banco aceita
show client_encoding ;

--Alterar tipo de encondin que banco vai aceitar na entrada da informacao
set client_encoding = 'LATIN1' ;

--Mostra a estrutura da funcao/trigger
select * from pg_proc where proname = 'nome_da_funcao_trigger';                                                       