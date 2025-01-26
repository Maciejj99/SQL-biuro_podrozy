CREATE TABLE Pilot (
    id_pilota INT AUTO_INCREMENT PRIMARY KEY,
    imie VARCHAR(50) NOT NULL,
    nazwisko VARCHAR(50) NOT NULL,
    adres VARCHAR(100) NOT NULL,
    telefon VARCHAR(15),
    email VARCHAR(100)
);



CREATE TABLE Klient (
    id_klienta INT AUTO_INCREMENT PRIMARY KEY,
    imie VARCHAR(50) NOT NULL,
    nazwisko VARCHAR(50) NOT NULL,
    adres VARCHAR(100) NOT NULL,
    telefon VARCHAR(15),
    email VARCHAR(100),
    data_rejestracji DATE DEFAULT (CURRENT_DATE)
);


    
    
CREATE TABLE Trasa (
    id_trasy INT AUTO_INCREMENT PRIMARY KEY,
    opis_trasy TEXT NOT NULL,
    dlugosc_km INT DEFAULT NULL,
    region VARCHAR(50) DEFAULT NULL
);

    

CREATE TABLE SrodekTransportu (
    id_srodka INT AUTO_INCREMENT PRIMARY KEY,
    typ VARCHAR(50) NOT NULL,
    nazwa VARCHAR(100),
    pojemnosc INT DEFAULT NULL,
    uwagi TEXT DEFAULT NULL
);



CREATE TABLE Wycieczka (
    id_wycieczki INT AUTO_INCREMENT PRIMARY KEY,
    id_trasy INT NOT NULL,
    id_pilota INT NOT NULL,
    liczba_miejsc INT NOT NULL,
    koszt DECIMAL(10, 2) NOT NULL,
    data_poczatku DATE NOT NULL,
    data_konca DATE NOT NULL,
    opis_dodatkowy TEXT DEFAULT NULL,
    FOREIGN KEY (id_trasy) REFERENCES Trasa(id_trasy),
    FOREIGN KEY (id_pilota) REFERENCES Pilot(id_pilota)
);    


CREATE TABLE Transport (
    id_transportu INT AUTO_INCREMENT PRIMARY KEY,
    id_wycieczki INT NOT NULL,
    id_srodka INT NOT NULL,
    uwagi TEXT DEFAULT NULL,
    FOREIGN KEY (id_wycieczki) REFERENCES Wycieczka(id_wycieczki),
    FOREIGN KEY (id_srodka) REFERENCES SrodekTransportu(id_srodka)
);



CREATE TABLE Rezerwacja (
    id_rezerwacji INT AUTO_INCREMENT PRIMARY KEY,
    id_klienta INT NOT NULL,
    id_wycieczki INT NOT NULL,
    data_rejestracji DATE DEFAULT (CURRENT_DATE),
    liczba_miejsc INT NOT NULL,
    status ENUM('Oczekująca', 'Potwierdzona', 'Anulowana') NOT NULL DEFAULT 'Oczekująca',
    kwota_do_zaplaty DECIMAL(10, 2) NOT NULL,
    data_platnosci DATE DEFAULT NULL,
    FOREIGN KEY (id_klienta) REFERENCES Klient(id_klienta),
    FOREIGN KEY (id_wycieczki) REFERENCES Wycieczka(id_wycieczki)
);    
    


CREATE TABLE Platnosc (
    id_platnosci INT AUTO_INCREMENT PRIMARY KEY,
    id_rezerwacji INT NOT NULL,
    kwota DECIMAL(10, 2) NOT NULL,
    data_platnosci DATE DEFAULT (CURRENT_DATE),
    metoda ENUM('Przelew', 'Karta', 'Gotówka') DEFAULT 'Gotówka',
    FOREIGN KEY (id_rezerwacji) REFERENCES Rezerwacja(id_rezerwacji)
);


    
    
