--LEGTÖBB GÓLT RUGÓ JÁTÉKOSOK VALAMINT AZOKNAK EGYESÜLETE
SELECT TOP 5 j.nev as 'Név', j.csapat as 'Csapat', sum(g.golok_szama) as 'Gólok'
FROM golok g join jatekosok j on g.jatekos=j.nev
GROUP by j.nev, j.csapat
ORDER BY sum(g.golok_szama) desc 

--A GÓLOK SZÁMA EGYESÜLETENKÉNT AZON BELÜL PEDIG JÁTÉKOSONKÉNT, ÖSSZESÍTETT ILLETVE EGYESÜLETI SZINTEN
SELECT CASE WHEN j.nev is null THEN 'Összesített:' ELSE j.nev END ,
    CASE WHEN j.csapat is null THEN '' ELSE j.csapat END AS 'Csapat',
    IIF(SUM(g.golok_szama) IS NULL, 0, SUM(g.golok_szama)) AS 'Gólok'
FROM jatekosok j LEFT JOIN golok g ON g.jatekos = j.nev
GROUP BY ROLLUP (j.csapat,j.nev)
ORDER BY j.csapat, j.nev

--A JÁTÉKOSOK ÉRTÉKÉNEK FIKTÍV PONTOZÁSON ALAPULÓ KISZÁMÍTÁSA
SELECT j.nev AS 'Név',
    (SUM(g.golok_szama) * 2) - (j.piros_lap * 0.2) - (j.sarga_lap * 0.1) + (p.pont * 0.1) AS 'Játékos értéke'
FROM jatekosok j 
JOIN pontszamok p ON j.csapat = p.csapat
JOIN golok g ON j.nev = g.jatekos
GROUP BY j.nev, j.piros_lap, j.sarga_lap, p.pont
ORDER BY 'Játékos értéke' DESC

--A POZÍCIÓKHOZ TARTOZÓ ÉLETKOROKRA VONATKOZÓ ADATPROFILOZÁS
SELECT pozicio as 'Pozíció',
       COUNT(*) as 'Játékosok száma',
       MIN(eletkor) as 'Legfiatalabb játékos',
       MAX(eletkor) as 'Legidősebb játékos',
       AVG(eletkor) as 'Átlagéletkor'
FROM jatekosok
GROUP BY pozicio

--KISZÁMOLJA A CSAPATOK GYŐZELMI ARÁNYÁT, AMIKOR A GYŐZTES 3 PONTOT KAP A VESZTES PEDIG EGYET SEM, A KAPOTT PONTOK, ILLETVE JÁTSZOTT MÉRKŐZÉSEK ALAPJÁN
SELECT csapat as 'Csapat', pont AS 'Pontok', merkozesek_szama as 'Mérkőzések(db)', 
ROUND(CAST(pont as decimal(10,2)) / 3 / CAST(merkozesek_szama as decimal(10,2)),2) AS 'Győzelmi arány'
FROM pontszamok
ORDER BY CAST (pont as decimal(10,2)) / CAST(merkozesek_szama as decimal(10,2)) DESC