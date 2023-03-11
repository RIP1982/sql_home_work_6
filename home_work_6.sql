CREATE DATABASE IF NOT EXISTS home_work_6;
USE home_work_6;

-- 1. Создайте функцию, которая принимает кол-во сек и форматирует их в кол-во дней, часов, минут и секунд.
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

DROP FUNCTION IF EXISTS converter;

delimiter $$
CREATE FUNCTION converter(num INT)
RETURNS VARCHAR(30) 
DETERMINISTIC
BEGIN
    DECLARE days INT DEFAULT 0;
    DECLARE hours INT DEFAULT 0;
    DECLARE minutes INT DEFAULT 0;
    DECLARE seconds INT DEFAULT 0;
    DECLARE result VARCHAR(30) DEFAULT '';
    IF num/86400>= 1 THEN
       SET days=FLOOR(num/86400);
    END IF;
	IF (num-days*86400)/3600>=1 THEN
       SET hours=FLOOR((num-days*86400)/3600);
	END IF;
	IF (num-days*86400-hours*3600)/60>=1 THEN
		SET minutes=FLOOR((num-days*86400-hours*3600)/60);
        SET seconds=num-days*86400- hours*3600- minutes*60;
	END IF;
    SET result = CONCAT('Days=', days, '; ', hours, ':', minutes, ':',seconds);
    RETURN result;
END $$
delimiter ;

SELECT converter(123456);

-- 2. Выведите только четные числа от 1 до 10 включительно. (Через функцию / процедуру)
-- Пример: 2,4,6,8,10 (можно сделать через шаг +  2: х = 2, х+=2)

DROP PROCEDURE IF EXISTS even_numbers;

delimiter $$
CREATE PROCEDURE even_numbers()
BEGIN
    DECLARE x INT DEFAULT 0;
    DECLARE result VARCHAR(30) DEFAULT '';
    WHILE x < 10 DO
		SET x=x+2;
        SET result = CONCAT(result, ' ', x);
	END WHILE;
    SELECT result;
END $$
delimiter ;

CALL even_numbers;