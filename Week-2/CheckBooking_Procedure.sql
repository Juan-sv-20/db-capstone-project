CREATE DEFINER=`coder`@`%` PROCEDURE `CheckBooking`(IN date_Booked DATETIME, IN Table_No INT)
BEGIN
	DECLARE isBusy_ Boolean;
    
	SELECT isBusy INTO isBusy_ FROM Tables WHERE Tables.TablesNo = Table_No & Tables.TimeSlot = date_Booked;
    
    IF isBusy_ THEN
		SELECT CONCAT('Table No. ', Table_No, ' is already booked!') AS 'Booking Status';
	ELSE
		SELECT CONCAT('Table No. ', Table_No, ' is available!') AS 'Booking Status';
	END IF;
END