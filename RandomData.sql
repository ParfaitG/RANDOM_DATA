--POSTGRES SQL DIALECT

DROP TABLE IF EXISTS RandomData;

CREATE TABLE RandomData (
  "KEY" INT,
  "ID" INT,
  "GROUP" VARCHAR(5),
  "NUM1" DECIMAL(10,2),
  "NUM2" DECIMAL(10,2),
  "BOOL" BOOL,
  "DATE" TIMESTAMP    
);
INSERT INTO RandomData ("KEY") VALUES (1);

WITH RECURSIVE nums AS (
    SELECT r."KEY"
    FROM RandomData r
    UNION ALL
    SELECT n."KEY" + 1 As NEXT_NUM
    FROM nums n
    WHERE n."KEY" < 20
)

INSERT INTO RandomData SELECT * FROM nums WHERE nums."KEY" > 1;

SELECT EXTRACT(EPOCH FROM NOW());

SELECT SETSEED(0.99);
SELECT FLOOR(RANDOM()*(15-1))+1 AS "ID", SUBSTRING('ABCDEFGHIJKLMNOPQRSTUVWXYZ', CAST(FLOOR(RANDOM()*(26-1))+1 AS INTEGER), 1) AS "GROUP",
       RANDOM() AS NUM1, RANDOM()*100 AS NUM2, CAST(ROUND(RANDOM()) AS INTEGER)::BOOLEAN AS "BOOL",
       TO_CHAR(TO_TIMESTAMP(RANDOM()*(EXTRACT(EPOCH FROM NOW())-1)+1), 'YYYY-MM-DD HH:MM:SS') AS "DATE"
FROM RandomData;

COPY (SELECT * FROM RandomData) TO '/path/to/output.csv' WITH CSV;