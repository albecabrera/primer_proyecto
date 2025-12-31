-- Datenbank-Schema für WP-Kurs Informatik 7. Klasse
-- SQLite Datenbank

-- Tabelle für Schülerdaten
CREATE TABLE IF NOT EXISTS schueler (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    vorname TEXT NOT NULL,
    nachname TEXT NOT NULL,
    klasse TEXT NOT NULL,
    geburtsalter INTEGER,
    erstellt_am TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabelle für SoMi-Noten (Sonstige Mitarbeit)
CREATE TABLE IF NOT EXISTS somi_noten (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    schueler_id INTEGER NOT NULL,
    datum DATE NOT NULL,
    note TEXT NOT NULL,
    bemerkung TEXT,
    erstellt_am TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (schueler_id) REFERENCES schueler(id) ON DELETE CASCADE
);

-- Tabelle für Klassenarbeiten
CREATE TABLE IF NOT EXISTS klassenarbeiten (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    schueler_id INTEGER NOT NULL,
    datum DATE NOT NULL,
    thema TEXT NOT NULL,
    note TEXT NOT NULL,
    punkte INTEGER,
    max_punkte INTEGER,
    bemerkung TEXT,
    erstellt_am TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (schueler_id) REFERENCES schueler(id) ON DELETE CASCADE
);

-- Index für bessere Performance bei Abfragen
CREATE INDEX IF NOT EXISTS idx_schueler_klasse ON schueler(klasse);
CREATE INDEX IF NOT EXISTS idx_somi_schueler ON somi_noten(schueler_id);
CREATE INDEX IF NOT EXISTS idx_klassenarbeiten_schueler ON klassenarbeiten(schueler_id);
