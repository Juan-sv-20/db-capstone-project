CREATE DEFINER=`coder`@`%` PROCEDURE `menuItem_Soldmore_Than2`()
BEGIN
	SELECT
		i.Name AS MenuName,
        m.Cousine
	FROM
		MenuItem i
        INNER JOIN
        Menu m ON i.MenuID = m.MenuID
	WHERE
		2 < ANY (SELECT COUNT(OrderID) FROM Orders WHERE MenuItemID = i.MenuItemID);
END