CREATE DEFINER=`coder`@`%` PROCEDURE `CancelBooking`(IN bookingID_ INT)
BEGIN
	DECLARE tableID_ INT;
    
    SELECT TableID INTO tableID_ FROM Bookings WHERE BookingID = bookingID_ LIMIT 1;
    
    START TRANSACTION;
    
    DELETE FROM Bookings WHERE BookingID = bookingID_;
    
    UPDATE Tables
    SET
		isBusy = 0
    WHERE
		TableID = tableID_;
	
    COMMIT;
    
    SELECT CONCAT('Booking ', bookingID_, ' cancelled!') AS Confirmation;
END