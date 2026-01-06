/* 1 - Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria. 
Quali considerazioni/ragionamenti è necessario che tu faccia? */

SELECT
ProductKey
, count(*)
FROM dimproduct
GROUP BY ProductKey
HAVING COUNT(*)>1;

SELECT
ProductKey
FROM dimproduct
WHERE ProductKey is null;

/* Ho verificato l’unicità di ProductKey tramite GROUP BY e l’assenza di valori NULL tramite una query WHERE ProductKey IS NULL */

/* 2 - Verificare se (SalesOrderNumber, SalesOrderLineNumber) può essere considerata una chiave primaria composta */

SELECT
SalesOrderNumber
, SalesOrderLineNumber
FROM factresellersales
WHERE SalesOrderNumber is null OR SalesOrderLineNumber is null;

SELECT
SalesOrderNumber
, SalesOrderLineNumber
, count(*)
FROM factresellersales
GROUP BY 
SalesOrderNumber
, SalesOrderLineNumber
HAVING COUNT(*) > 1;

/* Ho verificato l’assenza di valori NULL tramite la query WHERE sia per SalesOrderNumber che SalesOrderLineNumber 
infine confermato l'unicità della combo SalesOrderNumber e SalesOrderLineNumber tramite GROUP BY e COUNT(*).
Quindi la combinazione si comporta come una chiave primaria composta (NOT NULL + unicità).*/

/* 3 - Conta il numero transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020 */

SELECT
OrderDate
, count(*) AS NumTrans
FROM factresellersales
WHERE OrderDate > '2020-01-01'
GROUP BY 
OrderDate
ORDER BY
OrderDate ASC;

/* EXTRA -  Calcolare il totale delle vendite (SalesAmount) per giorno e mostrare solo i giorni in cui il totale supera una certa soglia
(qui entra in gioco HAVING) */

SELECT
OrderDate
, sum(SalesAmount) AS TotVenditeGiornaliere
FROM factresellersales
GROUP BY
OrderDate
HAVING sum(SalesAmount) > 1340 /* € 1340.5 è la media delle vendite totali, perciò seleziono solo dove il totale delle vendite è maggiore dell'avg tot*/
ORDER BY TotVenditeGiornaliere ASC;

/* 4 - Calcola il fatturato totale (FactResellerSales.SalesAmount), la quantità totale venduta
(FactResellerSales.OrderQuantity) e il prezzo medio di vendita (FactResellerSales.UnitPrice) per prodotto
(DimProduct) a partire dal 1 Gennaio 2020. 
Il result set deve esporre:
il nome del prodotto
, il fatturato totale
, la quantità totale venduta
, il prezzo medio di vendita. 
I campi in output devono essere parlanti! */


SELECT
P.EnglishProductName AS NomeProdotto
, P.ProductKey AS CodiceProdotto
, SUM(F.SalesAmount) AS FatturatoTot
, SUM(F.OrderQuantity) AS TotQtàVendute
, AVG(F.UnitPrice) AS PrezzoMedio
FROM factresellersales AS F
INNER JOIN dimproduct AS P
ON F.ProductKey = P.ProductKey
WHERE OrderDate >= '2020-01-01'
GROUP BY
P.EnglishProductName
, P.ProductKey
ORDER BY P.ProductKey;

/* 1.1 - Calcola il fatturato totale (FactResellerSales.SalesAmount) e la quantità totale venduta
(FactResellerSales.OrderQuantity) per Categoria prodotto (DimProductCategory). 
Il result set deve esporre:
il nome della categoria prodotto
, il fatturato totale
,quantità totale venduta. 
I campi in output devono essere parlanti!*/

SELECT
C.EnglishProductCategoryName AS NomeCategoriaProdotto
, SUM(F.SalesAmount) AS FatturatoTot
, SUM(F.OrderQuantity) AS TotQtàVendute
FROM factresellersales AS F
INNER JOIN dimproduct AS P
ON F.ProductKey = P.ProductKey
INNER JOIN dimproductsubcategory AS S
ON S.ProductSubcategoryKey = P.ProductSubcategoryKey
INNER JOIN dimproductcategory AS C
ON C.ProductCategoryKey = S.ProductCategoryKey 
WHERE OrderDate >= '2020-01-01'
GROUP BY
C.EnglishProductCategoryName
, C.ProductCategoryKey
ORDER BY
FatturatoTot DESC;


/* 2.1 - Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020. 
Il result set deve esporre:
 l'elenco delle città con fatturato realizzato superiore a 60K. */

  SELECT
 G.City AS NomeCittà
 , SUM(SalesAmount) AS TotFatturato
 FROM factresellersales AS F
 INNER JOIN dimreseller AS R
 ON F.ResellerKey = R.ResellerKey
 INNER JOIN dimgeography AS G
 ON G.GeographyKey = R.GeographyKey
 WHERE OrderDate >= '2020-01-01'
 GROUP BY 
 G.City
 HAVING SUM(SalesAmount) > 60000
 ORDER BY TotFatturato DESC;
 

