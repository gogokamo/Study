CREATE TABLE 부서별판매계획
(
    상품 NVARCHAR2(20),
    계획연월 NCHAR(6),
    판매부서 NUMBER,
    계획수량 NUMBER
)

CREATE TABLE 채널별판매실적
(
    상품 NVARCHAR2(20),
    판매연월 NCHAR(6),
    판매채널 NUMBER,
    판매수량 NUMBER
)
INSERT INTO 부서별판매계획 VALUES ('Macbook','201501',10,300);
INSERT INTO 부서별판매계획 VALUES ('Macbook','201502',10,400);
INSERT INTO 부서별판매계획 VALUES ('Macbook','201503',10,500);
INSERT INTO 부서별판매계획 VALUES ('Macbook','201504',10,500);
INSERT INTO 부서별판매계획 VALUES ('Macbook','201505',10,200);
INSERT INTO 부서별판매계획 VALUES ('LG-Gram','201503',20,100);
INSERT INTO 부서별판매계획 VALUES ('LG-Gram','201504',10,200);
INSERT INTO 부서별판매계획 VALUES ('LG-Gram','201505',10,300);
INSERT INTO 부서별판매계획 VALUES ('LG-Gram','201506',10,300);
INSERT INTO 부서별판매계획 VALUES ('LG-Gram','201507',10,100);

INSERT INTO 채널별판매실적 VALUES ('Macbook','201502',10,327);
INSERT INTO 채널별판매실적 VALUES ('Macbook','201503',10,343);
INSERT INTO 채널별판매실적 VALUES ('Macbook','201504',10,135);
INSERT INTO 채널별판매실적 VALUES ('Macbook','201505',10,234);
INSERT INTO 채널별판매실적 VALUES ('Macbook','201507',10,123);
INSERT INTO 채널별판매실적 VALUES ('Macbook','201504',20,426);
INSERT INTO 채널별판매실적 VALUES ('LG-Gram','201503',20,626);
INSERT INTO 채널별판매실적 VALUES ('LG-Gram','201507',20,130);

SELECT * FROM 부서별판매계획;
SELECT * FROM 채널별판매실적;



SELECT NVL(a.상품, b.상품)         상품,
       NVL(a.계획연월, b.판매연월) 연월,
       SUM(계획수량)               계획,
       SUM(판매수량)               판매
  FROM 부서별판매계획 a FULL OUTER JOIN 채널별판매실적 b
       ON  a.상품 = b.상품
       AND a.계획연월 = b.판매연월
  GROUP BY NVL(a.상품, b.상품)   , NVL(a.계획연월, b.판매연월)
  ORDER BY NVL(a.상품, b.상품)   , NVL(a.계획연월, b.판매연월);
  
  

SELECT NVL(a.상품, b.상품) 상품,
       NVL(a.연월, b.연월) 연월,
       SUM(계획) 계획,
       SUM(판매) 판매
  FROM (SELECT 상품, 계획연월 연월, SUM(계획수량) 계획
          FROM 부서별판매계획 GROUP BY 상품, 계획연월) a
       FULL OUTER JOIN
       (SELECT 상품, 판매연월 연월, SUM(판매수량) 판매
          FROM 채널별판매실적 GROUP BY 상품, 판매연월) b
       ON a.상품 = b.상품
      AND a.연월 = b.연월
 GROUP BY NVL(a.상품, b.상품), NVL(a.연월, b.연월)
 ORDER BY NVL(a.상품, b.상품), NVL(a.연월, b.연월);
 
 

SELECT 상품, 연월, SUM(계획) 계획, SUM(판매) 판매
  FROM (SELECT 상품, 계획연월 연월, SUM(계획수량) 계획, NULL 판매
          FROM 부서별판매계획 GROUP BY 상품, 계획연월
         UNION ALL
        SELECT 상품, 판매연월, NULL, SUM(판매수량)
          FROM 채널별판매실적 GROUP BY 상품, 판매연월)
 GROUP BY 상품, 연월
 ORDER BY 상품, 연월;
       
