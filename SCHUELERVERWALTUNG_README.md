# Schülerverwaltungs-Datenbank für WP-Kurs Informatik 7. Klasse

Diese SQLite-Datenbank ermöglicht die Verwaltung von Schülerdaten, SoMi-Noten (Sonstige Mitarbeit) und Klassenarbeiten für den WP-Kurs Informatik.

## Datenbankstruktur

### Tabellen

1. **schueler**
   - `id`: Eindeutige Schüler-ID (automatisch vergeben)
   - `vorname`: Antonio
   - `nachname`: Müller
   - `klasse`: 7b
   - `geburtsalter`: 13
   - `erstellt_am`: Zeitstempel der Erstellung

2. **somi_noten** (Sonstige Mitarbeit)
   - `id`: Eindeutige Noten-ID
   - `schueler_id`: Verweis auf den Schüler
   - `datum`: Datum der Bewertung
   - `note`: Note (z.B. "1+", "2", "3-")
   - `bemerkung`: Optional Bemerkung zur Note
   - `erstellt_am`: Zeitstempel der Erstellung

3. **klassenarbeiten**
   - `id`: Eindeutige Klassenarbeits-ID
   - `schueler_id`: Verweis auf den Schüler
   - `datum`: Datum der Klassenarbeit
   - `thema`: Thema der Klassenarbeit
   - `note`: Note (z.B. "1", "2+", "3-")
   - `punkte`: Erreichte Punktzahl
   - `max_punkte`: Maximal mögliche Punktzahl
   - `bemerkung`: Optional Bemerkung
   - `erstellt_am`: Zeitstempel der Erstellung

## Installation und Einrichtung

### Voraussetzungen

SQLite3 muss auf Ihrem System installiert sein. Unter macOS ist es standardmäßig installiert.

Prüfen Sie die Installation:
```bash
sqlite3 --version
```

### Datenbank erstellen

#### Methode 1: Mit dem Initialisierungsskript (Empfohlen)

```bash
./init_datenbank.sh
```

Das Skript führt Sie durch den Prozess und fragt, ob Sie Beispieldaten einfügen möchten.

#### Methode 2: Manuell

```bash
# Datenbank und Tabellen erstellen
sqlite3 schuelerverwaltung.db < schuelerverwaltung_schema.sql

# Optional: Beispieldaten einfügen
sqlite3 schuelerverwaltung.db < beispieldaten.sql
```

## Verwendung

### Datenbank öffnen

```bash
sqlite3 schuelerverwaltung.db
```

### Nützliche SQLite-Befehle

In der SQLite-Kommandozeile:
```sql
.tables                 -- Alle Tabellen anzeigen
.schema schueler       -- Schema einer Tabelle anzeigen
.mode column           -- Spaltenweise Anzeige
.headers on            -- Spaltenüberschriften anzeigen
.quit                  -- SQLite beenden
```

### Beispiele für häufige Aufgaben

#### Neuen Schüler hinzufügen
```sql
INSERT INTO schueler (vorname, nachname, klasse, geburtsalter)
VALUES ('Maria', 'Schneider', '7a', 12);
```

#### SoMi-Note hinzufügen
```sql
INSERT INTO somi_noten (schueler_id, datum, note, bemerkung)
VALUES (1, '2025-12-16', '1-', 'Sehr gute Mitarbeit im Projekt');
```

#### Klassenarbeit hinzufügen
```sql
INSERT INTO klassenarbeiten (schueler_id, datum, thema, note, punkte, max_punkte)
VALUES (1, '2025-12-10', 'Datenbanken', '1', 47, 50);
```

#### Alle Schüler einer Klasse anzeigen
```sql
SELECT vorname, nachname, geburtsalter
FROM schueler
WHERE klasse = '7a'
ORDER BY nachname;
```

#### Alle Noten eines Schülers anzeigen
```sql
-- SoMi-Noten
SELECT datum, note, bemerkung
FROM somi_noten
WHERE schueler_id = 1
ORDER BY datum DESC;

-- Klassenarbeiten
SELECT datum, thema, note, punkte, max_punkte
FROM klassenarbeiten
WHERE schueler_id = 1
ORDER BY datum DESC;
```

#### Schüler-ID herausfinden
```sql
SELECT id, vorname, nachname, klasse
FROM schueler
WHERE nachname = 'Müller';
```

### Erweiterte Abfragen

In der Datei `abfragen.sql` finden Sie viele nützliche Abfragen:

- Notenübersichten
- Klassendurchschnitte
- Vollständige Schülerberichte
- und mehr

Führen Sie eine Abfrage aus der Datei aus:
```bash
sqlite3 schuelerverwaltung.db < abfragen.sql
```

Oder kopieren Sie einzelne Abfragen in die SQLite-Konsole.

## Daten sichern

### Backup erstellen
```bash
sqlite3 schuelerverwaltung.db ".backup schuelerverwaltung_backup.db"
```

### Datenbank exportieren (SQL-Format)
```bash
sqlite3 schuelerverwaltung.db .dump > backup.sql
```

### Aus Backup wiederherstellen
```bash
sqlite3 schuelerverwaltung.db < backup.sql
```

## Tipps

1. **Regelmäßige Backups**: Erstellen Sie regelmäßig Sicherungen Ihrer Datenbank
2. **Schüler-IDs**: Notieren Sie sich die IDs wichtiger Schüler für schnelleren Zugriff
3. **Notensystem**: Passen Sie das Notensystem (1-6, mit +/-) nach Bedarf an
4. **Datenschutz**: Achten Sie auf den Schutz personenbezogener Daten gemäß DSGVO

## Weiterführende Möglichkeiten

- Python-Skript zur Automatisierung
- Web-Interface mit Flask oder Django
- Export nach Excel/CSV
- Automatische Notenberechnungen
- Grafische Auswertungen

## Support

Bei Fragen zur Datenbank oder SQL-Abfragen können Sie die offizielle SQLite-Dokumentation konsultieren:
https://www.sqlite.org/docs.html
