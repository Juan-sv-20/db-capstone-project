CREATE DEFINER=`coder`@`%` FUNCTION `costBeforeTax`(Quantity INT, MenuItemID INT) RETURNS float
    DETERMINISTIC
BEGIN
    DECLARE ItemPrice FLOAT;
    
    SELECT MenuItem.Cost INTO ItemPrice
    FROM MenuItem
    WHERE MenuItem.MenuItemID = MenuItemID;

    IF ItemPrice IS NOT NULL THEN
        RETURN Quantity * ItemPrice;
    ELSE
        RETURN NULL;
    END IF;
END