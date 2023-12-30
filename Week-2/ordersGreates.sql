CREATE DEFINER=`coder`@`%` PROCEDURE `ordersGreatest`()
BEGIN
	SELECT
		c.CustomerID,
        CONCAT(c.FirstName, ' ', c.LastName) AS Fullname,
        b.BookingID,
        o.OrderID,
        ROUND(o.TotalCost, 2),
        m.Name AS FoodName
	FROM
		Orders o
        INNER JOIN
        Bookings b ON o.BookingID = b.BookingID
        INNER JOIN
        Customers c ON b.CustomerID = c.CustomerID
        INNER JOIN
        MenuItem m ON o.MenuItemID = m.MenuItemID
	WHERE
		o.TotalCost > 150 Order by o.TotalCost ASC;
END