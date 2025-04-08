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
-- Table `convenience_store_management`.`classification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `convenience_store_management`.`classification` (
  `catalog_number` INT NOT NULL,
  `catalog_name` VARCHAR(20) NULL,
  PRIMARY KEY (`catalog_number`),
  UNIQUE INDEX `catalog_name_UNIQUE` (`catalog_name` ASC) VISIBLE)
ENGINE = InnoDB;

INSERT INTO `classification` (
`catalog_number`, 
`catalog_name`
)
VALUES
    (1,'과자'),
    (2,'음료'),
    (3,'생필품'),
    (4,'주류'),
    (5,'즉석 식품'),
    (6,'아이스크림'),
    (7,'라면'),
    (8,'유제품');



-- -----------------------------------------------------
-- Table `convenience_store_management`.`event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `convenience_store_management`.`event` (
  `event_id` INT NOT NULL,
  `event_name` VARCHAR(20) NULL,
  PRIMARY KEY (`event_id`))
ENGINE = InnoDB;

INSERT INTO `event` (
`event_id`, 
`event_name`
)
VALUES
    (1, '1+1'),
    (2, '2+1'),
    (3, '증정 행사'),
    (4, '할인 행사'),
    (5, '행사 없음');

-- -----------------------------------------------------
-- Table `convenience_store_management`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `convenience_store_management`.`product` (
  `product_id` INT NOT NULL,
  `product_name` VARCHAR(30) NOT NULL,
  `product_price` INT CHECK (`product_price` >= 0) NOT NULL,
  `classification_number` INT NOT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE INDEX `product_name_UNIQUE` (`product_name` ASC) VISIBLE,
  INDEX `fk_product_classification1_idx` (`classification_number` ASC) VISIBLE,
  CONSTRAINT `fk_product_classification1`
    FOREIGN KEY (`classification_number`)
    REFERENCES `convenience_store_management`.`classification` (`catalog_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `product` (
`product_id`,
`product_name`,
`classification_number`,
`product_price`
 )
VALUES
	-- 과자
    (1 , '먹태깡' , 1,1600),
    (2 , '자갈치', 1,1600),
    (3 , '알새우칩', 1,1500),
    (4 , '오레오', 1,1600),
    (5 , '프링글스' , 1, 2300),
    -- 음료
    (6 , '코카콜라' , 2,2400),
    (7 , '펩시콜라' , 2, 1800),
    (8 , '포카리스웨트' , 2, 1700),
    (9 , '초록매실' , 2, 2100),
    (10 , '레쓰비 그란데' , 2, 1600),
    -- 생필품
    (11 , '페리오 칫솔', 3, 1500),
    (12 , '2080 치약' , 3, 3000),
    (13 , '유한락스 1L', 3, 1000),
    (14 , '다우니 세제' , 3, 23500),
    (15 , '자연퐁 세제', 3, 6600),
    -- 주류
    (16 , '참이슬' , 4, 1700),
    (17 , '복분자' , 4, 8500),
    (18 , '카스 500', 4, 2300),
    (19 , '스카치 블루 12년', 4, 34500),
    (20 , '목포 막걸리', 4, 1600),
    -- 즉석 식품
    (21 , '참치마요 삼각김밥', 5, 1200),
    (22 , '불고기 삼각김밥', 5, 1300),
    (23 , '닭가슴살 핫바', 5, 2000),
    (24 , '치즈 핫바', 5, 2200),
    (25 , '에그마요 샌드위치', 5, 2800),
    -- 아이스크림
    (26, '월드콘', 6, 1300),
    (27, '붕어싸만코', 6, 1300),
    (28, '스크류바', 6, 600),
    (29, '비비빅', 6, 600),
    (30, '더위사냥', 6, 900),
    -- 라면
    (31, '신라면 컵', 7, 1300),
    (32, '진라면 매운맛', 7, 1100),
    (33, '불닭볶음면', 7, 1500),
    (34, '짜파게티', 7, 1300),
    (35, '육개장 사발면', 7, 1100),
    -- 유제품
    (36, '서울우유 200ml', 8, 1100),
    (37, '바나나맛 우유', 8, 1400),
    (38, '초코우유', 8, 1300),
    (39, '요플레 플레인', 8, 1200),
    (40, '상하치즈 슬라이스', 8, 2500);


-- -----------------------------------------------------
-- Table `convenience_store_management`.`actual_sale_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `convenience_store_management`.`actual_sale_product` (
  `actual_sale_product_id` INT NOT NULL,
  `actual_sale_product_name` VARCHAR(30) NOT NULL,
  `actual_sale_product_price` INT CHECK (`actual_sale_product_price` >= 0) NOT NULL,
  `actual_sale_product_event_period` DATETIME NULL,
  `actual_sale_product_stock` INT NULL,
  `actual_sale_product_expriation_date` DATETIME NULL,
  `classification_number` INT NOT NULL,
  `event_id` INT NOT NULL,
  PRIMARY KEY (`actual_sale_product_id`),
  INDEX `fk_actual_sale_product_classification1_idx` (`classification_number` ASC) VISIBLE,
  INDEX `fk_actual_sale_product_event1_idx` (`event_id` ASC) VISIBLE,
  CONSTRAINT `fk_actual_sale_product_classification1`
    FOREIGN KEY (`classification_number`)
    REFERENCES `convenience_store_management`.`classification` (`catalog_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_actual_sale_product_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `convenience_store_management`.`event` (`event_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `actual_sale_product` (
    `actual_sale_product_id`,
    `actual_sale_product_name`,
    `actual_sale_product_price`,
    `actual_sale_product_event_period`,
    `actual_sale_product_stock`,
    `actual_sale_product_expriation_date`,
    `classification_number`,
    `event_id`
)
VALUES
    -- 과자
    (1, '먹태깡', 1600, '2025-04-01', 50, '2025-12-31', 1, 2),
    (2, '자갈치', 1600, '2025-05-01', 40, '2025-11-20', 1, 1),
    (3, '알새우칩', 1500, NULL, 30, '2025-11-30', 1, 5),
    (4, '오레오', 1600, '2025-05-03', 60, '2025-09-04', 1, 3),
    (5, '프링글스', 2300, NULL, 20, '2025-12-15', 1, 5),
    
    -- 음료 
    (6, '코카콜라', 2400, '2025-05-05', 45, '2025-08-31', 2, 1),
    (7, '펩시콜라', 1800, NULL, 35, '2025-11-05', 2, 5),
    (8, '포카리스웨트', 1700, '2025-05-07', 25, '2025-09-15', 2, 2),
    (9, '초록매실', 2100, NULL, 30, '2025-12-01', 2, 5),
    (10, '레쓰비 그란데', 1600, NULL, 40, '2025-09-01', 2, 4),
    
    -- 생필품 
    (11, '페리오 칫솔', 1500, NULL, 60, NULL, 3, 5),
    (12, '2080 치약', 3000, NULL, 45, '2026-02-24', 3, 5),
    (13, '유한락스 1L', 1000, '2025-05-10', 35, '2026-05-05', 3, 3),
    (14, '다우니 세제', 23500, NULL, 25, '2026-06-12', 3, 5),
    (15, '자연퐁 세제', 6600, NULL, 40, '2026-04-15', 3, 5),
    
    -- 주류 
    (16, '참이슬', 1700, NULL, 100, NULL, 4, 1),
    (17, '복분자', 8500, NULL, 30, NULL, 4, 5),
    (18, '카스 500', 2300, NULL, 80, NULL, 4, 5),
    (19, '스카치 블루 12년', 34500, NULL, 10, NULL, 4, 5),
    (20, '목포 막걸리', 1600, NULL, 60, '2025-04-10', 4, 2),
    
    -- 즉석식품
    (21, '참치마요 삼각김밥', 1200, '2025-04-01', 70, '2025-04-08', 5, 2),
    (22, '불고기 삼각김밥', 1300, '2025-04-01', 65, '2025-04-08', 5, 1),
    (23, '닭가슴살 핫바', 2000, NULL, 40, '2025-04-23', 5, 5),
    (24, '치즈 핫바', 2200, '2025-04-05', 40, '2025-04-25', 5, 3),
    (25, '에그마요 샌드위치', 2800, NULL, 30, '2025-04-07', 5, 5),
    
    -- 아이스크림
    (26, '월드콘', 1300, NULL, 55, '2025-10-13', 6, 5),
    (27, '붕어싸만코', 1300, NULL, 60, '2025-03-25', 6, 5),
    (28, '스크류바', 600, '2025-05-15', 80, '2025-09-01', 6, 2),
    (29, '비비빅', 600, NULL, 75, '2025-12-01', 6, 5),
    (30, '더위사냥', 900, '2025-05-20', 90, '2025-10-15', 6, 1),
    
    -- 라면 
    (31, '신라면 컵', 1300, '2025-04-01', 60, '2025-10-13', 7, 2),
    (32, '진라면 매운맛', 1100, NULL, 50, '2025-05-05', 7, 5),
    (33, '불닭볶음면', 1500, NULL, 55, '2025-08-23', 7, 5),
    (34, '짜파게티', 1300, NULL, 45, '2025-11-12', 7, 5),
    (35, '육개장 사발면', 1100, '2025-04-01', 70, '2025-8-03', 7, 1),
    
    -- 유제품 
    (36, '서울우유 200ml', 1100, NULL , 80, '2025-04-15', 8, 1),
    (37, '바나나맛 우유', 1400, '2025-04-15', 70, '2025-04-15', 8, 5),
    (38, '초코우유', 1300, NULL, 65, '2025-04-15', 8, 5),
    (39, '요플레 플레인', 1200, NULL, 60, '2025-04-12', 8, 5),
    (40, '상하치즈 슬라이스', 2500, NULL, 50, '2025-07-01', 8, 5);


-- -----------------------------------------------------
-- Table `convenience_store_management`.`sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `convenience_store_management`.`sales` (
  `sales_id` INT NOT NULL,
  `sales_date` DATE NULL,
  `sales_time` DATETIME NULL,
  `sales_count` INT CHECK (`sales_count` >= 0) NOT NULL,
  `sales_revenue` INT NULL,
  `sales_payment_method` ENUM('현금', '카드') NOT NULL,
  `actual_sale_product_id` INT NOT NULL,
  PRIMARY KEY (`sales_id`),
  INDEX `fk_sales_actual_sale_product1_idx` (`actual_sale_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_sales_actual_sale_product1`
    FOREIGN KEY (`actual_sale_product_id`)
    REFERENCES `convenience_store_management`.`actual_sale_product` (`actual_sale_product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `sales` (
    `sales_id`,
    `sales_date`,
    `sales_time`,
    `sales_count`,
    `sales_revenue`,
    `sales_payment_method`,
    `actual_sale_product_id`
)
VALUES
    (1, '2025-04-01', '2025-04-01 09:30:00', 2, 3200, '현금', 1),
    (2, '2025-04-01', '2025-04-01 13:15:00', 1, 1300, '카드', 26),
    (3, '2025-04-02', '2025-04-02 11:05:00', 3, 3900, '현금', 31),
    (4, '2025-04-02', '2025-04-02 18:45:00', 1, 1600, '카드', 10),
    (5, '2025-04-03', '2025-04-03 08:50:00', 2, 2400, '카드', 36),
    (6, '2025-04-03', '2025-04-03 15:30:00', 1, 8500, '현금', 17),
    (7, '2025-04-04', '2025-04-04 19:10:00', 1, 2300, '카드', 5),
    (8, '2025-04-04', '2025-04-04 12:20:00', 2, 2600, '현금', 35),
    (9, '2025-04-05', '2025-04-05 10:05:00', 1, 1200, '현금', 21),
    (10, '2025-04-05', '2025-04-05 17:55:00', 1, 34500, '카드', 19);


-- -----------------------------------------------------
-- Table `convenience_store_management`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `convenience_store_management`.`order` (
  `order_id` INT NOT NULL,
  `order_date` DATETIME NOT NULL,
  `order_quantity` INT CHECK (`order_quantity` >= 0) NOT NULL,
  `order_price` INT CHECK (`order_price` >= 0) NOT NULL,
  `actual_sale_product_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_order_actual_sale_product1_idx` (`actual_sale_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_actual_sale_product1`
    FOREIGN KEY (`actual_sale_product_id`)
    REFERENCES `convenience_store_management`.`actual_sale_product` (`actual_sale_product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `order` (
    `order_id`,
    `order_date`,
    `order_quantity`,
    `order_price`,
    `actual_sale_product_id`
)
VALUES
    (1, '2025-04-01 08:00:00', 30, 48000, 1),   -- 먹태깡 (1600 × 30)
    (2, '2025-04-02 09:00:00', 50, 65000, 5),   -- 프링글스 (2300 × 50)
    (3, '2025-04-03 10:30:00', 40, 68000, 6),   -- 코카콜라 (1700 × 40)
    (4, '2025-04-04 11:15:00', 20, 46000, 14),  -- 다우니 세제 (23500 × 2)
    (5, '2025-04-05 15:45:00', 100, 130000, 26); -- 월드콘 (1300 × 100)


-- -----------------------------------------------------
-- Table `convenience_store_management`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `convenience_store_management`.`employee` (
  `employee_id` INT NOT NULL,
  `employee_name` VARCHAR(20) NOT NULL,
  `employee_phone_number` VARCHAR(20) NOT NULL,
  `employee_rank` VARCHAR(10) NOT NULL,
  `employee_salary` INT NULL,
  `employee_work_time` INT NULL,
  `employee_work_evaluation` VARCHAR(50) NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE INDEX `employee_phone_number_UNIQUE` (`employee_phone_number` ASC) VISIBLE)
ENGINE = InnoDB;

INSERT INTO `employee` (
  `employee_id`, 
  `employee_name`, 
  `employee_phone_number`, 
  `employee_rank`,
  `employee_salary`, 
  `employee_work_time`, 
  `employee_work_evaluation`
)
VALUES
  (1, '오성환', '010-1234-5678', '매니저', 3000000, 4, '성실함'),
  (2, '최영수', '010-9308-5432', '알바', 1200000, 8, '근무태도 양호'),
  (3, '양동민', '010-1122-3344', '알바', 1200000, 8, '시간 엄수'),
  (4, '이호연', '010-5566-7788', '점장', 3500000, 4, '매우 우수');


-- -----------------------------------------------------
-- Table `convenience_store_management`.`equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `convenience_store_management`.`equipment` (
  `equipment_id` INT NOT NULL,
  `equipment_date` DATETIME NULL,
  `equipment_name` VARCHAR(20) NOT NULL,
  `equipment_count` INT NOT NULL DEFAULT 1,
  `equipment_note` VARCHAR(50) NULL,
  `manager_id` INT NOT NULL,
  PRIMARY KEY (`equipment_id`),
  INDEX `fk_equipment_employee1_idx` (`manager_id` ASC) VISIBLE,
  CONSTRAINT `fk_equipment_employee1`
    FOREIGN KEY (`manager_id`)
    REFERENCES `convenience_store_management`.`employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


INSERT INTO `equipment` (
  `equipment_id`, 
  `equipment_name`, 
  `equipment_note`, 
  `equipment_date`, 
  `manager_id`
)
VALUES
  (1, 'POS 기기', '정상', '2023-06-10', 1),
  (2, '냉장고', '고장', '2022-12-20', 2),
  (3, 'CCTV', '정상', '2021-11-01', 3),
  (4, '전자레인지', '정상', '2024-03-08', 4),
  (5, '에어컨', '점검필요', '2020-07-22', 1);

-- -----------------------------------------------------
-- Table `convenience_store_management`.`monthly_profit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `convenience_store_management`.`monthly_profit` (
  `monthly_profit_year_month` VARCHAR(10) NOT NULL,
  `monthly_profit_profit` INT CHECK (`monthly_profit_profit` >= 0) NULL,
  `monthly_profit_order_cost` INT CHECK (`monthly_profit_order_cost` >= 0) NULL,
  `monthly_profit_laber_cost` INT CHECK (`monthly_profit_laber_cost` >= 0) NULL,
  `monthly_profit_net_profit` INT CHECK (`monthly_profit_net_profit` >= 0) NULL,
  PRIMARY KEY (`monthly_profit_year_month`))
ENGINE = InnoDB;


INSERT INTO `monthly_profit` (
  `monthly_profit_year_month`,
  `monthly_profit_profit`,
  `monthly_profit_order_cost`,
  `monthly_profit_laber_cost`,
  `monthly_profit_net_profit`
)
VALUES
  ('2025-01', 4500000, 2240000, 960000, 1300000),
  ('2025-02', 4800000, 2450000, 1050000, 1300000),
  ('2025-03', 5200000, 2590000, 1110000, 1500000),
  ('2025-04', 1300000, 560000, 240000, 500000);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
