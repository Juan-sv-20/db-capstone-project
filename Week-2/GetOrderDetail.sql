USE LittleLemonDM;
PREPARE GetOrderDetail FROM 
'SELECT 
	OrderID, Quantity, ROUND(TotalCost) AS "Cost" 
FROM 
	Orders 
WHERE 
	OrderID = ?;';
SET @order_id = 9;
EXECUTE GetOrderDetail USING @order_id;