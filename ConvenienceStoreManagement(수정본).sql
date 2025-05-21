-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema convenience_store_management
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `convenience_store_management` ;

-- -----------------------------------------------------
-- Schema convenience_store_management
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `convenience_store_management` DEFAULT CHARACTER SET utf8 ;
USE `convenience_store_management` ;

-- -----------------------------------------------------
-- Table `convenience_store_management`.`Category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `convenience_store_management`.`Category` ;

CREATE TABLE IF NOT EXISTS `convenience_store_management`.`Category` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `storage_conditions` ENUM('냉장', '냉동', '상온') NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

INSERT INTO `Category` VALUES
(1, '음료', '냉장'),
(2, '아이스크림', '냉동'),
(3, '과자', '상온'),
(4, '도시락', '냉장'),
(5, '우유', '냉장');

-- -----------------------------------------------------
-- Table `convenience_store_management`.`ActualSaleProduct`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `convenience_store_management`.`ActualSaleProduct` ;

CREATE TABLE IF NOT EXISTS `convenience_store_management`.`ActualSaleProduct` (
  `id` INT NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `manufacturer` VARCHAR(45) NOT NULL,
  `price` INT NOT NULL,
  `stock` INT NOT NULL,
  `Cat_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ActualSaleProduct_Category1_idx` (`Cat_id` ASC) VISIBLE,
  CONSTRAINT `fk_ActualSaleProduct_Category1`
    FOREIGN KEY (`Cat_id`)
    REFERENCES `convenience_store_management`.`Category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `ActualSaleProduct` VALUES
(1, '코카콜라', '코카콜라컴퍼니', 1500, 30, 1),
(2, '월드콘', '빙그레', 2000, 20, 2),
(3, '새우깡', '농심', 1200, 24, 3),
(4, '치킨마요', 'GS리테일', 4000, 10, 4),
(5, '서울우유', '서울우유', 1800, 45, 5);


-- -----------------------------------------------------
-- Table `convenience_store_management`.`Event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `convenience_store_management`.`Event` ;

CREATE TABLE IF NOT EXISTS `convenience_store_management`.`Event` (
  `id` INT NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `event_start_date` DATETIME NULL,
  `event_end_date` DATETIME NULL,
  `discount_rate` INT NULL,
  `event_satisfaction_conditions` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

INSERT INTO `Event` VALUES
(1, '1+1 행사', '2025-05-09 07:29:11', '2025-06-08 07:29:11', null, 1),
(2, '2+1 행사', '2025-05-14 07:29:11', '2025-06-13 07:29:11', null, 2),
(3, '카드 결제시 5% 할인행사', '2025-05-19 07:29:11', '2025-06-03 07:29:11', 5, null),
(4, '카드 결제시 10% 할인행사', '2025-05-17 07:29:11', '2025-06-06 07:29:11', 10, null),
(5, '3+1 행사', '2025-05-12 07:29:11', '2025-05-29 07:29:11', null, 3);


-- -----------------------------------------------------
-- Table `convenience_store_management`.`Sales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `convenience_store_management`.`Sales` ;

CREATE TABLE IF NOT EXISTS `convenience_store_management`.`Sales` (
  `id` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `totalAmount` INT NOT NULL,
  `payment_method` ENUM('현금', '카드') NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

INSERT INTO `Sales` VALUES
(1, '2025-05-18 07:29:11', 7800, '카드'),
(2, '2025-05-17 07:29:11', 3200, '현금'),
(3, '2025-05-16 07:29:11', 5500, '카드'),
(4, '2025-05-15 07:29:11', 10000, '현금'),
(5, '2025-05-14 07:29:11', 4100, '카드');


-- -----------------------------------------------------
-- Table `convenience_store_management`.`OrderLog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `convenience_store_management`.`OrderLog` ;

CREATE TABLE IF NOT EXISTS `convenience_store_management`.`OrderLog` (
  `id` INT NOT NULL,
  `order_quantity` INT NOT NULL,
  `cost` INT NOT NULL,
  `order_date` DATE NOT NULL,
  `ASP_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_order_actual_sale_product1_idx` (`ASP_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_actual_sale_product1`
    FOREIGN KEY (`ASP_id`)
    REFERENCES `convenience_store_management`.`ActualSaleProduct` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `OrderLog` VALUES
(1, 100, 150000, '2025-05-12 07:29:11', 1),
(2, 80, 160000, '2025-05-11 07:29:11', 2),
(3, 120, 144000, '2025-05-10 07:29:11', 3),
(4, 60, 240000, '2025-05-09 07:29:11', 4),
(5, 90, 162000, '2025-05-08 07:29:11', 5);


-- -----------------------------------------------------
-- Table `convenience_store_management`.`MonthlyClosing`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `convenience_store_management`.`MonthlyClosing` ;

CREATE TABLE IF NOT EXISTS `convenience_store_management`.`MonthlyClosing` (
  `id` INT NOT NULL,
  `sales` INT NOT NULL,
  `profit` INT NOT NULL,
  `order_cost` INT NOT NULL,
  `closing_month` DATE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

INSERT INTO `MonthlyClosing` VALUES
(1, 500000, 120000, 380000, '2025-05-01'),
(2, 450000, 100000, 350000, '2025-04-01'),
(3, 480000, 110000, 370000, '2025-03-02'),
(4, 510000, 130000, 380000, '2025-01-31'),
(5, 470000, 115000, 355000, '2025-01-01');


-- -----------------------------------------------------
-- Table `convenience_store_management`.`InventoryItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `convenience_store_management`.`InventoryItem` ;

CREATE TABLE IF NOT EXISTS `convenience_store_management`.`InventoryItem` (
  `id` INT NOT NULL,
  `expiration_date` DATETIME NOT NULL,
  `order_quantity` INT NOT NULL,
  `stock` INT NOT NULL,
  `ASP_id` INT NOT NULL,
  INDEX `fk_InventoryItem_actual_sale_product1_idx` (`ASP_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_InventoryItem_actual_sale_product1`
    FOREIGN KEY (`ASP_id`)
    REFERENCES `convenience_store_management`.`ActualSaleProduct` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `InventoryItem` VALUES
(1, '2025-06-18 07:29:11', 100, 30, 1),
(2, '2025-06-03 07:29:11', 80, 20, 2),
(3, '2025-07-03 07:29:11', 120, 24, 3),
(4, '2025-05-29 07:29:11', 60, 10, 4),
(5, '2025-06-08 07:29:11', 90, 45, 5);


-- -----------------------------------------------------
-- Table `convenience_store_management`.`SaleItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `convenience_store_management`.`SaleItem` ;

CREATE TABLE IF NOT EXISTS `convenience_store_management`.`SaleItem` (
  `InventoryItem_id` INT NOT NULL,
  `Sales_id` INT NOT NULL,
  `amount` INT NOT NULL,
  `price` INT NOT NULL,
  `discount_amount` INT NOT NULL,
  `total_price` INT NOT NULL,
  `Event_id` INT NULL,
  INDEX `fk_SaleItem_Sales1_idx` (`Sales_id` ASC) VISIBLE,
  PRIMARY KEY (`InventoryItem_id`, `Sales_id`),
  INDEX `fk_SaleItem_event1_idx` (`Event_id` ASC) VISIBLE,
  INDEX `fk_SaleItem_InventoryItem1_idx` (`InventoryItem_id` ASC) VISIBLE,
  CONSTRAINT `fk_SaleItem_Sales1`
    FOREIGN KEY (`Sales_id`)
    REFERENCES `convenience_store_management`.`Sales` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SaleItem_event1`
    FOREIGN KEY (`Event_id`)
    REFERENCES `convenience_store_management`.`Event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SaleItem_InventoryItem1`
    FOREIGN KEY (`InventoryItem_id`)
    REFERENCES `convenience_store_management`.`InventoryItem` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `SaleItem` VALUES
(1, 1, 2, 1500, 1500, 1500, 1),
(2, 2, 1, 2000, 0, 2000, 2),
(3, 3, 2, 1200, 120, 2280, 3),
(4, 5, 1, 4000, 0, 4000, NULL),
(5, 4, 2, 1800, 0, 3400, NULL);


-- -----------------------------------------------------
-- Table `convenience_store_management`.`EventByActualSaleProduct`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `convenience_store_management`.`EventByActualSaleProduct` ;

CREATE TABLE IF NOT EXISTS `convenience_store_management`.`EventByActualSaleProduct` (
  `Evt_id` INT NOT NULL,
  `ASP_id` INT NOT NULL,
  PRIMARY KEY (`Evt_id`, `ASP_id`),
  INDEX `fk_Event_has_ActualSaleProduct_ActualSaleProduct1_idx` (`ASP_id` ASC) VISIBLE,
  INDEX `fk_Event_has_ActualSaleProduct_Event1_idx` (`Evt_id` ASC) VISIBLE,
  CONSTRAINT `fk_Event_has_ActualSaleProduct_Event1`
    FOREIGN KEY (`Evt_id`)
    REFERENCES `convenience_store_management`.`Event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_has_ActualSaleProduct_ActualSaleProduct1`
    FOREIGN KEY (`ASP_id`)
    REFERENCES `convenience_store_management`.`ActualSaleProduct` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `EventByActualSaleProduct` VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 5),
(5, 4);

-- SaleItem에 삽입되면 자동으로 관련 Sales의 총합이 업데이트(트리거)
DELIMITER //

CREATE TRIGGER trg_update_total_amount
AFTER INSERT ON SaleItem
FOR EACH ROW
BEGIN
  UPDATE Sales
  SET totalAmount = totalAmount + NEW.total_price
  WHERE id = NEW.Sales_id;
END //

DELIMITER ;

-- 재고 감소 및 판매 등록(저장 프로시저)
DELIMITER //

CREATE PROCEDURE RecordSale(
  IN p_InventoryItem_id INT,       -- 재고 항목 ID
  IN p_Sales_id INT,               -- 판매 ID
  IN p_amount INT,                 -- 수량
  IN p_price INT,                  -- 단가
  IN p_Event_id INT,               -- 적용 이벤트 ID
  OUT p_total_price INT            -- 결과 총금액 반환
)
BEGIN
  DECLARE v_total_price INT;
  DECLARE v_exists INT;
  DECLARE v_event_satisfaction_conditions INT;
  DECLARE v_discount_rate INT;
  DECLARE v_discount_amount INT DEFAULT 0;
  DECLARE v_payment_method ENUM('현금', '카드');
  DECLARE v_sale_exists INT;
  
  -- [0] Sales 테이블에 존재하는지 확인
  SELECT COUNT(*) INTO v_sale_exists FROM Sales WHERE id = p_Sales_id;

  -- 없으면 기본값으로 Sales 생성 (카드 결제 가정, 필요 시 수정 가능)
  IF v_sale_exists = 0 THEN
    INSERT INTO Sales (id, date, totalAmount, payment_method)
    VALUES (p_Sales_id, NOW(), 0, '카드');
  END IF;

  -- [1] 결제 수단 조회
  SELECT payment_method INTO v_payment_method
  FROM Sales
  WHERE id = p_Sales_id;

  -- [2] 이벤트 정보 조회
  SELECT event_satisfaction_conditions, discount_rate
  INTO v_event_satisfaction_conditions, v_discount_rate
  FROM Event
  WHERE id = p_Event_id;

  -- [3] 할인 계산
  IF v_event_satisfaction_conditions IS NOT NULL THEN
    -- 증정형 이벤트
    SET v_discount_amount = FLOOR(p_amount / (v_event_satisfaction_conditions + 1)) * p_price;

  ELSEIF v_discount_rate IS NOT NULL AND v_payment_method = '카드' THEN
    -- 할인율 적용 이벤트 (카드 결제일 경우만)
    SET v_discount_amount = (p_price * p_amount) - CalculateDiscountedPrice(p_price * p_amount, v_discount_rate);
  END IF;

  -- [4] 최종 결제 금액 계산
  SET v_total_price = (p_price * p_amount) - v_discount_amount;

  -- [5] 중복 체크
  SELECT COUNT(*) INTO v_exists
  FROM SaleItem
  WHERE InventoryItem_id = p_InventoryItem_id AND Sales_id = p_Sales_id;

  IF v_exists = 0 THEN
    -- [6] 재고 감소
    UPDATE InventoryItem
    SET stock = stock - p_amount
    WHERE id = p_InventoryItem_id;

    -- [7] 판매 항목 삽입
    INSERT INTO SaleItem (
      InventoryItem_id, Sales_id, amount, price,
      discount_amount, total_price, Event_id
    ) VALUES (
      p_InventoryItem_id, p_Sales_id, p_amount, p_price,
      v_discount_amount, v_total_price, p_Event_id
    );

    -- [8] 판매 총액 갱신
    UPDATE Sales
    SET totalAmount = totalAmount + v_total_price
    WHERE id = p_Sales_id;

    SET p_total_price = v_total_price;

  ELSE
    -- [9] 중복된 판매 항목 경고
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'SaleItem already exists for given InventoryItem_id and Sales_id';
  END IF;

END //

DELIMITER ;

-- 할인율 적용 가격 반환(함수)
DELIMITER //

CREATE FUNCTION CalculateDiscountedPrice(price INT, discount_rate INT)
RETURNS INT
DETERMINISTIC
BEGIN
  IF discount_rate IS NULL THEN
    RETURN price;
  ELSE
    RETURN price - FLOOR(price * discount_rate / 100);
  END IF;
END //

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;