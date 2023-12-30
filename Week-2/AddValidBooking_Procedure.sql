CREATE DEFINER=`coder`@`%` PROCEDURE `AddValidBooking`(
IN Date_Booked DATETIME,
IN Table_No INT)
BEGIN
	DECLARE rollback_msg VARCHAR(100) DEFAULT " is already booked - booking cancelled!";
    DECLARE commit_msg VARCHAR(100) DEFAULT " is available to be booked!";
    DECLARE table_null VARCHAR(100) DEFAULT " doesn't exists!";
    DECLARE isBusy_ BOOLEAN DEFAULT FALSE;
    DECLARE Table_ID_ INT DEFAULT NULL;
    
	START TRANSACTION;
    
    SELECT isBusy, TableID INTO isBusy_, Table_ID_ FROM Tables WHERE TimeSlot = Date_Booked AND TablesNo = Table_No;
    
    IF isBusy_ THEN
		ROLLBACK;
        SELECT CONCAT('Table ', Table_No, rollback_msg) AS 'Booking Status';
	ELSE
		IF Table_ID_ IS NOT NULL THEN
			COMMIT;
			SELECT CONCAT('Table ', Table_No, commit_msg) AS 'Booking Status';
		ELSE
			SELECT CONCAT('Table ', Table_No, table_null) AS 'Booking Status';
        END IF;
	END IF;
END