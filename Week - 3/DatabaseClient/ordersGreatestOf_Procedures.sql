CREATE DEFINER=`coder`@`%` PROCEDURE `orderesGreatestOf`(IN value_ FLOAT)
BEGIN
	SELECT
		CONCAT(c.FirstName, ' ', c.LastName) AS FullName,
        c.ContactNumber,
        c.Email
	FROM
		Customers c
        INNER JOIN
        Bookings b ON c.CustomerID = b.CustomerID
        INNER JOIN
        Orders o ON b.BookingID = o.BookingID
	WHERE
		o.TotalCost > value_;
END