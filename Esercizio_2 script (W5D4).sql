CREATE database Esercizio_2;

CREATE TABLE PRODOTTO (
ID_Prodotto INT
, Nome_Prodotto varchar(25)
, Prezzo varchar(25)
, ID_Categoria INT
);

CREATE TABLE CATEGORIA (
ID_Categoria INT
, Nome_Categoria varchar(25)
);

INSERT INTO PRODOTTO values
(1, 'Mele', '1,50 €', 10)
,(2, 'Zucchine', '3,50 €', 20)
,(3, 'Banane', '2,00 €', 10)
,(4, 'Pasta', '1 €', null)
,(5, 'Angurie', '2,50 €', 10)
,(6, 'Marmellate', '5,00 €', 30);

INSERT INTO CATEGORIA values
(10, 'Frutta')
,(20, 'Verdura')
,(30, 'Confetture');