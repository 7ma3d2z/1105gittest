---SQL 6章---

SELECT *
FROM 都市別気象観測


--■練習問題6-1
--①
SELECT SUM(降水量) AS 年間降水量, 
        AVG(最高気温) AS 年間の平均最高気温,
        AVG(最低気温) AS 年間の平均最低気温
FROM 都市別気象観測

--②
SELECT SUM(降水量) AS 年間降水量, 
        AVG(最高気温) AS 年間の平均最高気温,
        AVG(最低気温) AS 年間の平均最低気温
FROM 都市別気象観測
WHERE 都市名 = '東京'


--③
SELECT 都市名, AVG(降水量), MIN(最高気温), MAX(最低気温) 
FROM 都市別気象観測
GROUP BY 都市名

--④
SELECT 月, AVG(降水量), AVG(最高気温), AVG(最低気温)
FROM 都市別気象観測
GROUP BY 月


--⑤
SELECT 都市名,MAX(最高気温)
FROM 都市別気象観測
GROUP BY 都市名
HAVING MAX(最高気温) >= 38       --HAVINGで、GROUP BYされたものから絞り込む

--⑥
SELECT 都市名,MIN(最低気温)
FROM 都市別気象観測
GROUP BY 都市名
HAVING MIN(最低気温) <= -10       --HAVINGで、GROUP BYされたものから絞り込む


--■練習問題6-2
--①
/* COUNT(*)で、「NULLを含めたレコード数」を集計し、
　　退室の列がNULL = 今入室中という意味になるので、WHEREでIS NULLで判定
*/
SELECT COUNT(*) AS 社員数
FROM 入退室管理
WHERE 退室 IS NULL

--②
/*
　COUNT(*)でNULLを含めたレコード数を取得
　GROUP BY で社員名ごとに取得
　ORDER BY 句で、上位3名を抽出
*/
SELECT 社員名, COUNT(*) AS 入室回数
FROM 入退室管理
GROUP BY 社員名
ORDER BY 2 DESC

--③
/*
　事由区分の番号ごとに、事由名を具体的に表示。事由区分ごとに分けて表示
*/
SELECT CASE 事由区分 WHEN '1' THEN 'メンテナンス'
                    WHEN '2' THEN 'リリース作業'
                    WHEN '3' THEN '障害対応'
                    WHEN '9' THEN 'その他'
        END AS 事由,
        COUNT(*) AS 入室回数
FROM 入退室管理
GROUP BY 事由区分


--④
/*
　GROUP BY で、社員名ごとに表示、さらにHAVINGで、入室回数(COUNT(*)が10以上の人)を絞り込む。
*/
SELECT 社員名, COUNT(*) AS 入室回数
FROM 入退室管理
GROUP BY 社員名
HAVING COUNT(*) > 10

--⑤
/*
　事由区分が3"障害対応"のものを、日付ごとに表示して、COUNT(*)で、障害対応にあたった人数を検索
*/
SELECT 日付, COUNT(社員名) AS 対応社員数
FROM 入退室管理
WHERE 事由区分 = '3'
GROUP BY 日付





--以下メモ--
        CREATE TABLE 家計簿 (
        日付 DATE           NOT NULL,
        費目ID INTEGER      REFERENCES 費目(ID),
        メモ VARCHAR(100)   DEFAULT '不明' NOT NULL,
        入金額 INTEGER      DEFAULT 0 CHECK(入金額 >= 0),
        出金額 INTEGER      DEFAULT 0 CHECK(出金額 >= 0)
        );


        CREATE TABLE 費目 (
            ID INTEGER,
        名前 VARCHAR(40)  UNIQUE
        );


        CREATE TABLE 費目 (
        ID   INTEGER     PRIMARY KEY,
        名前  VARCHAR(40) UNIQUE
        )


