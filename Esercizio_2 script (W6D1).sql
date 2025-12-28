SELECT*
FROM dimproduct;


/* 3. */ 
SELECT
ProductKey 
, ProductAlternateKey AS "Seriale"
, EnglishProductName AS "Name"
, Color
, StandardCost
, FinishedGoodsFlag AS "FinishedProduct"
FROM dimproduct;

/* 4. */ 

SELECT
ProductKey 
, ProductAlternateKey AS "Seriale"
, EnglishProductName AS "Name"
, Color
, StandardCost
, FinishedGoodsFlag AS "FinishedProduct"
FROM dimproduct
WHERE FinishedGoodsFlag = 1;

/* 5. + Markup */ 

SELECT
ProductKey 
, ProductAlternateKey AS "Seriale"
, ModelName AS "Model"
, EnglishProductName AS "Name"
, StandardCost
, ListPrice
, ListPrice - StandardCost AS "Markup"
FROM dimproduct
WHERE ProductAlternateKey like "FR%" or "BK%";

/* elenco prodotti finiti con prezzo compreso fra 1000 e 2000 */ 

SELECT
ProductKey 
, ProductAlternateKey AS "Seriale"
, EnglishProductName AS "Name"
, Color
, StandardCost
, FinishedGoodsFlag AS "FinishedProduct"
FROM dimproduct
WHERE FinishedGoodsFlag = 1 and ListPrice BETWEEN 1000 AND 2000;


/* elenco soli agenti aziendali */

SELECT
EmployeeKey
, EmployeeNationalIDAlternateKey
, FirstName
, LastName
, Title
, SalesPersonFlag
from dimemployee
WHERE SalesPersonFlag = 1;


SELECT
SalesOrderNumber
, OrderDate
, ProductKey
, SalesAmount - TotalProductCost AS "Profit"
FROM factresellersales
WHERE SalesAmount - TotalProductCost is not null AND ProductKey IN (597, 598, 477, 214) AND OrderDate > "2019-12-31"
ORDER BY OrderDate ASC;