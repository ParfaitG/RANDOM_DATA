--POSTGRES SQL DIALECT

DROP TABLE IF EXISTS RandomData;

CREATE TABLE RandomData (
  "KEY" INT,
  "ID" INT,
  "GROUP" VARCHAR(5),
  "NUM1" DECIMAL(10,2),
  "NUM2" DECIMAL(10,2),
  "BOOL" BOOL,
  "DATE" TIMESTAMP WITH TIME ZONE
);

-- INITIAL ROW
INSERT INTO RandomData
VALUES (1, FLOOR(RANDOM()*(15-1))+1, 
        SUBSTRING('ABCDEFGHIJKLMNOPQRSTUVWXYZ', CAST(FLOOR(RANDOM()*(26-1))+1 AS INTEGER), 1),
        RANDOM(), 
        (RANDOM()*100), 
        CAST(ROUND(RANDOM()) AS INTEGER)::boolean,
        TO_TIMESTAMP(RANDOM()*(EXTRACT(EPOCH FROM NOW())-1)+1));
        
SELECT EXTRACT(EPOCH FROM NOW());
SELECT SETSEED(0.99);

-- RECURSIVE ROWS
WITH RECURSIVE nums AS (
    SELECT r."KEY", r."ID", r."GROUP", r."NUM1", r."NUM2", r."BOOL", r."DATE"
    FROM RandomData r
    UNION ALL
    SELECT n."KEY" + 1, (FLOOR(RANDOM()*(15-1))+1)::int AS "ID", 
                        SUBSTRING('ABCDEFGHIJKLMNOPQRSTUVWXYZ', CAST(FLOOR(RANDOM()*(26-1))+1 AS INTEGER), 1)::varchar(5) AS "GROUP",
                        RANDOM()::decimal(10,2) AS NUM1, 
                        (RANDOM()*100)::decimal(10,2) AS NUM2, 
                        CAST(ROUND(RANDOM()) AS INTEGER)::boolean AS "BOOL",
                        TO_TIMESTAMP(RANDOM()*(EXTRACT(EPOCH FROM NOW())-1)+1) AS "DATE"
    FROM nums n
    WHERE n."KEY" < 20
)

INSERT INTO RandomData SELECT * FROM nums WHERE nums."KEY" > 1;

SELECT * FROM RandomData;

COPY (SELECT * FROM RandomData) TO '/path/to/output.csv' WITH CSV;
