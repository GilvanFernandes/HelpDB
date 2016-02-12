psql                                                                                                                 (Entrar banco)
                    
-l                                                                                                                   (Lista todas as bases)

-U <nome-usuario>                                                                                                    (Parâmetro: Nome usuário)

d                                                                                                                    (Lista tabelas, índices, sequências ou views)

\d nometabela                                                                                                        (Mostra estrutura da tabela)

\dt                                                                                                                  (lista tabelas)

\di                                                                                                                  (Lista indices)

\ds                                                                                                                  (Lista sequências)

\dv                                                                                                                  (Lista views)

\?                                                                                                                   (Ajuda geral dos comandos do psql)

\ c nome-da-base                                                                                                     (Conectar na base)

\df+                                                                                                                 (Mostrar as funcões)

select * from tabela_campos-da-sequencia_seq                                                                         (Vai saber quem ultima sequencia)

select setval('rhipe_rh14_sequencia_seq', (select max(rh14_sequencia) from rhipe)::integer);                         (Concertar as sequencia)

select fc_startsession();                                                                                            (Monta todos os schema da base)

create database base_financeiro template <nome-da-base-base>;                                                     (Criar template da base)

copy bensbage from '/<caminho>/<nome-do-arquivo>.csv' delimiter '|';                                                 (Importa os arquivos com delimitador) 

copy () to '/home/usuarios/teste.csv' with delimiter ';';                                                            (Exporta dados da base para algum arquivo)
           
select * from pg_stat_activity;                                                                                      (Lista os processos rolando)

select * from pg_terminate_backend(PID do processo);                                                                 (Matar o processo)

pg_dump -U postgres -h <host> <base> -t <tabela> --inserts > /<nome>.sql                                             (Dump de uma tabela)

pg_restore -U usuario -h ip_servidor -a -t tabela_especifica -d nome_do_banco arquivo.dump                           (Rastaurar uma tabela especifica)

pg_restore -U postgres -d <nome-da-base> /var/www/taquari_20141230.pgbkp                                              (Restautar uma base inteira)

pg_dump dbname -h localhost -U postgres > backup.sql                                                                 (Dump de uma base)

pg_dump -U postgres --schema migracao_pessoal_camara jaguarao_estrutura > /home/usuarios/jaguarao_schema2.sql        (Dump de schema especifico)
