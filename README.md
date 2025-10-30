# Programmierung WiSe 25/26 — Übungsblatt {NR}
Abgabe bis: Donnerstag, den {TT.MM.JJJJ}, um 14 Uhr

## Team und Zuordnung
- Partner*in 1: Abel Malzew, Matr.-Nr.: 447302
- Partner*in 2: Mykhailo Volkov, Matr.-Nr.: 483217
- Tutorium: 16

## Aufgabenübersicht und Punkte

| Aufgabe | Thema                         | Punkte |
|--------:|-------------------------------|-------:|
| 01      | {Thema}                       | {..}   |
| 02      | {Thema}                       | {..}   |

### Aufgaben

#### Aufgabe {NR} — {Name}
- a) Werte der 10‑Bit‑Bitfolgen im Zweierkomplement → [docs/aufgabe07.md](docs/aufgabe07.md)
- b) Java-Ausdrücke begründen (true) → [docs/aufgabe07.md](docs/aufgabe07.md)
- Code:
  - [src/java/de/rwth/aufgabe07/](src/java/aufgabe07/)
  - [tests/](tests/)
  - Haskell: [src/haskell/aufgabe03/](src/haskell/aufgabe03/)
  - Prolog: [src/prolog/aufgabe03/](src/prolog/aufgabe03/)

## Repository-Struktur
```
docs/                  # Theorie-Antworten, Begründungen, ggf. Beweise (eine Datei je Aufgabe)
src/{Sprache}/         # Lösungen (Ordner je Aufgabe) Falls es OOP ist, dann die Pakete für Aufgaben angeben
tests/                 # Testfälle, Beispieldaten, QuickChecks, Property-Tests
scripts/               # Skript-Dateien, um Tests mit CLI durchzuführen
```

Beispiel for Java `src/`: `src/java/prograNN/blattNN/aufgabe01` (wichtig für Tests)

## Konventionen
- Pro Aufgabe:
  - Theorie: docs/aufgabe{NN}.md
  - Code: src/{sprache}/aufgabe{NN}/…
- Commit-Nachrichten exakt (feat, fix, docs, refactor, test).
- Nutzt Branches und Pull Requests für Reviews (Opt.).

## Ausführen und Testen

### Java (standalone)

Dieser Repo verwendet **JUnit 6** mit dem **JUnit Platform Console Launcher** – keine zusätzlichen Build-Tools nötig.

- Falls JUnit Console Launcher nicht installiert ist, lade es zu `.tools/` (sollte beim `git clone` autoatisch erfolgen):


```bash
mkdir -p .tools
curl -sSL -o .tools/junit-platform-console-standalone-6.0.0.jar \
  "https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/6.0.0/junit-platform-console-standalone-6.0.0.jar"
```

```powershell
$v = "6.0.0"
New-Item -ItemType Directory -Force .tools | Out-Null
Invoke-WebRequest -Uri "https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/$v/junit-platform-console-standalone-$v.jar" `
  -OutFile ".\ .tools\junit-platform-console-standalone-$v.jar"

```

Tests bei `tests/java/progra25/blattNN/aufgabeNN/AppTest.java` ablegen.

Tests lokal ausführen:
1) Einmalig Skript ausführbar machen:
   ```
   chmod +x scripts/test_java.sh
   ```
2) Tests starten (wählbar):
   ```
   # Alle Tests
   ./scripts/test_java.sh
    # Klasse
    ./scripts/test_java.sh --select-class progra25.blattNN.AppTest
    # Paket
    ./scripts/test_java.sh --select-package progra25.blattNN
    # Muster
    ./scripts/test_java.sh --include-classname '.*Calculator.*'
   ```

Runner script: [scripts/test_java.sh](../scripts/test_java.sh)  
- Kompiliert alles unter `src/java/**` und `tests/java/**`

Mehr Details: siehe [junit.org](https://junit.org/).

### Haskell 

{...}

### Prolog

{...}

## Voraussetzungen

### Java
- Java 17+ installiert (java und javac auf dem PATH)
- curl (zum einmaligen Download des JUnits. falls Hooks schiff laufen)

### Haskell
- GHC (`ghc --version`)

### Prolog
- SWI‑Prolog (`swipl --version`) — z. B. `apt install swi-prolog-nox` auf Ubuntu

## Arbeitsweise (Empfohlen)
- Branches:
  - `aufgabe/NN-kurztitel` (z. B. `aufgabe/03-sasp-semantik`)
- Pull Requests:
  - Eine PR pro Aufgabe, verlinkt das zugehörige Issue.
- Code-Style:
  - Java: Formatierung via IDE/Spotless
  - Haskell: `fourmolu`/`ormolu`
  - Prolog: konsistenter Stil, Prädikats-Dokumentation

## Git-Tutorial für Teamarbeit

### Erste Schritte
```bash
# Repository klonen
git clone {...}
cd {...}

# Aktuellen Status prüfen
git status
```

### Effektiver Workflow
1. **Neuen Branch erstellen für jede Aufgabe**:
   ```bash
   git checkout -b aufgabe/{NR}-{kurztitel}
   ```

2. **Regelmäßig committen mit aussagekräftigen Nachrichten**:
   ```bash
   git add src/java/progra25/blattXX/aufgabeYY/
   git commit -m "feat: Implementiere Methode calculate() für Aufgabe XX.Y"
   ```

3. **Branch pushen**:
   ```bash
   git push -u origin aufgabe/{NR}-{kurztitel}
   ```

4. **Pull Request erstellen** auf GitHub:
   - Gehe zu: https://github.com/username/repository/pulls
   - Klicke "New pull request"
   - Wähle deinen Branch und beschreibe die Änderungen

5. **Code Review durch Partner*in**:
   - Diskutiert Änderungen in den Kommentaren
   - Nehmt Anpassungen vor, wenn nötig
   - Merged erst nach beidseitiger Zustimmung

6. **Nach dem Merge, lokales Repository aktualisieren**:
   ```bash
   git checkout main
   git pull
   ```

### Häufige Git-Befehle
- `git log --oneline`: Zeigt kompakte Commit-Historie
- `git diff`: Zeigt Änderungen seit letztem Commit
- `git stash`: Temporäres Speichern von Änderungen
- `git pull --rebase`: Aktuelle Änderungen holen und eigene darauf anwenden

### Konflikte lösen
1. Bei Merge-Konflikten zeigt Git die betroffenen Dateien
2. Öffne die Dateien und suche nach Markierungen wie:
   ```
   <<<<<<< HEAD
   Deine Änderungen
   =======
   Änderungen aus dem anderen Branch
   >>>>>>> branch-name
   ```
3. Bearbeite den Text, um beide Änderungen zu integrieren
4. Füge die gelösten Dateien hinzu und schließe den Merge ab:
   ```bash
   git add <konfliktdatei>
   git commit
   ```

---

<details>
<summary>Beispiel: Strukturiertes Ausschreiben einer Theorieaufgabe (Vorlage zum Kopieren)</summary>

```md
# Aufgabe 03 — Syntax und Semantik

## a) Gültigkeit und Semantik
Gegeben ist die Grammatik G2 = ( {A, B, S2}, {., :-, p, q, r, s}, P2, S2 ) mit Produktionsregeln:
- S2 → A.
- S2 → A. S2
- A → B | B :- B
- B → p | q | r | s

Semantik W(P):
- W(x.) = {x}
- W(x :- y.) = ∅
- W(P′ x.) = W(P′) ∪ {x}
- W(P′ x :- y.) = W(P′) ∪ {x}, falls y ∈ W(P′), sonst W(P′)

Aufgabe: Entscheidet Syntaktik + Semantik für:
i) r :- s :- p.
ii) q :- r. r. s. p :- s.
iii) t.
iv) p. p :- s. q. r :- q.

Beispielhafte Struktur der Lösung:
- i) Syntax: {Beurteilung}. Semantik: {Herleitung/Begründung}.
- ii) …
- iii) …
- iv) …

## b) Behauptung 1
These: „Zwei Ausdrücke (möglicherweise aus verschiedenen Sprachen) haben genau dann die gleiche Syntax, wenn sie die gleiche Semantik haben.“
- Entscheidung: {Begründen oder widerlegen}
- Beweis/Beispiel: {…}

## c) Behauptung 2
These: „Zwei Ausdrücke einer Sprache mit unterschiedlicher Syntax haben auch immer eine unterschiedliche Semantik.“
- Entscheidung: {Begründen oder widerlegen}
- Beweis/Beispiel: {…}
```

</details>
