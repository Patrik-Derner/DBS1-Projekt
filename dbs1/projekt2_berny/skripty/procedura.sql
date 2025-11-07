CREATE PROCEDURE REGISTRACE
	--Region
	@Nazev varchar(30),
	--Adresa
	@Ulice varchar(50),
	@CisloPopisne int,
	@PSC varchar(15),
	@Mesto varchar(60),
	@Zeme varchar(50),
	--Klient
	@Jmeno varchar(100),
	@Prijmeni varchar(100),
	@Email varchar(50),
	@Prostredky int
AS
--Region
INSERT INTO Region (Nazev)
SELECT @Nazev
WHERE NOT EXISTS (
    SELECT 1
    FROM Region
    WHERE Nazev = @Nazev
)
--Adresa
INSERT INTO Adresa (RegionID, Ulice, CisloPopisne, PSC, Mesto, Zeme)
VALUES ((SELECT RegionID
		FROM Region
		WHERE Nazev = @Nazev),
	@Ulice,
	@CisloPopisne,
	@PSC,
	@Mesto,
	@Zeme
)
--Klient
INSERT INTO Klient (AdresaID, Jmeno, Prijmeni, Email, Prostredky) 
VALUES ((SELECT AdresaID
		FROM Adresa
		WHERE RegionID = (SELECT RegionID
						FROM REGION
						WHERE Nazev = @Nazev)
		AND Ulice = @Ulice
		AND CisloPopisne = @CisloPopisne
		AND PSC = @PSC
		AND Mesto = @Mesto
		AND Zeme = @Zeme),
	@Jmeno,
	@Prijmeni,
	@Email,
	@Prostredky
)

EXEC REGISTRACE
	--Region
	@Nazev = 'Atlantida',
	--Adresa
	@Ulice = 'Podmoøská',
	@CisloPopisne = '8',
	@PSC = 'neznámé',
	@Mesto = 'Modrý korálový útes',
	@Zeme = 'Tichomoøí',
	--Klient
	@Jmeno = 'František',
	@Prijmeni = 'Poseidón',
	@Email = 'frantisek.poseidon@underwater.at',
	@Prostredky = 4000