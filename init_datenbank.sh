#!/bin/bash

# Initialisierungsskript für die Schülerverwaltungs-Datenbank
# Dieses Skript erstellt die SQLite-Datenbank und füllt sie mit Beispieldaten

DB_NAME="schuelerverwaltung.db"

echo "Erstelle Datenbank: $DB_NAME"

# Prüfen, ob die Datenbank bereits existiert
if [ -f "$DB_NAME" ]; then
    read -p "Die Datenbank existiert bereits. Möchten Sie sie überschreiben? (j/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Jj]$ ]]; then
        rm "$DB_NAME"
        echo "Alte Datenbank gelöscht."
    else
        echo "Abbruch. Datenbank wurde nicht überschrieben."
        exit 1
    fi
fi

# Schema erstellen
echo "Erstelle Tabellen..."
sqlite3 "$DB_NAME" < schuelerverwaltung_schema.sql

if [ $? -eq 0 ]; then
    echo "✓ Tabellen erfolgreich erstellt"
else
    echo "✗ Fehler beim Erstellen der Tabellen"
    exit 1
fi

# Beispieldaten einfügen (optional)
read -p "Möchten Sie Beispieldaten einfügen? (j/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Jj]$ ]]; then
    echo "Füge Beispieldaten ein..."
    sqlite3 "$DB_NAME" < beispieldaten.sql

    if [ $? -eq 0 ]; then
        echo "✓ Beispieldaten erfolgreich eingefügt"
    else
        echo "✗ Fehler beim Einfügen der Beispieldaten"
        exit 1
    fi
fi

echo ""
echo "======================================"
echo "Datenbank erfolgreich erstellt!"
echo "======================================"
echo "Datenbankname: $DB_NAME"
echo ""
echo "So können Sie die Datenbank verwenden:"
echo "  sqlite3 $DB_NAME"
echo ""
echo "Beispielabfragen finden Sie in: abfragen.sql"
