CREATE DEFINER=`coder`@`%` PROCEDURE `getMaxQuantity`()
BEGIN
	SELECT MAX(Quantity) AS 'MAX Order Quantity' FROM Orders;
END