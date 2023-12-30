CREATE DEFINER=`coder`@`%` PROCEDURE `insertOrder`(IN BookingID INT, IN Discount FLOAT, IN Tax FLOAT, IN Quantity INT, IN MenuItemID INT)
BEGIN
	DECLARE TotalCost FLOAT;
    DECLARE Cost FLOAT;
    
    SELECT costBeforeTax(Quantity, MenuItemID) INTO Cost;
    SET TotalCost = (Cost * Discount) + Tax;
    
    INSERT INTO `LittleLemonDM`.`Orders`
	(`BookingID`,
	`TotalCost`,
	`Discount`,
	`Tax`,
	`OrderStatus`,
	`Quantity`,
	`MenuItemID`,
	`CostBeforeTax`)
	VALUES (BookingID, TotalCost, Discount, Tax, 'Pending', Quantity, MenuItemID, Cost);
END