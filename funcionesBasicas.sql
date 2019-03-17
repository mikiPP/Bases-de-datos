SET GLOBAL log_bin_trust_function_creators = 1;

CREATE DATABASE IF NOT EXISTS EjerciciosBBDD;
USE EjerciciosBBDD;

DELIMITER //

/*1. Crea una función que devuelva 1 ó 0 si un número es o no divisible por otro. Debe de recibir
dos números por parámetros.*/

DROP FUNCTION IF EXISTS Divisible; //

CREATE FUNCTION Divisible(numero1 int(3), numero2 int(3))
	RETURNS int
BEGIN
	DECLARE numero int(1);
	IF mod(numero1,numero2) != 0 THEN
		SET numero = 1;
	
    ELSE 
		SET numero = 0;
        
	END IF;
		RETURN(numero);
END;

SELECT Divisible(6,3); //

SELECT Divisible(2,3); //

/*2. Usa las estructuras condicionales para mostrar el día de la semana según un valor de entrada
numérico, 1 para domingo, 2 lunes, etc.*/

DROP FUNCTION IF EXISTS devolverdia; //

CREATE FUNCTION devolverdia(dia int(1))
	RETURNS VARCHAR(10)
BEGIN    
    DECLARE diaSetmana varchar(20);
    IF dia = 1 THEN
		set diaSetmana = 'Lunes';
	
    elseif dia = 2 then
		set diaSetmana = 'Martes';
	
    elseif dia = 3 then
		set diaSetmana = 'Miercoles';
	
    elseif dia = 4 then
		set diaSetmana = 'Jueves';
	
    elseif dia = 5 then
		set diaSetmana = 'Viernes';
	
    elseif dia = 6 then
		set diaSetmana = 'Sabado';
	
    elseif dia = 7 then
		set diaSetmana = 'Domingo';
	
    else
		set diaSetmana = 'Null';
	
    end if;
		return(diaSetmana);
    END; //

SELECT devolverdia(1); //

SELECT devolverdia(8); //


/*3. Sabiendo que la función now() devuelve la fecha actual y que DATE_FORMAT le da
formato a la fecha, crea una procedimiento que llame a la función anterior del día de la
semana, y para los días “viernes” nos de la fecha de hoy en formato dd-mm-yyyy. */

DROP PROCEDURE IF EXISTS Fecha; //
CREATE PROCEDURE Fecha()
BEGIN
	DECLARE DIA INT(2);
    SET DIA = mod(date_format(now(), '%d'),5)+1;
	IF devolverDia(DIA) = 'Viernes' THEN
		SELECT date_format(now(), '%d-%M-%Y') as 'Fecha';
	ELSE
		SELECT date_format(now(), '%d') as 'dia';
	END IF;
END; //

CALL Fecha(); //

/*4. Crea un procedimiento que reciba una fecha por parámetro y muestre por pantalla el día de
la semana, seguido del número de día, mes y año como se muestra a continuación.
+------------------------------------+
| Fecha |
+------------------------------------+
| martes, 19 de febrero de 2019 */

DROP PROCEDURE IF EXISTS fechaActual; //

CREATE PROCEDURE fechaActual()
BEGIN
	SELECT date_format(now(), '%W, %d de %M de %Y') as 'Fecha';
END; //

CALL fechaActual(); //


-- 5. Crea una función, que reciba por parámetro una fecha de nacimiento y devuelva la edad de
-- la persona en años.

DROP FUNCTION IF EXISTS edad; //

CREATE FUNCTION edad(fechaNacimiento varchar(20))
	RETURNS int
	BEGIN
    DECLARE años int(3);
    SET años = DATEDIFF(now(),fechaNacimiento) / 365;
    RETURN años;
	END; //

SELECT edad('1999/09/02') AS Edad; //
SELECT edad('1998/01/16') AS Edad; //
SELECT edad('2010/10/02') AS Edad; //

/*6. Crea una función que devuelva el mayor de tres números pasados como parámetros.*/

DROP FUNCTION IF EXISTS MayorDeTresNumeros; //

CREATE FUNCTION MayorDeTresNumeros(a int(5), b int(5), c int(5))
	RETURNS int(5)
    BEGIN
    DECLARE resultado int;
    IF a > b THEN
		SET resultado = a;
	ELSE 
		SET resultado = b;
	END IF;
    IF c > resultado THEN
		SET resultado = c;
	end if;
    RETURN(resultado);
	END; //
        
    
SELECT MayorDeTresNumeros(1, 2, 3); //
SELECT MayorDeTresNumeros(4, 5, 3); //
SELECT MayorDeTresNumeros(8, 7, 6); //