CREATE DEFINER=`coder`@`%` PROCEDURE `CancelOrder`(IN OrderID INT, OUT result VARCHAR(100))
BEGIN
	DELETE FROM Orders  WHERE Orders.OrderID = OrderID;
    SET result = CONCAT('Order ', OrderID, ' is cancelled');
END