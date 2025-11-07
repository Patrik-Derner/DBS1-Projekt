CREATE VIEW AKTUALNE_OBJEDNANE_ZBOZI
AS
SELECT TOP (1000) K.Jmeno + ' ' + K.Prijmeni AS ZAKAZNIK,
	R.Nazev AS REGION,
	Z1.Nazev AS OBJEDNANE_ZBOZI,
	RO.Mnozstvi AS OBJEDNANE_ZBOZI_KS,
	O.ObjednavkaID AS ID_OBJEDNAVKY,
	ISNULL(STRING_AGG(A2.Zeme, ', '), 'není na skladì') AS ZBOZI_NA_SKLADE,
	ISNULL(STRING_AGG(Z2.Mnozstvi, ', '), '0') AS DOSTUPNY_POCET_KS
FROM (SELECT ObjednavkaID, KlientID FROM Objednavka WHERE DatumOdeslani IS NULL) AS O
	INNER JOIN (SELECT KlientID, AdresaID, Jmeno, Prijmeni FROM KLIENT) AS K ON K.KlientID = O.KlientID
	INNER JOIN (SELECT ObjednavkaID, ZboziID, Mnozstvi FROM RadekObjednavky) AS RO ON RO.ObjednavkaID = O.ObjednavkaID
	INNER JOIN (SELECT ZboziID, SkladID, Nazev FROM Zbozi) AS Z1 ON Z1.ZboziID = RO.ZboziID
	INNER JOIN (SELECT SkladID, Nazev, Mnozstvi FROM Zbozi WHERE Mnozstvi != '0') AS Z2 ON Z2.Nazev = Z1.Nazev

	INNER JOIN (SELECT AdresaID, RegionID FROM Adresa) AS A1 ON A1.AdresaID = K.AdresaID
	INNER JOIN (SELECT RegionID, Nazev FROM Region ) AS R ON R.RegionID = A1.RegionID

	INNER JOIN (SELECT SkladID, AdresaID FROM Sklad) AS S ON S.SkladID = Z2.SkladID
	INNER JOIN (SELECT AdresaID, Zeme FROM Adresa) AS A2 ON A2.AdresaID = S.AdresaID
GROUP BY K.Jmeno + ' ' + K.Prijmeni, R.Nazev, Z1.Nazev, RO.Mnozstvi, O.ObjednavkaID
ORDER BY ID_OBJEDNAVKY