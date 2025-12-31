-- Beispieldaten für die Schülerverwaltung

-- Schüler hinzufügen
INSERT INTO schueler (vorname, nachname, klasse, geburtsalter) VALUES
('Anna', 'Müller', '7a', 12),
('Max', 'Schmidt', '7a', 13),
('Lisa', 'Weber', '7b', 12),
('Tom', 'Becker', '7a', 13),
('Sarah', 'Fischer', '7b', 12),
('Leon', 'Wagner', '7a', 13),
('Emma', 'Hoffmann', '7b', 12),
('Noah', 'Klein', '7a', 12);

-- SoMi-Noten hinzufügen (Sonstige Mitarbeit)
INSERT INTO somi_noten (schueler_id, datum, note, bemerkung) VALUES
(1, '2025-09-15', '1-', 'Sehr gute mündliche Beteiligung'),
(1, '2025-10-20', '2+', 'Gute Hausaufgaben'),
(2, '2025-09-15', '3', 'Durchschnittliche Mitarbeit'),
(2, '2025-10-20', '2', 'Verbesserung erkennbar'),
(3, '2025-09-15', '1', 'Ausgezeichnete Mitarbeit'),
(4, '2025-09-15', '2-', 'Gute Leistung'),
(5, '2025-10-20', '1-', 'Sehr gut vorbereitet'),
(6, '2025-09-15', '3+', 'Mehr Beteiligung erwünscht');

-- Klassenarbeiten hinzufügen
INSERT INTO klassenarbeiten (schueler_id, datum, thema, note, punkte, max_punkte, bemerkung) VALUES
(1, '2025-10-05', 'Programmierung Grundlagen', '2+', 42, 50, 'Gute Leistung'),
(2, '2025-10-05', 'Programmierung Grundlagen', '3', 32, 50, 'Befriedigend'),
(3, '2025-10-05', 'Programmierung Grundlagen', '1', 48, 50, 'Sehr gut'),
(4, '2025-10-05', 'Programmierung Grundlagen', '2', 38, 50, 'Gut'),
(5, '2025-10-05', 'Programmierung Grundlagen', '1-', 45, 50, 'Sehr gute Leistung'),
(6, '2025-10-05', 'Programmierung Grundlagen', '3+', 34, 50, 'Noch Verbesserungspotenzial'),
(7, '2025-10-05', 'Programmierung Grundlagen', '2-', 40, 50, 'Gute Arbeit'),
(8, '2025-10-05', 'Programmierung Grundlagen', '2', 37, 50, 'Solide Leistung');
