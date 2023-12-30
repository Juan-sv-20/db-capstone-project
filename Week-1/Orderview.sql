CREATE VIEW OrdersView AS
SELECT OrderID AS 'Order ID', Quantity, TotalCost AS 'Total cost'
FROM Orders
WHERE Quantity > 2;