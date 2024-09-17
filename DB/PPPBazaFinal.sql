/*
SQLyog Community v13.1.9 (64 bit)
MySQL - 8.0.39 : Database - ppp_skladiste
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ppp_skladiste` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `ppp_skladiste`;

/*Table structure for table `buyer` */

DROP TABLE IF EXISTS `buyer`;

CREATE TABLE `buyer` (
  `legal_entity_id` bigint NOT NULL,
  PRIMARY KEY (`legal_entity_id`),
  CONSTRAINT `fk1` FOREIGN KEY (`legal_entity_id`) REFERENCES `legal_entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `buyer` */

insert  into `buyer`(`legal_entity_id`) values 
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12);

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `category` */

insert  into `category`(`id`,`name`) values 
(1,'hrana'),
(2,'Hemija'),
(3,'Namestaj'),
(4,'Plastika');

/*Table structure for table `city` */

DROP TABLE IF EXISTS `city`;

CREATE TABLE `city` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `city` */

insert  into `city`(`id`,`name`) values 
(1,'Beograd'),
(5,'Minhen'),
(6,'Cirih'),
(7,'Zabljak');

/*Table structure for table `legal_entity` */

DROP TABLE IF EXISTS `legal_entity`;

CREATE TABLE `legal_entity` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `city_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_1` (`city_id`),
  CONSTRAINT `fk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `legal_entity` */

insert  into `legal_entity`(`id`,`name`,`city_id`) values 
(1,'Perutnina',1),
(2,'Novi Kupac',1),
(3,'Novi Kupac2',1),
(4,'NoviKupac',1),
(5,'Malkier',1),
(6,'MALKIER',1),
(7,'MalkierDoo',1),
(8,'Proba',1),
(9,'string',1),
(10,'Maliker',1),
(11,'Boehringer',1),
(12,'Boehringer Ingelheim',5);

/*Table structure for table `order` */

DROP TABLE IF EXISTS `order`;

CREATE TABLE `order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `timestamp` datetime NOT NULL,
  `buyer_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk7` (`buyer_id`),
  CONSTRAINT `fk7` FOREIGN KEY (`buyer_id`) REFERENCES `buyer` (`legal_entity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `order` */

insert  into `order`(`id`,`timestamp`,`buyer_id`) values 
(1,'2024-09-17 12:24:35',5),
(2,'2024-09-17 15:14:12',1),
(5,'2024-09-17 15:31:29',2);

/*Table structure for table `order_item` */

DROP TABLE IF EXISTS `order_item`;

CREATE TABLE `order_item` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL,
  `quantity` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`,`order_id`),
  KEY `fk9` (`order_id`),
  KEY `fk10` (`product_id`),
  CONSTRAINT `fk10` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk9` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `order_item` */

insert  into `order_item`(`id`,`order_id`,`quantity`,`product_id`) values 
(1,1,3,1),
(2,1,2,2),
(3,2,3,2),
(4,5,3,14);

/*Table structure for table `price` */

DROP TABLE IF EXISTS `price`;

CREATE TABLE `price` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `price` */

insert  into `price`(`id`,`amount`) values 
(16,100),
(17,150),
(18,1500),
(20,3000);

/*Table structure for table `product` */

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `measurement_unit` varchar(10) NOT NULL,
  `category_id` bigint NOT NULL,
  `supplier_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk3` (`category_id`),
  KEY `fk4` (`supplier_id`),
  CONSTRAINT `fk3` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `fk4` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`legal_entity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `product` */

insert  into `product`(`id`,`name`,`measurement_unit`,`category_id`,`supplier_id`) values 
(1,'Piletina','kg',1,1),
(2,'Prasetina','KG',1,1),
(8,'Teletina','kg',1,1),
(9,'Bokal','pcs',2,1),
(10,'SerpaM','pcs',2,1),
(14,'Balvan','pcs',1,1),
(15,'Balvani','pcs',1,1),
(18,'Ventilator','pcs',1,1);

/*Table structure for table `product_price` */

DROP TABLE IF EXISTS `product_price`;

CREATE TABLE `product_price` (
  `product_id` bigint NOT NULL,
  `price_id` bigint NOT NULL,
  `starting_date` datetime NOT NULL,
  `ending_date` datetime DEFAULT NULL,
  PRIMARY KEY (`product_id`,`price_id`,`starting_date`),
  KEY `fk6` (`price_id`),
  CONSTRAINT `fk5` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk6` FOREIGN KEY (`price_id`) REFERENCES `price` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `product_price` */

insert  into `product_price`(`product_id`,`price_id`,`starting_date`,`ending_date`) values 
(14,16,'2024-09-16 18:55:16','2024-09-16 18:56:08'),
(14,17,'2024-09-16 18:56:08','2024-09-16 19:07:53'),
(14,18,'2024-09-16 19:07:53',NULL),
(18,20,'2024-09-16 19:11:16',NULL);

/*Table structure for table `supplier` */

DROP TABLE IF EXISTS `supplier`;

CREATE TABLE `supplier` (
  `legal_entity_id` bigint NOT NULL,
  PRIMARY KEY (`legal_entity_id`),
  CONSTRAINT `fk2` FOREIGN KEY (`legal_entity_id`) REFERENCES `legal_entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `supplier` */

insert  into `supplier`(`legal_entity_id`) values 
(1);

/* Procedure structure for procedure `addBuyer` */

/*!50003 DROP PROCEDURE IF EXISTS  `addBuyer` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addBuyer`(
    IN ename VARCHAR(40), 
    IN cityId BIGINT
)
BEGIN
    DECLARE X INT DEFAULT -1;
    DECLARE Y INT DEFAULT -1;
    DECLARE newId BIGINT;

    -- Start the transaction
    START TRANSACTION;

    -- Check if the cityId exists in the city table
    SELECT COUNT(*) INTO X FROM `city` WHERE id = cityId;
    IF (X != 1) THEN
        -- If the city doesn't exist, rollback the transaction and signal an error
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'City does not exist';
    END IF;

    -- Check if the name already exists in the buyer table
    SELECT COUNT(*) INTO Y FROM `legal_entity` 
    JOIN `buyer` ON `legal_entity`.`id` = `buyer`.`legal_entity_id` 
    WHERE `legal_entity`.`name` = ename;
    IF (Y > 0) THEN
        -- If the name exists, rollback the transaction and signal an error
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Buyer with that name already exists';
    END IF;

    -- Add new row to legal_entity table
    INSERT INTO `legal_entity`(`name`, `city_id`) VALUES(ename, cityId);
    
    -- Get the id of the newly inserted legal_entity row
    SET newId = LAST_INSERT_ID();
    
    -- Insert new row into buyer table with the new legal_entity id
    INSERT INTO `buyer`(`legal_entity_id`) VALUES(newId);
    
    -- Commit the transaction
    COMMIT;
END */$$
DELIMITER ;

/* Procedure structure for procedure `addCategory` */

/*!50003 DROP PROCEDURE IF EXISTS  `addCategory` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addCategory`(IN cname VARCHAR(30))
BEGIN
    DECLARE categoryCount INT DEFAULT 0;

    -- Check if a category with the same name (case insensitive, trimmed) already exists
    SELECT COUNT(*) INTO categoryCount
    FROM category
    WHERE TRIM(LOWER(name)) = TRIM(LOWER(cname));

    IF categoryCount > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Category with the same name already exists';
    ELSE
        -- If no category with the same name exists, insert the new category
        INSERT INTO category(`name`) VALUES(TRIM(cname));
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `addCategoryCheckName` */

/*!50003 DROP PROCEDURE IF EXISTS  `addCategoryCheckName` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addCategoryCheckName`(IN cname VARCHAR(30))
BEGIN
    DECLARE categoryCount INT DEFAULT 0;

    -- Check if a category with the same name already exists
    SELECT COUNT(*) INTO categoryCount FROM `category` WHERE `name` = cname;
    IF categoryCount > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Category with this name already exists';
    ELSE
        -- If no category with the same name exists, insert the new category
        INSERT INTO category(`name`) VALUES(cname);
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `addCity` */

/*!50003 DROP PROCEDURE IF EXISTS  `addCity` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addCity`(IN cname VARCHAR(20))
BEGIN
    -- Check if the city already exists (ignoring case)
    IF NOT EXISTS (
        SELECT 1 
        FROM city 
        WHERE LOWER(name) = LOWER(cname)
    ) THEN
        -- If city doesn't exist, insert it
        INSERT INTO city(name) VALUES(cname);
    ELSE
        -- If city already exists, you can either do nothing or raise an error, for example:
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'City with this name already exists';
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `addCityCheckName` */

/*!50003 DROP PROCEDURE IF EXISTS  `addCityCheckName` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addCityCheckName`(IN cname VARCHAR(20))
BEGIN
    DECLARE cityCount INT DEFAULT 0;

    -- Check if a city with the given name already exists
    SELECT COUNT(*) INTO cityCount FROM `city` WHERE `name` = cname;

    IF cityCount > 0 THEN
        -- If a city with the same name exists, raise an error
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'City with this name already exists';
    ELSE
        -- If no city with the same name exists, insert the new city
        INSERT INTO `city`(`name`) VALUES(cname);
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `addLegalEntity` */

/*!50003 DROP PROCEDURE IF EXISTS  `addLegalEntity` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addLegalEntity`(in ename varchar(40),IN cityId BIGINT)
BEGIN
		DECLARE X INT DEFAULT -1;		
		
		
		SELECT COUNT(*) INTO X FROM `city` WHERE city.id = cityId;
		IF(X != 1) THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'city does not exist';
		END IF;
		
		insert into `legal_entity`(`name`,`city_id`) values(ename,cityId);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `addLegalEntityCheckName` */

/*!50003 DROP PROCEDURE IF EXISTS  `addLegalEntityCheckName` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addLegalEntityCheckName`(IN ename VARCHAR(40), IN cityId BIGINT)
BEGIN
    DECLARE X INT DEFAULT -1;
    DECLARE entityCount INT DEFAULT 0;

    -- Check if the cityId exists in the city table
    SELECT COUNT(*) INTO X FROM `city` WHERE city.id = cityId;
    IF (X != 1) THEN 
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'City does not exist';
    END IF;

    -- Check if a legal entity with the same name already exists
    SELECT COUNT(*) INTO entityCount FROM `legal_entity` WHERE `name` = ename;
    IF entityCount > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Legal entity with this name already exists';
    ELSE
        -- If no legal entity with the same name exists, insert the new legal entity
        INSERT INTO `legal_entity`(`name`, `city_id`) VALUES(ename, cityId);
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `addOrder` */

/*!50003 DROP PROCEDURE IF EXISTS  `addOrder` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addOrder`(
    IN orderDate DATE,
    IN buyerId BIGINT
)
BEGIN
    DECLARE buyerExists INT;

    -- Check if the buyer ID exists
    SELECT COUNT(*) INTO buyerExists FROM `buyer` WHERE `id` = buyerId;
    IF buyerExists = 0 THEN 
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Buyer does not exist';
    END IF;

    -- Insert the new order
    INSERT INTO `orders`(`order_date`, `buyer_id`) VALUES(orderDate, buyerId);
END */$$
DELIMITER ;

/* Procedure structure for procedure `addOrderItem` */

/*!50003 DROP PROCEDURE IF EXISTS  `addOrderItem` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addOrderItem`(in orderId bigint,IN quantity BIGINT, in productId bigint)
BEGIN
		DECLARE X,Y INT DEFAULT -1;
		
		
		IF(quantity < 0) THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'negative quantity';
		END IF;
		
		
		
		SELECT COUNT(*) INTO Y FROM `order` WHERE order.id = id;
		IF(Y != 1) THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'order does not exist';
		END IF;
		
		select count(*) into X from product where product.id = productId;
		IF(X != 1) THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'product does not exist';
		END IF;
		
		insert into ppp_skladiste.order_item(`order_id`,`order_item`.`quantity`,`product_id`) values(orderId,quantity,productId);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `addOrderWithItems` */

/*!50003 DROP PROCEDURE IF EXISTS  `addOrderWithItems` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addOrderWithItems`(
    IN buyerId BIGINT,
    IN orderItems JSON
)
BEGIN
    DECLARE orderId BIGINT;
    DECLARE productId BIGINT;
    DECLARE quantity INT;
    DECLARE itemIndex INT DEFAULT 0;
    DECLARE itemCount INT;

    -- Start a transaction
    START TRANSACTION;

    -- Check if the buyerId is valid
    IF NOT EXISTS (SELECT 1 FROM `buyer` WHERE `legal_entity_id` = buyerId) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid buyerId: Buyer does not exist';
    END IF;

    -- Insert the new order, setting the order_date to the current timestamp
    INSERT INTO `order`(`timestamp`, `buyer_id`) VALUES(NOW(), buyerId);
    
    -- Get the id of the newly inserted order
    SET orderId = LAST_INSERT_ID();

    -- Get the number of order items
    SET itemCount = JSON_LENGTH(orderItems);

    -- Loop through the order items
    WHILE itemIndex < itemCount DO
        SET productId = JSON_UNQUOTE(JSON_EXTRACT(orderItems, CONCAT('$[', itemIndex, '].product_id')));
        SET quantity = JSON_UNQUOTE(JSON_EXTRACT(orderItems, CONCAT('$[', itemIndex, '].quantity')));

        -- Check if the productId is valid
        IF NOT EXISTS (SELECT 1 FROM `product` WHERE `id` = productId) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid product_id!';
        END IF;

        -- Ensure the product_id is unique within the order
        IF EXISTS (SELECT 1 FROM `order_item` WHERE `order_id` = orderId AND `product_id` = productId) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Duplicate product_id in order items';
        END IF;

        -- Insert the order item
        INSERT INTO `order_item`(`order_id`, `product_id`, `quantity`) VALUES(orderId, productId, quantity);
        
        SET itemIndex = itemIndex + 1;
    END WHILE;

    -- Commit the transaction
    COMMIT;

END */$$
DELIMITER ;

/* Procedure structure for procedure `addPrice` */

/*!50003 DROP PROCEDURE IF EXISTS  `addPrice` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addPrice`(in p_amount double)
BEGIN
		insert into price(amount) values(p_amount);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `addPriceReturnId` */

/*!50003 DROP PROCEDURE IF EXISTS  `addPriceReturnId` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addPriceReturnId`(IN p_amount DOUBLE, OUT new_price_id BIGINT)
BEGIN
    -- Insert the new price into the table
    INSERT INTO price(amount) VALUES(p_amount);

    -- Retrieve the last inserted ID
    SET new_price_id = LAST_INSERT_ID();
END */$$
DELIMITER ;

/* Procedure structure for procedure `addProduct` */

/*!50003 DROP PROCEDURE IF EXISTS  `addProduct` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addProduct`(in pname varchar(30),IN munit VARCHAR(10), in categoryId bigint, in supplierId bigint)
BEGIN

		DECLARE x, y INT DEFAULT -1;
		
		select count(*) into X from category where id = categoryId;
		IF(X != 1) THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'category does not exist';
		END IF;
		
		SELECT COUNT(*) INTO Y FROM supplier WHERE legal_entity_id = supplierId;
		IF(Y != 1) THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'supplier does not exist';
		END IF;
		
		insert into product(name,measurement_unit,category_id,supplier_id) values(pname,munit,categoryId,supplierId);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `addProductCheckName` */

/*!50003 DROP PROCEDURE IF EXISTS  `addProductCheckName` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addProductCheckName`(IN pname VARCHAR(30), IN munit VARCHAR(10), IN categoryId BIGINT, IN supplierId BIGINT)
BEGIN
    DECLARE X, Y, Z INT DEFAULT -1;

    -- Check if the categoryId exists in the category table
    SELECT COUNT(*) INTO X FROM category WHERE id = categoryId;
    IF (X != 1) THEN 
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Category does not exist';
    END IF;

    -- Check if the supplierId exists in the supplier table
    SELECT COUNT(*) INTO Y FROM supplier WHERE legal_entity_id = supplierId;
    IF (Y != 1) THEN 
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Supplier does not exist';
    END IF;

    -- Check if a product with the same name already exists
    SELECT COUNT(*) INTO Z FROM product WHERE NAME = pname;
    IF (Z > 0) THEN 
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Product with this name already exists';
    END IF;

    -- If all checks pass, insert the new product
    INSERT INTO product(NAME, measurement_unit, category_id, supplier_id) 
    VALUES(pname, munit, categoryId, supplierId);
END */$$
DELIMITER ;

/* Procedure structure for procedure `addProductPrice` */

/*!50003 DROP PROCEDURE IF EXISTS  `addProductPrice` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addProductPrice`(in productId bigint, in priceId bigint, in startingDate date ,IN endingDate DATE )
BEGIN

		DECLARE x, y INT DEFAULT -1;
		
		select count(*) into X from product where id = productId;
		IF(X != 1) THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'product does not exist';
		END IF;
		
		SELECT COUNT(*) INTO Y FROM price WHERE id = priceId;
		IF(Y != 1) THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'price does not exist';
		END IF;
		
		insert into product_price(product_id,price_id,starting_date,ending_date) values(productId,priceId,startingDate,endingDate);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `addProductWithOrWithoutPrice` */

/*!50003 DROP PROCEDURE IF EXISTS  `addProductWithOrWithoutPrice` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addProductWithOrWithoutPrice`(
    IN pname VARCHAR(30),
    IN munit VARCHAR(10),
    IN categoryId BIGINT,
    IN supplierId BIGINT,
    IN priceAmount DOUBLE
)
BEGIN
    DECLARE productId BIGINT DEFAULT -1;
    DECLARE priceId BIGINT DEFAULT -1;
    DECLARE X, Y, Z INT DEFAULT -1;

    -- Start Transaction
    START TRANSACTION;

    -- Check if the category exists
    SELECT COUNT(*) INTO X FROM category WHERE id = categoryId;
    IF (X != 1) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Category does not exist';
    END IF;

    -- Check if the supplier exists
    SELECT COUNT(*) INTO Y FROM supplier WHERE legal_entity_id = supplierId;
    IF (Y != 1) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Supplier does not exist';
    END IF;

    -- Check if a product with the same name already exists
    SELECT COUNT(*) INTO Z FROM product WHERE NAME = pname;
    IF (Z != 0) THEN
        -- If a product with the same name exists, rollback and signal an error
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Product with the same name already exists';
    END IF;

    -- Insert new product
    INSERT INTO product(NAME, measurement_unit, category_id, supplier_id) 
    VALUES(pname, munit, categoryId, supplierId);
    
    -- Get the new productId
    SET productId = LAST_INSERT_ID();

    -- **Skip price insertion if priceAmount is 0 or negative**
    IF (priceAmount > 0) THEN
        -- Insert the new price
        INSERT INTO price(amount) VALUES(priceAmount);
        
        -- Get the new priceId
        SET priceId = LAST_INSERT_ID();
    END IF;

    -- Trigger will handle the insertion of product_price
-- Insert new product_price entry with the new price
         INSERT INTO product_price(product_id, price_id, starting_date) 
          VALUES(productId, LAST_INSERT_ID(), NOW());
    -- Commit the transaction
    COMMIT;
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `addProductWithPrice` */

/*!50003 DROP PROCEDURE IF EXISTS  `addProductWithPrice` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addProductWithPrice`(
    IN pname VARCHAR(30),
    IN munit VARCHAR(10),
    IN categoryId BIGINT,
    IN supplierId BIGINT,
    IN priceAmount DOUBLE
)
BEGIN
    DECLARE productId BIGINT DEFAULT -1;
    DECLARE priceId BIGINT DEFAULT -1;
    DECLARE X, Y, Z INT DEFAULT -1;

    -- Start Transaction
    START TRANSACTION;

    -- Check if the category exists
    SELECT COUNT(*) INTO X FROM category WHERE id = categoryId;
    IF (X != 1) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Category does not exist';
    END IF;

    -- Check if the supplier exists
    SELECT COUNT(*) INTO Y FROM supplier WHERE legal_entity_id = supplierId;
    IF (Y != 1) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Supplier does not exist';
    END IF;

    -- Check if a product with the same name already exists
    SELECT COUNT(*) INTO Z FROM product WHERE NAME = pname;
    IF (Z != 0) THEN
        -- If a product with the same name exists, rollback and signal an error
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Product with the same name already exists';
    END IF;

    -- Insert new product
    INSERT INTO product(NAME, measurement_unit, category_id, supplier_id) 
    VALUES(pname, munit, categoryId, supplierId);
    
    -- Get the new productId
    SET productId = LAST_INSERT_ID();

    -- Insert the new price
    INSERT INTO price(amount) VALUES(priceAmount);
    
    -- Get the new priceId
    SET priceId = LAST_INSERT_ID();

    -- Trigger will handle the insertion of product_price

    -- Commit the transaction
    COMMIT;
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `addProductWithPriceOld` */

/*!50003 DROP PROCEDURE IF EXISTS  `addProductWithPriceOld` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addProductWithPriceOld`(
    IN pname VARCHAR(30),
    IN munit VARCHAR(10),
    IN categoryId BIGINT,
    IN supplierId BIGINT,
    IN priceAmount DOUBLE
)
BEGIN
    DECLARE productId BIGINT DEFAULT -1;
    DECLARE priceId BIGINT DEFAULT -1;
    DECLARE X, Y, Z INT DEFAULT -1;

    -- Start Transaction
    START TRANSACTION;

    -- Check if the category exists
    SELECT COUNT(*) INTO X FROM category WHERE id = categoryId;
    IF (X != 1) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Category does not exist';
    END IF;

    -- Check if the supplier exists
    SELECT COUNT(*) INTO Y FROM supplier WHERE legal_entity_id = supplierId;
    IF (Y != 1) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Supplier does not exist';
    END IF;

    -- Check if a product with the same name already exists
    SELECT COUNT(*) INTO Z FROM product WHERE name = pname;
    IF (Z != 0) THEN
        -- If a product with the same name exists, rollback and signal an error
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Product with the same name already exists';
    END IF;

    -- Insert new product
    INSERT INTO product(name, measurement_unit, category_id, supplier_id) 
    VALUES(pname, munit, categoryId, supplierId);

    -- Insert the new price
    INSERT INTO price(amount) VALUES(priceAmount);

    -- Trigger will handle the insertion of product_price

    -- Commit the transaction
    COMMIT;
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `addSupplier` */

/*!50003 DROP PROCEDURE IF EXISTS  `addSupplier` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addSupplier`(
    IN ename VARCHAR(40), 
    IN cityId BIGINT
)
BEGIN
    DECLARE X INT DEFAULT -1;
    DECLARE Y INT DEFAULT -1;
    DECLARE newId BIGINT;

    -- Start the transaction
    START TRANSACTION;

    -- Check if the cityId exists in the city table
    SELECT COUNT(*) INTO X FROM `city` WHERE id = cityId;
    IF (X != 1) THEN
        -- If the city doesn't exist, rollback the transaction and signal an error
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'City does not exist';
    END IF;

    -- Check if the name already exists in the supplier table
    SELECT COUNT(*) INTO Y FROM `legal_entity` 
    JOIN `supplier` ON `legal_entity`.`id` = `supplier`.`legal_entity_id` 
    WHERE `legal_entity`.`name` = ename;
    IF (Y > 0) THEN
        -- If the name exists, rollback the transaction and signal an error
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Supplier with that name already exists';
    END IF;

    -- Add new row to legal_entity table
    INSERT INTO `legal_entity`(`name`, `city_id`) VALUES(ename, cityId);
    
    -- Get the id of the newly inserted legal_entity row
    SET newId = LAST_INSERT_ID();
    
    -- Insert new row into supplier table with the new legal_entity id
    INSERT INTO `supplier`(`legal_entity_id`) VALUES(newId);
    
    -- Commit the transaction
    COMMIT;
END */$$
DELIMITER ;

/* Procedure structure for procedure `deleteCategory` */

/*!50003 DROP PROCEDURE IF EXISTS  `deleteCategory` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCategory`(in id bigint)
BEGIN
		delete from category where category.id = id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `deleteCity` */

/*!50003 DROP PROCEDURE IF EXISTS  `deleteCity` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCity`(in id bigint)
BEGIN
		delete from city where city.id = id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `deleteLegalEntity` */

/*!50003 DROP PROCEDURE IF EXISTS  `deleteLegalEntity` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteLegalEntity`(in id bigint)
BEGIN
		delete from `legal_entity` where `legal_entity`.id = id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `deleteOrder` */

/*!50003 DROP PROCEDURE IF EXISTS  `deleteOrder` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteOrder`(in orderId bigint)
BEGIN
		delete from product where id = orderId;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `deleteOrderItem` */

/*!50003 DROP PROCEDURE IF EXISTS  `deleteOrderItem` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteOrderItem`(in orderId bigint,IN orderItemId BIGINT)
BEGIN
		delete from `order_item` where id = orderItemId and `order_id`=orderId;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `deletePrice` */

/*!50003 DROP PROCEDURE IF EXISTS  `deletePrice` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePrice`(in id bigint)
BEGIN
		delete from price where price.id = id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `deleteProduct` */

/*!50003 DROP PROCEDURE IF EXISTS  `deleteProduct` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteProduct`(in productId bigint)
BEGIN
		delete from product where product_id = productId;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `deleteProductPrice` */

/*!50003 DROP PROCEDURE IF EXISTS  `deleteProductPrice` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteProductPrice`(in productId bigint,IN priceId BIGINT,in startingDate date)
BEGIN
		delete from product_price where product_id = productId
						and price_id = priceId
						and starting_date = startingDate;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getAllBuyers` */

/*!50003 DROP PROCEDURE IF EXISTS  `getAllBuyers` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllBuyers`()
BEGIN
    SELECT 
        `buyer`.`legal_entity_id` AS `LegalEntityId`,
        `legal_entity`.`id` AS `LegalEntity_Id`,
        `legal_entity`.`name` AS `LegalEntity_Name`,
        `legal_entity`.`city_id` AS `LegalEntity_CityId`,
        `city`.`id` AS `LegalEntity_City_Id`,
        `city`.`name` AS `LegalEntity_City_Name`
    FROM 
        `buyer`
    INNER JOIN 
        `legal_entity` ON `buyer`.`legal_entity_id` = `legal_entity`.`id`
    INNER JOIN 
        `city` ON `legal_entity`.`city_id` = `city`.`id`;
END */$$
DELIMITER ;

/* Procedure structure for procedure `getAllCategories` */

/*!50003 DROP PROCEDURE IF EXISTS  `getAllCategories` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllCategories`()
BEGIN
		SELECT * FROM category;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getAllCities` */

/*!50003 DROP PROCEDURE IF EXISTS  `getAllCities` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllCities`()
BEGIN
		SELECT * FROM city;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getAllLegalEntities` */

/*!50003 DROP PROCEDURE IF EXISTS  `getAllLegalEntities` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllLegalEntities`()
BEGIN
		SELECT * FROM `legal_entity`;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getAllOrderItems` */

/*!50003 DROP PROCEDURE IF EXISTS  `getAllOrderItems` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllOrderItems`()
BEGIN
		SELECT * FROM ppp_skladiste.order_item;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getAllOrders` */

/*!50003 DROP PROCEDURE IF EXISTS  `getAllOrders` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllOrders`()
BEGIN
		SELECT * FROM ppp_skladiste.order;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getAllPoductPrices` */

/*!50003 DROP PROCEDURE IF EXISTS  `getAllPoductPrices` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllPoductPrices`()
BEGIN
		SELECT * FROM product_price;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getAllPrices` */

/*!50003 DROP PROCEDURE IF EXISTS  `getAllPrices` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllPrices`()
BEGIN
		SELECT * FROM price;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getAllProducts` */

/*!50003 DROP PROCEDURE IF EXISTS  `getAllProducts` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllProducts`()
BEGIN
		SELECT * FROM product;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getAllSuppliers` */

/*!50003 DROP PROCEDURE IF EXISTS  `getAllSuppliers` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllSuppliers`()
BEGIN
		SELECT `legal_entity`.id as id, `legal_entity`.`name` as `name`, `legal_entity`.`city_id` as cityId,`city`.name as cityName 
		FROM `supplier` 
		inner join `legal_entity` on `supplier`.`legal_entity_id` = `legal_entity`.`id`
		inner join `city` on `legal_entity`.`city_id`=`city`.id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getBuyerById` */

/*!50003 DROP PROCEDURE IF EXISTS  `getBuyerById` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getBuyerById`(IN buyerId INT)
BEGIN
    SELECT `legal_entity`.id AS id, `legal_entity`.`name` AS `name`, `legal_entity`.`city_id` AS cityId,`city`.name AS cityName 
		FROM `buyer` 
		INNER JOIN `legal_entity` ON `buyer`.`legal_entity_id` = `legal_entity`.`id`
		INNER JOIN `city` ON `legal_entity`.`city_id`=`city`.id
    WHERE `buyer`.`legal_entity_id` = buyerId;
END */$$
DELIMITER ;

/* Procedure structure for procedure `getCategoryById` */

/*!50003 DROP PROCEDURE IF EXISTS  `getCategoryById` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getCategoryById`(IN categoryId INT)
BEGIN
    SELECT * 
    FROM category 
    WHERE id = categoryId;
END */$$
DELIMITER ;

/* Procedure structure for procedure `getCityById` */

/*!50003 DROP PROCEDURE IF EXISTS  `getCityById` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getCityById`(IN cityId INT)
BEGIN
    SELECT * 
    FROM city 
    WHERE id = cityId;
END */$$
DELIMITER ;

/* Procedure structure for procedure `getOrderItems` */

/*!50003 DROP PROCEDURE IF EXISTS  `getOrderItems` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getOrderItems`(in orderId bigint)
BEGIN
		SELECT * FROM ppp_skladiste.order_item where `order_id`=orderId;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `updateBuyer` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateBuyer` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `updateBuyer`(
    IN buyerId BIGINT, 
    IN newName VARCHAR(40), 
    IN newCityId BIGINT
)
BEGIN
    DECLARE X INT DEFAULT -1;
    DECLARE Y INT DEFAULT -1;
    DECLARE legalEntityId BIGINT;

    -- Start the transaction
    START TRANSACTION;

    -- Check if the new cityId exists in the city table
    SELECT COUNT(*) INTO X FROM `city` WHERE id = newCityId;
    IF (X != 1) THEN
        -- If the city doesn't exist, rollback the transaction and signal an error
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'City does not exist';
    END IF;

    -- Retrieve the legal_entity_id associated with the provided buyerId
    SELECT legal_entity_id INTO legalEntityId FROM `buyer` WHERE legal_entity_id = buyerId;
    IF (legalEntityId IS NULL) THEN
        -- If the buyer does not exist, rollback the transaction and signal an error
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Buyer does not exist';
    END IF;

    -- Check if the new name already exists for another legal_entity that is associated with a different buyer
    SELECT COUNT(*) INTO Y FROM `legal_entity` 
    JOIN `buyer` ON `legal_entity`.`id` = `buyer`.`legal_entity_id` 
    WHERE `legal_entity`.`name` = newName AND `buyer`.`legal_entity_id` != buyerId;
    IF (Y > 0) THEN
        -- If the name exists, rollback the transaction and signal an error
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'A different buyer already has this name';
    END IF;

    -- Update the legal_entity table with the new name and city_id
    UPDATE `legal_entity`
    SET `name` = newName, `city_id` = newCityId
    WHERE `id` = legalEntityId;

    -- Commit the transaction
    COMMIT;
END */$$
DELIMITER ;

/* Procedure structure for procedure `updateCategory` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateCategory` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCategory`(in new_name varchar(20),in id bigint)
BEGIN
		update category set name = new_name where category.id = id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `updateCity` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateCity` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCity`(in new_name varchar(20),in id bigint)
BEGIN
		update city set name = new_name where city.id = id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `updateLegalEntity` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateLegalEntity` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `updateLegalEntity`(IN id BIGINT,IN ename VARCHAR(40),IN cityId BIGINT)
BEGIN
	DECLARE X,Y INT DEFAULT -1;
		
		SELECT COUNT(*) INTO X FROM `city` WHERE city.id = cityId;
		IF(X != 1) THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'city does not exist';
		END IF;
		
		SELECT COUNT(*) INTO Y FROM `legal_entity` WHERE  `legal_entity`.`id`= id;
		IF(Y != 1) THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'legal entity does not exist';
		END IF;
		
		
		update `legal_entity` set `name` = ename, `city_id`= cityId where `legal_entity`.`id`= id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `updateOrder` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateOrder` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `updateOrder`(IN id BIGINT, IN orderDate DATE, IN buyerId BIGINT)
BEGIN
	DECLARE X,Y INT DEFAULT -1;
		
		SELECT COUNT(*) INTO Y FROM `order` WHERE order.id = id;
		IF(Y != 1) THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'order does not exist';
		END IF;
		
		SELECT COUNT(*) INTO X FROM buyer WHERE `legal_entity_id` = buyerId;
		IF(X != 1) THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'buyer does not exist';
		END IF;
		update `order` set `date` = orderDate, `buyer_id`= buyerId where `order`.id = id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `updateOrderItem` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateOrderItem` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `updateOrderItem`(in id bigint, IN orderId BIGINT,IN productId BIGINT, IN quantity BIGINT)
BEGIN
		DECLARE X, Y, Z INT DEFAULT -1;
		
		IF(quantity < 0) THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'negative quantity';
		END IF;
		
		SELECT COUNT(*) INTO Z FROM product WHERE product.id = productId;
		IF(Z != 1) THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'product does not exist';
		END IF;
		
		
			SELECT COUNT(*) INTO X FROM `order` WHERE id = orderId;
			IF(X != 1) THEN 
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'order does not exist';
			END IF;
			
		
			SELECT COUNT(*) INTO Y FROM `order_id` WHERE order_id.id = id and `order_id`=orderId;
			IF(Y != 1) THEN 
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'orderItem does not exist';
			END IF;
			
			update `order_item` set `order_item`.`quantity` = quantity, `product_id`= productId where order_id.id = id AND `order_id`=orderId;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `updatePrice` */

/*!50003 DROP PROCEDURE IF EXISTS  `updatePrice` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `updatePrice`(in new_amount double,in id bigint)
BEGIN
		update price set amount = new_amount where price.id = id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `updateProduct` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateProduct` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `updateProduct`(in id bigint, IN pname VARCHAR(30),IN munit VARCHAR(10), IN categoryId BIGINT, IN supplierId BIGINT)
BEGIN
		DECLARE X, Y, Z INT DEFAULT -1;
		
		SELECT COUNT(*) INTO Z FROM product WHERE product.id = id;
		IF(Z != 1) THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'product does not exist';
		END IF;
		/*		
		IF(pname=='') THEN
		pname = (SELECT product.name FROM product WHERE product.id = id);
		END IF;
		
		if(munit=='') then
		munit = (select measurement_unit from product where product.id = id);
		end if;
		*/
		if(categoryId!=-1) then
			SELECT COUNT(*) INTO X FROM category WHERE id = categoryId;
			IF(X != 1) THEN 
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'category does not exist';
			END IF;
		END IF;
		IF(supplierId!=-1) THEN
			SELECT COUNT(*) INTO Y FROM supplier WHERE legal_entity_id = supplierId;
			IF(Y != 1) THEN 
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'supplier does not exist';
			END IF;
		END IF;
		
		update product set name=pname,measurement_unit = munit, `category_id`= categoryId, `supplier_id`=supplierId  WHERE product.id = id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `updateProductWithPrice` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateProductWithPrice` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `updateProductWithPrice`(
    IN productId BIGINT,
    IN pname VARCHAR(30),
    IN munit VARCHAR(10),
    IN categoryId BIGINT,
    IN supplierId BIGINT,
    IN priceAmount DOUBLE
)
BEGIN
    DECLARE X, Y, Z, existingPriceId INT DEFAULT -1;
    DECLARE currentPrice DOUBLE DEFAULT -1;
    
    -- Start Transaction
    START TRANSACTION;

    -- Check if the product exists
    SELECT COUNT(*) INTO X FROM product WHERE id = productId;
    IF (X != 1) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Product does not exist';
    END IF;

    -- Check if a product with the same name already exists (excluding this product)
    SELECT COUNT(*) INTO Z FROM product WHERE NAME = pname AND id != productId;
    IF (Z != 0) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Another product with the same name already exists';
    END IF;

    -- Check if the category exists
    SELECT COUNT(*) INTO X FROM category WHERE id = categoryId;
    IF (X != 1) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Category does not exist';
    END IF;

    -- Check if the supplier exists
    SELECT COUNT(*) INTO Y FROM supplier WHERE legal_entity_id = supplierId;
    IF (Y != 1) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Supplier does not exist';
    END IF;

    -- Update product information (excluding id)
    UPDATE product 
    SET NAME = pname, 
        measurement_unit = munit, 
        category_id = categoryId, 
        supplier_id = supplierId
    WHERE id = productId;

    -- Check if there is an existing price with no ending_date for this product
    SELECT pp.price_id, p.amount 
    INTO existingPriceId, currentPrice 
    FROM product_price pp
    JOIN price p ON pp.price_id = p.id
    WHERE pp.product_id = productId AND pp.ending_date IS NULL
    LIMIT 1;

    -- If the new price is different and greater than or equal to 0, insert the new price
    IF (priceAmount >= 0 AND priceAmount != currentPrice) THEN
        -- Update the ending_date for the existing price
        UPDATE product_price 
        SET ending_date = NOW()
        WHERE product_id = productId AND ending_date IS NULL;

        -- Insert the new price
        INSERT INTO price(amount) VALUES(priceAmount);

        -- Insert new product_price entry with the new price
         INSERT INTO product_price(product_id, price_id, starting_date) 
          VALUES(productId, LAST_INSERT_ID(), NOW());
    END IF;

    -- Commit the transaction
    COMMIT;
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `updateSupplier` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateSupplier` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `updateSupplier`(
    IN supplierId BIGINT, 
    IN newName VARCHAR(40), 
    IN newCityId BIGINT
)
BEGIN
    DECLARE X INT DEFAULT -1;
    DECLARE Y INT DEFAULT -1;
    DECLARE legalEntityId BIGINT;

    -- Start the transaction
    START TRANSACTION;

    -- Check if the new cityId exists in the city table
    SELECT COUNT(*) INTO X FROM `city` WHERE id = newCityId;
    IF (X != 1) THEN
        -- If the city doesn't exist, rollback the transaction and signal an error
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'City does not exist';
    END IF;

    -- Retrieve the legal_entity_id associated with the provided supplierId
    SELECT legal_entity_id INTO legalEntityId FROM `supplier` WHERE legal_entity_id = supplierId;
    IF (legalEntityId IS NULL) THEN
        -- If the supplier does not exist, rollback the transaction and signal an error
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'supplier does not exist';
    END IF;

    -- Check if the new name already exists for another legal_entity that is associated with a different supplier
    SELECT COUNT(*) INTO Y FROM `legal_entity` 
    JOIN `supplier` ON `legal_entity`.`id` = `supplier`.`legal_entity_id` 
    WHERE `legal_entity`.`name` = newName AND `supplier`.`legal_entity_id` != supplierId;
    IF (Y > 0) THEN
        -- If the name exists, rollback the transaction and signal an error
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'A different supplier already has this name';
    END IF;

    -- Update the legal_entity table with the new name and city_id
    UPDATE `legal_entity`
    SET `name` = newName, `city_id` = newCityId
    WHERE `id` = legalEntityId;

    -- Commit the transaction
    COMMIT;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
