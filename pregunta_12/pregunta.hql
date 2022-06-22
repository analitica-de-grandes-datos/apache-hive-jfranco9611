/*

Pregunta
===========================================================================

Escriba una consulta que compute la cantidad de registros por letra de la 
columna 2 y clave de la columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `a` en la columna 2 y la clave `aaa` en la 
columna 3 es:

    a    aaa    5

Apache Hive se ejecutará en modo local (sin HDFS).

Escriba el resultado a la carpeta `output` de directorio de trabajo.
*/


CREATE TABLE t0 (
    c1 STRING,
    c2 ARRAY<CHAR(1)>,
    c3 MAP<STRING, INT> )
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
COLLECTION ITEMS TERMINATED BY ','
MAP KEYS TERMINATED BY '#' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INPATH 'data.tsv' INTO TABLE t0;

CREATE TABLE Rsm_1 AS
SELECT
    pt1, key, value
FROM
    (SELECT pt1, c3
     FROM t0
     LATERAL VIEW EXPLODE(c2) t0 AS pt1) Rsm_2
LATERAL VIEW EXPLODE(c3) Rsm_2;

INSERT OVERWRITE LOCAL DIRECTORY './output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT
    pt1, key, COUNT(1)
FROM
    Rsm_1
GROUP BY pt1, key;