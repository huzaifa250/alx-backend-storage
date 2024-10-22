-- Creates a trigger that decreases the quantity of an item after adding a new order
DROP TRIGGER IF EXISTS reduce_quantity;
DELIMITER $$

CREATE TRIGGER reduce_quantity
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    -- Ensure that there's enough stock before reducing the quantity
    IF (SELECT quantity FROM items WHERE name = NEW.item_name) >= NEW.number THEN
        UPDATE items
        SET quantity = quantity - NEW.number
        WHERE name = NEW.item_name;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock for item: ' + NEW.item_name;
    END IF;
END $$

DELIMITER;
