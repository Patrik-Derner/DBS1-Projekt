--Informace o zákaznících pøehlednì
CREATE VIEW PREHLED_KLIENTU
AS
SELECT TOP (1000) Region.Nazev AS REGION,
	K.Titul AS TITUL,
	K.Jmeno AS JMENO,
	K.Prijmeni AS PRIJMENI,
	K.Email AS EMAIL,
	K.TelefonniCislo AS TELEFON,
	A.Ulice AS ULICE,
	A.CisloPopisne AS POPISNE_CISLO,
	A.Vchod AS VCHOD,
	A.PSC AS PSC,
	A.Mesto AS MESTO,
	A.Zeme AS ZEME
FROM (SELECT AdresaID, Titul, Jmeno, Prijmeni, Email, TelefonniCislo FROM Klient) AS K
	INNER JOIN (SELECT AdresaID, RegionID, Ulice, CisloPopisne, Vchod, PSC, Mesto, Zeme FROM Adresa) AS A ON A.AdresaID = K.AdresaID
	INNER JOIN Region ON Region.RegionID = A.RegionID
ORDER BY Region.Nazev