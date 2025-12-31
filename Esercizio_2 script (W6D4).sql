/* Parte 1 */

SELECT*
FROM dimproduct;

SELECT*
FROM dimproductsubcategory;

SELECT
ProductKey
, ProductSubcategoryKey
, EnglishProductName
, ListPrice
FROM dimproduct;

SELECT
ProductSubcategoryKey
, EnglishProductSubcategoryName
FROM dimproductsubcategory;

SELECT
p.ProductKey
, p.ProductSubcategoryKey
, p.EnglishProductName
, p.ListPrice
, s.ProductSubcategoryKey
FROM 
dimproduct AS p
LEFT JOIN 
dimproductsubcategory AS s
ON p.ProductSubcategoryKey = s.ProductSubcategoryKey;

/* Parte 2 */

SELECT
P.ProductKey
, P.ProductSubcategoryKey
, P.EnglishProductName
, S.EnglishProductSubcategoryName
, C.EnglishProductCategoryName
FROM dimproduct AS P 
LEFT JOIN dimproductsubcategory AS S
ON P.ProductSubcategoryKey = S.ProductSubcategoryKey
LEFT JOIN dimproductcategory AS C
ON S.ProductCategoryKey = C.ProductCategoryKey;

/* Parte 3 (metto distinct perchè mi interessa vedere SOLO i prodotti venduti indipendentemente dal n° di volte in cui sono stati venduti*/

SELECT distinct
P.ProductKey
, P.EnglishProductName
FROM dimproduct AS P
INNER JOIN factresellersales AS F
ON P.ProductKey = F.ProductKey;

/* Parte 4*/

SELECT
P.ProductKey
, P.EnglishProductName
FROM dimproduct AS P
LEFT JOIN factresellersales AS F
ON P.ProductKey = F.ProductKey
WHERE FinishedGoodsFlag = 1 AND F.ProductKey is null;

/* Parte 5*/

SELECT
P.ProductKey
, P.EnglishProductName
, F.SalesOrderNumber
, F.SalesOrderLineNumber
, F.OrderDate
FROM factresellersales AS F 
LEFT JOIN dimproduct AS P
ON F.ProductKey = P.ProductKey;

/* Parte 2.1*/

SELECT
P.ProductKey
, P.EnglishProductName
, F.SalesOrderNumber
, F.SalesOrderLineNumber
, F.OrderDate
, C.EnglishProductCategoryName
FROM factresellersales AS F 
INNER JOIN dimproduct AS P
ON F.ProductKey = P.ProductKey
LEFT JOIN dimproductsubcategory AS S
ON P.ProductSubcategoryKey = S.ProductSubcategoryKey
LEFT JOIN dimproductcategory AS C
ON S.ProductCategoryKey = C.ProductCategoryKey;

/* Parte 2.2*/

SELECT *
FROM dimreseller;

/* Parte 2.3*/

SELECT
R.ResellerName
, G.City
, T.SalesTerritoryRegion
, T.SalesTerritoryCountry
FROM dimreseller AS R
LEFT JOIN dimgeography AS G
ON R.GeographyKey = G.GeographyKey
LEFT JOIN dimsalesterritory AS T
ON G.SalesTerritoryKey = T.SalesTerritoryKey;

/* Parte 2.4
Transazioni di vendita con:
SalesOrderNumber - - factresellersales
SalesOrderLineNumber - - factresellersales
OrderDate - - factresellersales
UnitPrice- - factresellersales
Quantity - - factresellersales
TotalProductCost - - factresellersales
EnglishProductName - - dimproduct
Category
ResellerName
City - - dimgeography
StateProvinceName - - dimgeography
EnglishCountryRegionName - - dimgeography
SalesTerritoryRegion
SalesTerritoryCountry
*/

SELECT
F.SalesOrderNumber
, F.SalesOrderLineNumber
, F.OrderDate
, F.UnitPrice
, F.OrderQuantity
, F.TotalProductCost
, P.EnglishProductName
, P.EnglishDescription
, C.EnglishProductCategoryName
, R.ResellerName
, G.City
, G.StateProvinceName
, G.EnglishCountryRegionName
, T.SalesTerritoryRegion
, T.SalesTerritoryCountry
FROM factresellersales AS F
INNER JOIN dimproduct AS P
ON F.ProductKey = P.ProductKey
LEFT JOIN dimproductsubcategory AS S
ON P.ProductSubcategoryKey = S.ProductSubcategoryKey
LEFT JOIN dimproductcategory AS C
ON S.ProductCategoryKey = C.ProductCategoryKey
INNER JOIN dimreseller AS R
ON F.ResellerKey = R.ResellerKey
LEFT JOIN dimgeography AS G
ON G.GeographyKey = R.GeographyKey
LEFT JOIN dimsalesterritory AS T
ON G.SalesTerritoryKey = T.SalesTerritoryKey;


