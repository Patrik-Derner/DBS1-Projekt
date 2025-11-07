CREATE VIEW CELKOVE_TRZBY
AS
SELECT TOP (1000) Region.Nazev AS REGION,
	CONVERT(varchar(MAX), SUM(O.Cena)) + ' ' + O.Mena AS TRZBA
FROM (SELECT FakturacniAdresa, Cena, Mena FROM Objednavka WHERE DatumOdeslani IS NOT NULL AND DatumDoruceni IS NOT NULL) AS O
	INNER JOIN (SELECT AdresaID, RegionID FROM Adresa) AS A ON A.AdresaID = O.FakturacniAdresa
	RIGHT JOIN Region ON Region.RegionID = A.RegionID
GROUP BY Region.Nazev, O.Mena
ORDER BY Region.Nazev