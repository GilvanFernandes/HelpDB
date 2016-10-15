-- Exporta um select em CSV com delimitador
SELECT DISTINCT usu_cli as usuario, 
    			count(*) as cliente 
           FROM Tabela.r_cliente 
          WHERE uf_cli LIKE '%RS%' 
       GROUP BY usu_cli 
         HAVING count(*) > 0 
       ORDER BY usu_cli 
   INTO OUTFILE '/tmp/RelFernando.csv' FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n';                 