-- Procedura dodania nowego klienta:
DELIMITER $$

CREATE PROCEDURE DodajKlienta(
    IN imie VARCHAR(100),
    IN nazwisko VARCHAR(100),
    IN adres VARCHAR(255),
    IN telefon VARCHAR(15),  
    IN email VARCHAR(100)     
)
BEGIN
    INSERT INTO Klient (imie, nazwisko, adres, telefon, email)
    VALUES (imie, nazwisko, adres, telefon, email);
END $$

DELIMITER ;

CALL DodajKlienta('Anna', 'Kowalska', 'Warszawa, ul. Długa 5', '123456789', 'anna.kowalska@example.com');




-- Procedura usuwania klienta:
DELIMITER $$

CREATE PROCEDURE UsunKlienta (
    IN p_id_klienta INT
)
BEGIN
    DELETE FROM Klient
    WHERE id_klienta = p_id_klienta;
END$$

DELIMITER ;


CALL UsunKlienta(37);
