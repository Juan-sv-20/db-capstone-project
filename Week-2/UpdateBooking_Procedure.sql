CREATE DEFINER=`coder`@`%` PROCEDURE `UpdateBooking`(IN bookingID_ INT, IN BookingDate DATETIME)
BEGIN
	DECLARE tableID_ INT;
    DECLARE success_msg VARCHAR(100) DEFAULT " updated";
    
    SELECT TableID INTO tableID_ FROM Bookings WHERE BookingID = bookingID_ LIMIT 1;
    
    START TRANSACTION;
		
		UPDATE Bookings
		SET
			TimeSlot = BookingDate,
            LastUpdate = NOW()
		WHERE
			BookingID = bookingID_;
		
		UPDATE Tables
		SET
			TimeSlot = BookingDate
		WHERE
			TableID = tableID_;
            
    COMMIT;
    SELECT CONCAT('Booking ', bookingID_, success_msg) AS 'Confirmation';
END