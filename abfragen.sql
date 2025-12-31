-- Nützliche SQL-Abfragen für die Schülerverwaltung

-- 1. Alle Schüler anzeigen
SELECT * FROM schueler ORDER BY klasse, nachname, vorname;

-- 2. Schüler einer bestimmten Klasse anzeigen
SELECT * FROM schueler WHERE klasse = '7a' ORDER BY nachname, vorname;

-- 3. Alle Noten eines Schülers anzeigen (SoMi + Klassenarbeiten)
SELECT
    s.vorname,
    s.nachname,
    'SoMi' as typ,
    sn.datum,
    '' as thema,
    sn.note,
    sn.bemerkung
FROM schueler s
JOIN somi_noten sn ON s.id = sn.schueler_id
WHERE s.id = 1
UNION ALL
SELECT
    s.vorname,
    s.nachname,
    'Klassenarbeit' as typ,
    ka.datum,
    ka.thema,
    ka.note,
    ka.bemerkung
FROM schueler s
JOIN klassenarbeiten ka ON s.id = ka.schueler_id
WHERE s.id = 1
ORDER BY datum DESC;

-- 4. Notendurchschnitt für Klassenarbeiten pro Schüler
-- (Umrechnung der Noten in Zahlen für Durchschnitt)
SELECT
    s.vorname,
    s.nachname,
    s.klasse,
    COUNT(ka.id) as anzahl_klassenarbeiten,
    GROUP_CONCAT(ka.note, ', ') as noten
FROM schueler s
LEFT JOIN klassenarbeiten ka ON s.id = ka.schueler_id
GROUP BY s.id
ORDER BY s.klasse, s.nachname;

-- 5. Alle Klassenarbeiten zu einem bestimmten Thema
SELECT
    s.vorname,
    s.nachname,
    s.klasse,
    ka.datum,
    ka.note,
    ka.punkte,
    ka.max_punkte,
    ROUND((CAST(ka.punkte AS REAL) / ka.max_punkte) * 100, 1) as prozent
FROM schueler s
JOIN klassenarbeiten ka ON s.id = ka.schueler_id
WHERE ka.thema = 'Programmierung Grundlagen'
ORDER BY ka.punkte DESC;

-- 6. Aktuelle SoMi-Noten (jeweils die neueste pro Schüler)
SELECT
    s.vorname,
    s.nachname,
    s.klasse,
    sn.datum,
    sn.note,
    sn.bemerkung
FROM schueler s
JOIN somi_noten sn ON s.id = sn.schueler_id
WHERE sn.id IN (
    SELECT id
    FROM somi_noten sn2
    WHERE sn2.schueler_id = s.id
    ORDER BY datum DESC
    LIMIT 1
)
ORDER BY s.klasse, s.nachname;

-- 7. Übersicht: Schüler mit allen Klassenarbeiten
SELECT
    s.vorname,
    s.nachname,
    s.klasse,
    ka.thema,
    ka.datum,
    ka.note,
    ka.punkte || '/' || ka.max_punkte as punktzahl
FROM schueler s
LEFT JOIN klassenarbeiten ka ON s.id = ka.schueler_id
ORDER BY s.klasse, s.nachname, ka.datum;

-- 8. Klassendurchschnitt für eine Klassenarbeit
SELECT
    ka.thema,
    COUNT(ka.id) as teilnehmer,
    ROUND(AVG(CAST(ka.punkte AS REAL)), 2) as durchschnitt_punkte,
    MAX(ka.punkte) as beste_punktzahl,
    MIN(ka.punkte) as schlechteste_punktzahl,
    ka.max_punkte
FROM klassenarbeiten ka
WHERE ka.thema = 'Programmierung Grundlagen'
GROUP BY ka.thema;

-- 9. Schüler mit den meisten SoMi-Einträgen
SELECT
    s.vorname,
    s.nachname,
    COUNT(sn.id) as anzahl_somi_noten
FROM schueler s
LEFT JOIN somi_noten sn ON s.id = sn.schueler_id
GROUP BY s.id
ORDER BY anzahl_somi_noten DESC;

-- 10. Vollständige Übersicht eines Schülers
SELECT
    'Stammdaten' as kategorie,
    'Vorname: ' || s.vorname || ', Nachname: ' || s.nachname ||
    ', Klasse: ' || s.klasse || ', Alter: ' || s.geburtsalter as info
FROM schueler s
WHERE s.id = 1;
