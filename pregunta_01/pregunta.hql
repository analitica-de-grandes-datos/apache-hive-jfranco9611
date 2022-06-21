/* 
Pregunta
===========================================================================

Para resolver esta pregunta use el archivo `data.tsv`.

Compute la cantidad de registros por cada letra de la columna 1.
Escriba el resultado ordenado por letra. 

Apache Hive se ejecutará en modo local (sin HDFS).

Escriba el resultado a la carpeta `output` de directorio de trabajo.

        >>> Escriba su respuesta a partir de este punto <<<
*/

CREATE TABLE IF EXISTS Data_01 (
       dt1 STRING,
       dt2 DATE,
       dt3 INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
TBLPROPERTIES('skip.header.line.count'='0');
LOAD DATA LOCAL INPATH 'data.tsv' OVERWRITE INTO TABLE Data_01;

CREATE TABLE Cnt_01 AS
SELECT
    dt1, COUNT(1) AS Cant
FROM
    Data_01
GROUP BY
    dt1
ORDER BY
    dt1;

INSERT OVERWRITE LOCAL DIRECTORY './output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT * FROM Cnt_01;
