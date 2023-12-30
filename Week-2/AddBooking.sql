CREATE DEFINER=`coder`@`%` PROCEDURE `AddBooking`(IN CustomerID INT, IN BookingDate DATETIME, IN Table_No INT)
BEGIN
	DECLARE isBusy_ BOOLEAN;
    DECLARE tableID_ INT;
    DECLARE bookingAdded_msg VARCHAR(100) DEFAULT "New booking added";
    DECLARE bookingAdded_Error_msg VARCHAR(100) DEFAULT "Somenthing went wrong!";
    DECLARE Recepcionist INT;
    SET isBusy_ = FALSE;
    
    SELECT EmployeeID INTO Recepcionist FROM Employees WHERE Role = "Recepcionist" LIMIT 1;
    
    SELECT 
		TableID, isBusy 
    INTO 
		tableID_, isBusy_ 
    FROM 
		Tables 
    WHERE
    Tables.TimeSlot = BookingDate AND Tables.TablesNo = Table_No;
    
    IF isBusy_ IS NOT TRUE AND tableID_ IS NOT NULL THEN
		START TRANSACTION;
        
        INSERT INTO `LittleLemonDM`.`Bookings`
			(`TableID`,
			`EmployeeID`,
			`CustomerID`,
            `TimeSlot`)
		VALUES
			(Table_No, Recepcionist, CustomerID, BookingDate);
            
		UPDATE `LittleLemonDM`.`Tables`
		SET
		`isBusy` = 1
		WHERE 
        `TableID` = tableID_
        AND
        `TimeSlot` = BookingDate;

		COMMIT;
        SELECT bookingAdded_msg AS "Confirmation";
	ELSE
		SELECT bookingAdded_Error_msg AS "Confirmation";
	END IF;
    
END