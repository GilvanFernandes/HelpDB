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

-- Autocompletar com tecla tab
UPDATE pg_proc SET procost = 10 WHERE proname ~ 'is_visible';

--Mostra a estrutura da funcao/trigger
select * from pg_proc where proname = 'nome_da_funcao_trigger';                                                       

--Renomerar database, para renomear entrar em alguma outra base que não seja que vai ser renomeada
alter database base_atual rename to nome_que_deseja_que_tenha;                                        

--Colocar em array
select array_to_string(array_accum( distinct campo), ',')  from tabelas

--Conta numero dentro do array
array_length(array_accum(distinct fpa_passagens.cod_fpapassagens), 1)  as total,

--Soma dentro do array
SELECT SUM(t) FROM UNNEST(ARRAY[1,2,3,4,5,6,7,8,9]) t;

--Separa uma coluna com delimitador, mesma coisa que explode do php
select split_part(estru, '.', 1) AS col1, split_part(estru,'.',2), estru,local from migracao.local_trabalho;         

--Criar sequencial
create temporary sequence oi; create temp table local as select nextval('oi'),local from migracao.local_trabalho; 

--Dump compactado
pg_dump -Fc -Z9 -U postgres base > /tmp/arquivo_base.pgbkp                                                           

--Restore compactado
pg_restore -U postgres -Fc -v -d base /tmp/arquivo_base.pgbkp

-- Verificar tamanho da base
select pg_size_pretty(pg_database_size('base_que_sera_consultada'));      OU \l+

-- Escape de string
select 'guns n\' roses';


-- Cria uma coluna com informação fixa com múltiplo dados 
select 'teste', unnest(ARRAY[1,2,3,4]);

--Exemplo:
-- ?column? | unnest 
------------+--------
-- teste    |      1
-- teste    |      2
-- teste    |      3
-- teste    |      4



-- Criacao de funcao para aplicar a trigger
CREATE OR REPLACE FUNCTION update_emp_view() RETURNS TRIGGER AS $$
    BEGIN
        --
        -- Executar a operação desejada em emp, e criar uma linha em emp_audit
        -- para refletir a alteração feita para emp.
        --
        IF (TG_OP = 'DELETE') THEN
            DELETE FROM emp WHERE empname = OLD.empname;
            IF NOT FOUND THEN RETURN NULL; END IF;

            OLD.last_updated = now();
            INSERT INTO emp_audit VALUES('D', user, OLD.*);
            RETURN OLD;
        ELSIF (TG_OP = 'UPDATE') THEN
            UPDATE emp SET salary = NEW.salary WHERE empname = OLD.empname;
            IF NOT FOUND THEN RETURN NULL; END IF;

            NEW.last_updated = now();
            INSERT INTO emp_audit VALUES('U', user, NEW.*);
            RETURN NEW;
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO emp VALUES(NEW.empname, NEW.salary);

            NEW.last_updated = now();
            INSERT INTO emp_audit VALUES('I', user, NEW.*);
            RETURN NEW;
        END IF;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER emp_audit 
INSTEAD OF INSERT OR UPDATE OR DELETE ON emp_view
    FOR EACH ROW EXECUTE PROCEDURE update_emp_view();


-- Lista a tabela seus campos e tipo de dados
    SELECT c.relname,
           a.attname AS "coluna",
           pg_catalog.format_type(a.atttypid, a.atttypmod) AS "tipo_de_dados"
      FROM pg_catalog.pg_attribute a
INNER JOIN pg_stat_user_tables c ON a.attrelid = c.relid
     WHERE a.attnum > 0
       AND NOT a.attisdropped
  ORDER BY c.relname,
           a.attname