# SQL-biuro_podrozy

## Opis Projektu

Projekt "SQL Biuro Podróży" ma na celu stworzenie systemu zarządzania działalnością biura podróży, który umożliwia gromadzenie i zarządzanie danymi o wycieczkach, klientach i pilotach. System będzie służył do organizowania, analizowania i monitorowania wycieczek oraz obsługi klientów biura podróży.

W ramach projektu stworzone zostały zapytania SQL do obsługi wycieczek, pilota, klientów oraz procesu rezerwacji miejsc.

## Projekt obejmuje:

Strukturę bazy danych, która składa się z tabel przechowujących informacje o wycieczkach, pilotach, klientach, itd.
Zapytania SQL do wyszukiwania i analizowania danych związanych z wycieczkami i klientami.
Przykłady zapytań dla różnych zastosowań – raportów sprzedaży, sprawdzania dostępności miejsc, itp.

## Przykładowe zapytania SQL

```sql
-- Informacje o klientach:
SELECT * FROM Klient;
```
![image](https://github.com/user-attachments/assets/fc0758dc-c52b-4198-8e50-4bc2252a9aab)
```sql
-- Klienci i ich rezerwacje:
SELECT k.id_klienta, k.imie, k.nazwisko, r.id_rezerwacji, r.liczba_miejsc
FROM Klient k
LEFT JOIN Rezerwacja r ON k.id_klienta = r.id_klienta;

-- Dostępne wycieczki:
SELECT w.id_wycieczki, t.opis_trasy, w.koszt, w.liczba_miejsc, p.imie AS pilot_imie, p.nazwisko AS pilot_nazwisko
FROM Wycieczka w
JOIN Trasa t ON w.id_trasy = t.id_trasy
JOIN Pilot p ON w.id_pilota = p.id_pilota
WHERE w.liczba_miejsc > 0;


-- Rezerwacja klienta (id kilenta):
SELECT k.imie, k.nazwisko, w.koszt, r.liczba_miejsc, r.kwota_do_zaplaty
FROM Rezerwacja r
JOIN Klient k ON r.id_klienta = k.id_klienta
JOIN Wycieczka w ON r.id_wycieczki = w.id_wycieczki
WHERE k.id_klienta = 1;

-- Aktualizacja kosztu wycieczki (id wycieczki):
UPDATE Wycieczka
SET koszt = 2000.00
WHERE id_wycieczki = 1;

-- Zmiana danych klienta (np. nr telefonu):
UPDATE Klient
SET telefon = '987654321'
WHERE id_klienta = 1;


-- Aktualizacja liczby dostępnych miejsc w wycieczce po rezerwacji:
UPDATE Wycieczka
SET liczba_miejsc = liczba_miejsc - 2
WHERE id_wycieczki = 1;

-- Top 3 wycieczki z największą liczbą rezerwacji:
SELECT w.id_wycieczki, t.opis_trasy, COUNT(r.id_rezerwacji) AS liczba_rezerwacji
FROM Wycieczka w
JOIN Trasa t ON w.id_trasy = t.id_trasy
JOIN Rezerwacja r ON w.id_wycieczki = r.id_wycieczki
GROUP BY w.id_wycieczki, t.opis_trasy
ORDER BY liczba_rezerwacji DESC
LIMIT 3;

-- Łączny przychód biura podróży:
SELECT SUM(kwota_do_zaplaty) AS laczny_przychod
FROM Rezerwacja
WHERE status = 'Potwierdzona';

-- Dostępne miejsca w wycieczkach:
SELECT w.id_wycieczki, t.opis_trasy, w.liczba_miejsc, w.koszt
FROM Wycieczka w
JOIN Trasa t ON w.id_trasy = t.id_trasy
WHERE w.liczba_miejsc > 0;

-- Klienci, którzy zarezerwowali więcej niż 3 miejsca:
SELECT k.id_klienta, k.imie, k.nazwisko, SUM(r.liczba_miejsc) AS liczba_miejsc
FROM Klient k
JOIN Rezerwacja r ON k.id_klienta = r.id_klienta
GROUP BY k.id_klienta, k.imie, k.nazwisko
HAVING liczba_miejsc > 3;
