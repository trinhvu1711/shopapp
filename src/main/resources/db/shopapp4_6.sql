/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 100432 (10.4.32-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : shopapp

 Target Server Type    : MySQL
 Target Server Version : 100432 (10.4.32-MariaDB)
 File Encoding         : 65001

 Date: 04/06/2024 13:47:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `list_cart_id` int NULL DEFAULT NULL,
  `product_id` int NULL DEFAULT NULL,
  `price` float NULL DEFAULT NULL,
  `number_of_products` int NULL DEFAULT NULL,
  `total_money` float NULL DEFAULT NULL,
  `id_product_variant` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `list_cart_id`(`list_cart_id` ASC) USING BTREE,
  INDEX `product_id`(`product_id` ASC) USING BTREE,
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`list_cart_id`) REFERENCES `list_cart` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 67 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES (1, NULL, 1, 123.123, 12, 12, 5);
INSERT INTO `cart` VALUES (3, 1, 1, 123.123, 12, 12, 5);
INSERT INTO `cart` VALUES (4, 1, 1, 123.123, 111, 13666, 5);
INSERT INTO `cart` VALUES (46, 12, 1, 123.123, 13, 1600, 5);
INSERT INTO `cart` VALUES (60, 16, 1, 35490000, 2, 70980000, 11);

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL DEFAULT '',
  `image_url` varchar(300) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT NULL,
  `slug` varchar(100) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, 'Ipad Phone & Tablets', 'product-cat-1.webp', 'phone');
INSERT INTO `categories` VALUES (2, 'Planer & Virtual', 'product-cat-2.webp', 'electronics');
INSERT INTO `categories` VALUES (3, 'Wireless & Watches', 'product-cat-3.webp', 'watches');
INSERT INTO `categories` VALUES (4, 'Computers Monitor & Laptop', 'product-cat-4.webp', 'computers');
INSERT INTO `categories` VALUES (5, 'Exercise Bike & Shaver Clean', 'product-cat-5.webp', 'exercise');
INSERT INTO `categories` VALUES (6, 'Spinning Reel & Kettle', 'product-cat-6.webp', 'fishing');
INSERT INTO `categories` VALUES (7, 'Camera Bluetooth & Headset', 'product-cat-7.webp', NULL);

-- ----------------------------
-- Table structure for coupon_conditions
-- ----------------------------
DROP TABLE IF EXISTS `coupon_conditions`;
CREATE TABLE `coupon_conditions`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `coupon_id` int NOT NULL,
  `attribute` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `operator` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `discount_amount` decimal(5, 2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coupon_conditions
-- ----------------------------
INSERT INTO `coupon_conditions` VALUES (1, 1, 'minimum_amount', '>', '100', 10.00);
INSERT INTO `coupon_conditions` VALUES (2, 1, 'applicable_date', 'BETWEEN', '2024-06-04', 5.00);
INSERT INTO `coupon_conditions` VALUES (3, 2, 'minimum_amount', '>', '200', 20.00);

-- ----------------------------
-- Table structure for coupons
-- ----------------------------
DROP TABLE IF EXISTS `coupons`;
CREATE TABLE `coupons`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coupons
-- ----------------------------
INSERT INTO `coupons` VALUES (1, 'HEAVEN', 1);
INSERT INTO `coupons` VALUES (2, 'DISCOUNT20', 1);

-- ----------------------------
-- Table structure for list_cart
-- ----------------------------
DROP TABLE IF EXISTS `list_cart`;
CREATE TABLE `list_cart`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `active` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `list_cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of list_cart
-- ----------------------------
INSERT INTO `list_cart` VALUES (1, 2, 1);
INSERT INTO `list_cart` VALUES (3, 2, 1);
INSERT INTO `list_cart` VALUES (4, 2, 1);
INSERT INTO `list_cart` VALUES (6, 0, 1);
INSERT INTO `list_cart` VALUES (7, 0, 1);
INSERT INTO `list_cart` VALUES (8, 0, 1);
INSERT INTO `list_cart` VALUES (9, 0, 1);
INSERT INTO `list_cart` VALUES (10, 0, 1);
INSERT INTO `list_cart` VALUES (11, 0, 0);
INSERT INTO `list_cart` VALUES (12, 0, 1);
INSERT INTO `list_cart` VALUES (13, 0, 1);
INSERT INTO `list_cart` VALUES (14, 0, 1);
INSERT INTO `list_cart` VALUES (15, 0, 1);
INSERT INTO `list_cart` VALUES (16, 0, 1);
INSERT INTO `list_cart` VALUES (17, 7, 1);
INSERT INTO `list_cart` VALUES (18, 0, 1);

-- ----------------------------
-- Table structure for options
-- ----------------------------
DROP TABLE IF EXISTS `options`;
CREATE TABLE `options`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT NULL,
  `value` varchar(100) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of options
-- ----------------------------
INSERT INTO `options` VALUES (1, 'Color', 'Red');
INSERT INTO `options` VALUES (2, 'Size', 'S');
INSERT INTO `options` VALUES (6, 'Color', 'Blue');
INSERT INTO `options` VALUES (7, 'Size', 'L');
INSERT INTO `options` VALUES (8, 'Màu', 'Vàng');
INSERT INTO `options` VALUES (9, 'Màu', 'Xám');
INSERT INTO `options` VALUES (10, 'Màu', 'Đen');
INSERT INTO `options` VALUES (11, 'Màu', 'Tím');
INSERT INTO `options` VALUES (12, 'Cấu hình', '12GB 256GB');
INSERT INTO `options` VALUES (13, 'Cấu hình', '12GB 512GB');
INSERT INTO `options` VALUES (14, 'Cấu hình', '12GB 1TB');

-- ----------------------------
-- Table structure for order_details
-- ----------------------------
DROP TABLE IF EXISTS `order_details`;
CREATE TABLE `order_details`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NULL DEFAULT NULL,
  `product_id` int NULL DEFAULT NULL,
  `price` float NULL DEFAULT NULL,
  `number_of_products` int NULL DEFAULT NULL,
  `total_money` float NULL DEFAULT NULL,
  `id_product_variant` varchar(20) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT '',
  `coupon_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id`(`order_id` ASC) USING BTREE,
  INDEX `product_id`(`product_id` ASC) USING BTREE,
  INDEX `fk_orders_counpon`(`coupon_id` ASC) USING BTREE,
  CONSTRAINT `fk_orders_counpon` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8 COLLATE = utf8_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_details
-- ----------------------------
INSERT INTO `order_details` VALUES (7, 4, 123, 2342, 2, 13191, '5', NULL);
INSERT INTO `order_details` VALUES (8, 4, 123, 2342, 2, 13191, '5', NULL);
INSERT INTO `order_details` VALUES (9, 4, 1, 2342, 2, 13191, '5', NULL);
INSERT INTO `order_details` VALUES (10, 7, 1, 15.2, 2, 30, '6', NULL);
INSERT INTO `order_details` VALUES (11, 7, 1, 19.2, 1, 19, '5', NULL);
INSERT INTO `order_details` VALUES (12, 8, 1, 19.2, 1, 19, '5', NULL);
INSERT INTO `order_details` VALUES (13, 8, 1, 15.2, 2, 30, '6', NULL);
INSERT INTO `order_details` VALUES (14, 9, 1, 15.2, 1, 15, '6', NULL);
INSERT INTO `order_details` VALUES (15, 10, 1, 15.2, 1, 15, '6', NULL);
INSERT INTO `order_details` VALUES (16, 11, 1, 15.2, 1, 15, '6', NULL);
INSERT INTO `order_details` VALUES (17, 14, 1, 15.2, 1, 15, '6', NULL);
INSERT INTO `order_details` VALUES (18, 15, 1, 15.2, 1, 15, '6', NULL);
INSERT INTO `order_details` VALUES (19, 16, 1, 15.2, 1, 15, '6', NULL);
INSERT INTO `order_details` VALUES (20, 18, 1, 15.2, 1, 15, '6', NULL);
INSERT INTO `order_details` VALUES (21, 19, 1, 15.2, 1, 15, '6', NULL);
INSERT INTO `order_details` VALUES (22, 20, 1, 15.2, 1, 15, '6', NULL);
INSERT INTO `order_details` VALUES (23, 21, 1, 15.2, 1, 15, '6', NULL);
INSERT INTO `order_details` VALUES (24, 22, 1, 15.2, 1, 15, '6', NULL);
INSERT INTO `order_details` VALUES (25, 23, 1, 15.2, 1, 15, '6', NULL);
INSERT INTO `order_details` VALUES (26, 24, 1, 19.2, 3, 57, '5', NULL);
INSERT INTO `order_details` VALUES (27, 24, 1, 15.2, 2, 30, '6', NULL);
INSERT INTO `order_details` VALUES (28, 32, 1, 15.2, 3, 45, '6', NULL);
INSERT INTO `order_details` VALUES (29, 32, 1, 19.2, 7, 134, '5', NULL);
INSERT INTO `order_details` VALUES (30, 33, 1, 15.2, 2, 30, '6', NULL);
INSERT INTO `order_details` VALUES (31, 33, 1, 19.2, 1, 19, '5', NULL);
INSERT INTO `order_details` VALUES (32, 34, 1, 19.2, 1, 19, '5', NULL);
INSERT INTO `order_details` VALUES (33, 35, 1, 19.2, 1, 19, '5', NULL);
INSERT INTO `order_details` VALUES (34, 36, 1, 15.2, 1, 15, '6', NULL);
INSERT INTO `order_details` VALUES (35, 36, 1, 19.2, 1, 19, '5', NULL);
INSERT INTO `order_details` VALUES (36, 37, 1, 15.2, 1, 15, '6', NULL);
INSERT INTO `order_details` VALUES (37, 38, 1, 42490000, 1, 42490000, '15', NULL);
INSERT INTO `order_details` VALUES (38, 39, 1, 31990000, 1, 31990000, '9', NULL);
INSERT INTO `order_details` VALUES (39, 39, 1, 31990000, 2, 63980000, '7', NULL);
INSERT INTO `order_details` VALUES (40, 40, 1, 35490000, 1, 35490000, '12', NULL);
INSERT INTO `order_details` VALUES (41, 40, 1, 31990000, 2, 63980000, '7', NULL);
INSERT INTO `order_details` VALUES (42, 41, 1, 35490000, 3, 106470000, '12', NULL);
INSERT INTO `order_details` VALUES (43, 42, 1, 31990000, 1, 31990000, '7', NULL);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `fullname` varchar(100) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT '',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT '',
  `phone_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `note` varchar(100) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT '',
  `order_date` datetime NULL DEFAULT current_timestamp,
  `status` enum('pending','processing','shipped','delivered','cancelled') CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT NULL,
  `total_money` float NULL DEFAULT NULL,
  `shipping_method` varchar(100) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT NULL,
  `shipping_address` varchar(200) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT NULL,
  `shipping_date` date NULL DEFAULT NULL,
  `tracking_number` varchar(100) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT NULL,
  `payment_method` varchar(100) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT NULL,
  `active` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8 COLLATE = utf8_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, 1, 'trinh long vu 2', 'longvu2@gmail.com', '131983712', 'address abc', 'note expample', '2024-04-05 08:29:55', 'pending', 123123, 'express', '1231231', '2023-04-05', NULL, 'cod', 0);
INSERT INTO `orders` VALUES (2, 1, 'trinh long vu', 'longvu@gmail.com', '13198371', 'address abc', 'note expample', '2024-04-05 08:33:24', 'pending', 123123, 'express', NULL, '2024-04-05', NULL, 'cod', 1);
INSERT INTO `orders` VALUES (3, 1, 'trinh long vu', 'longvu@gmail.com', '13198371', 'address abc', 'note expample', '2024-04-10 08:30:38', 'pending', 123123, 'express', NULL, '2024-04-10', NULL, 'cod', 0);
INSERT INTO `orders` VALUES (4, 1, 'trinh long vu', 'longvu@gmail.com', '13198371', 'address abc', 'note expample', '2024-05-17 08:47:00', 'pending', 123123, 'express', NULL, '2024-05-17', NULL, 'cod', 1);
INSERT INTO `orders` VALUES (5, 0, 'trinh long vu', 'longvu@gmail.com', '13198371', 'address abc', 'note expample', '2024-05-17 09:10:50', 'pending', 123123, 'express', NULL, '2024-05-17', NULL, 'cod', 1);
INSERT INTO `orders` VALUES (6, 1, 'trinh long vu update 333', 'longvu2@gmail.com', '131983712', 'address abc', 'note expample', '2024-05-17 13:31:27', 'pending', 123123, 'express', '1231231', '2023-04-05', NULL, 'cod', 1);
INSERT INTO `orders` VALUES (7, 0, 'Guess3123', '131123123', '312312312312', '12312312', '', '2024-05-17 13:36:53', 'pending', 10049, 'Bình Thường', NULL, '2024-05-17', '2d7bc0a28df34875a5540c8c', '', 1);
INSERT INTO `orders` VALUES (8, 0, 'Guess', 'longvu17112002@gmail.com', '23123123', '1231231231', '', '2024-05-17 13:44:54', 'pending', 10049, 'Bình Thường', NULL, '2024-05-17', NULL, '', 1);
INSERT INTO `orders` VALUES (9, 0, 'Guess', 'longvu17112002@gmail.com', '123123123123', '3123123123', '', '2024-05-17 14:08:37', 'pending', 10015, 'Bình Thường', NULL, '2024-05-17', NULL, '', 1);
INSERT INTO `orders` VALUES (10, 0, 'Guesssdfsdfsd', 'sdfsdfsdf', '3123123123', '123123123123', '', '2024-05-17 14:12:58', 'pending', 10015, 'Bình Thường', NULL, '2024-05-17', NULL, '', 1);
INSERT INTO `orders` VALUES (11, 0, 'Guess', 'dfgsdfgf', '4323424123', 'dsfgsdfgdf', '', '2024-05-17 14:14:36', 'pending', 10015, 'Bình Thường', NULL, '2024-05-17', NULL, '', 1);
INSERT INTO `orders` VALUES (12, 0, 'Guess', '', '123123123', '', '', '2024-05-17 14:15:37', 'pending', 10049, 'Bình Thường', NULL, '2024-05-17', NULL, '', 1);
INSERT INTO `orders` VALUES (13, 0, 'Guess', '', '123123123', '', '', '2024-05-17 14:16:16', 'pending', 10049, 'Bình Thường', NULL, '2024-05-17', '12312', '', 1);
INSERT INTO `orders` VALUES (14, 0, 'Guess', 'longvu17112002@gmail.com', '131231231', '`123213', '', '2024-05-17 14:16:31', 'pending', 10015, 'Bình Thường', NULL, '2024-05-17', NULL, '', 1);
INSERT INTO `orders` VALUES (15, 0, 'Guessvb', 'cvbxcvbxcvbx', 'bxcvbxcvbx', 'xcvbxcvbxcv', '', '2024-05-17 14:17:55', 'pending', 10015, 'Bình Thường', NULL, '2024-05-17', NULL, '', 1);
INSERT INTO `orders` VALUES (16, 0, 'GuesszxCzc', 'zxczxc', '123123123123', 'qweqwqwe', '', '2024-05-17 14:19:21', 'pending', 50015, 'Nhanh', NULL, '2024-05-17', NULL, '', 1);
INSERT INTO `orders` VALUES (17, 0, 'Guess', '', '123123123', 'sdasdsa', '', '2024-05-17 14:21:27', 'pending', 10049, 'Bình Thường', NULL, '2024-05-17', 'sdfs12312', '', 1);
INSERT INTO `orders` VALUES (18, 0, 'Guessf', '21231312312', '3123123', '12312312312312312', '', '2024-05-17 14:22:16', 'pending', 10015, 'Bình Thường', NULL, '2024-05-17', NULL, '', 1);
INSERT INTO `orders` VALUES (19, 0, 'Guess', 'sd sdfsdf', '1231231233', '', '', '2024-05-17 14:27:58', 'pending', 10015, 'Bình Thường', 'sdfsdd', '2024-05-17', '488b7a8532434a3c9c2fe5b4', '', 1);
INSERT INTO `orders` VALUES (20, 0, 'Guess', 'longvu17112002@gmail.com', '112312312312', '', '', '2024-05-17 14:36:53', 'cancelled', 10015, 'Bình Thường', '213123', '2024-05-17', 'd289af2b9bc7403e905008fa', '', 1);
INSERT INTO `orders` VALUES (21, 0, 'Guessf', 'sdfsdfas', '12312313', '', '', '2024-05-17 14:46:30', 'pending', 50015, 'Nhanh', 'sdfasdf', '2024-05-17', '3e5460afc2b94fdea6e781b5', 'Ngân Hàng', 1);
INSERT INTO `orders` VALUES (22, 0, 'Guess', 'gasdfgfdg', 'gdfgsdfg', '', '', '2024-05-17 14:50:24', 'pending', 10015, 'Bình Thường', 'dfgdfgdf', '2024-05-17', '2d7bc0a28df34826a5540c8c', 'Visa', 1);
INSERT INTO `orders` VALUES (23, 0, 'Guess', 'last test', '12213123', '', '', '2024-05-17 14:52:48', 'pending', 10015, 'Bình Thường', '123123', '2024-05-17', '996e13efdfcf4c0c9e7a3e7d', 'PayPal', 1);
INSERT INTO `orders` VALUES (24, 0, 'Guess', 'sdfsdfasf', '12312312312312', 'Bình Định', '', '2024-05-20 07:39:47', 'pending', 50087, 'Nhanh', 'sdfsfsfsdf', '2024-05-20', '28473993048441eeb7b449fd', 'Ngân Hàng', 1);
INSERT INTO `orders` VALUES (25, 0, 'Guess', '', '123123123', 'sdasdsa', '', '2024-05-24 10:06:20', 'pending', 10049, 'Bình Thường', NULL, '2024-05-24', 'sdfs12312', '', 1);
INSERT INTO `orders` VALUES (26, 0, 'Guess', '', '123123123', 'sdasdsa', '', '2024-05-24 10:34:22', 'pending', 10049, 'Bình Thường', NULL, '2024-05-24', 'sdfs12312', '', 1);
INSERT INTO `orders` VALUES (27, 0, 'Guess', '', '123123123', 'sdasdsa', '', '2024-05-24 10:34:55', 'pending', 10049, 'Bình Thường', NULL, '2024-05-24', 'sdfs12312', '', 1);
INSERT INTO `orders` VALUES (28, 0, 'Guess', '', '123123123', 'sdasdsa', '', '2024-05-24 11:16:59', 'pending', 10049, 'Bình Thường', NULL, '2024-05-24', 'sdfs12312', '', 1);
INSERT INTO `orders` VALUES (29, 0, 'Guess', '', '123123123', 'sdasdsa', '', '2024-05-24 11:44:16', 'pending', 10049, 'Bình Thường', NULL, '2024-05-24', 'sdfs12312', '', 1);
INSERT INTO `orders` VALUES (30, 0, 'Guess', '', '123123123', 'sdasdsa', '', '2024-05-24 11:45:34', 'pending', 10049, 'Bình Thường', NULL, '2024-05-24', 'sdfs12312', '', 1);
INSERT INTO `orders` VALUES (31, 0, 'Guess', '', '123123123', 'sdasdsa', '', '2024-05-24 11:45:37', 'pending', 10049, 'Bình Thường', NULL, '2024-05-24', 'sdfs12312', '', 1);
INSERT INTO `orders` VALUES (32, 0, 'Guess', 'longvu17112002@gmail.com', '123123123123', '', '', '2024-05-24 11:50:21', 'cancelled', 10906, 'Bình Thường', '1231231231', '2024-05-24', '4bba6b7974c948d9bc56f5fd', 'Visa', 1);
INSERT INTO `orders` VALUES (33, 0, 'Guess', 'longvu17112002@gmail.com', '12312312312', '', '', '2024-05-24 12:39:26', 'cancelled', 50049, 'Nhanh', '3123123123', '2024-05-24', 'b9d5c36d1bb24c2abf6973d4', 'Ngân Hàng', 1);
INSERT INTO `orders` VALUES (34, 7, 'fsdfsdfsdf', 'ki@gmail.com', '123123123123', 'Bình Định', '', '2024-05-28 02:24:40', 'cancelled', 10019, 'Bình Thường', '3123123123', '2024-05-28', 'c0014ff7566b4c0eb476e8f4', 'Visa', 1);
INSERT INTO `orders` VALUES (35, 8, 'Guess', 'ki@gmail.com', '31231231313', '', '', '2024-05-28 12:03:07', 'cancelled', 10019, 'Bình Thường', '123312', '2024-05-28', '4bfbbfc95b2a422ba07ea589', 'Ngân Hàng', 1);
INSERT INTO `orders` VALUES (36, 8, 'test', 'ki@gmail.com', '12312312312', '', '', '2024-05-28 12:04:51', 'cancelled', 10034, 'Bình Thường', '3123123123', '2024-05-28', 'bac4fa8769af475a8b865b8b', 'PayPal', 1);
INSERT INTO `orders` VALUES (37, 0, 'Guess', '20130471@st.hcmuaf.edu.vn', '0346328671', '', '', '2024-05-28 12:20:16', 'cancelled', 10015, 'Bình Thường', '12A, tổ 9, khu phố 1, Linh Trung', '2024-05-28', '107d8ce08c1b4482acaff9d5', 'PayPal', 1);
INSERT INTO `orders` VALUES (38, 8, 'Guess', 'longvu17112002@gmail.com', '123123', '', '', '2024-05-29 11:48:18', 'cancelled', 42500000, 'Bình Thường', '1231231231', '2024-05-29', 'b0e1821db0a343fd8a584da6', 'PayPal', 1);
INSERT INTO `orders` VALUES (39, 0, 'Guess', 'pefeyah117@godsigma.com', '12312312312', '', '', '2024-05-31 09:19:12', 'cancelled', 96020000, 'Nhanh', 'xcvbxcvbxcv', '2024-05-31', '2311e00fe92247c499d09334', 'PayPal', 1);
INSERT INTO `orders` VALUES (40, 8, 'Guess', 'longvu17112002@gmail.com', '12312312312', '', '', '2024-05-31 09:21:43', 'cancelled', 99520000, 'Nhanh', '1231231231', '2024-05-31', '6a0726a02d714c5795982503', 'PayPal', 1);
INSERT INTO `orders` VALUES (41, 7, 'Tài khoản User 1', 'ki@gmail.com', '0346019283', 'Bến Tre', '', '2024-06-04 06:38:45', 'pending', 85186000, 'Bình Thường', 'THIS IS USER', '2024-06-04', 'a91e12fc86a04a2b9781961c', 'Visa', 1);
INSERT INTO `orders` VALUES (42, 7, 'Tài khoản User 1', 'ki@gmail.com', '0346019283', 'Hồ Chí Minh', '', '2024-06-04 06:45:24', 'pending', 27361400, 'Bình Thường', 'THIS IS USER', '2024-06-04', 'e95b6bbeec694c4d9afc9c9f', 'Visa', 1);

-- ----------------------------
-- Table structure for product_images
-- ----------------------------
DROP TABLE IF EXISTS `product_images`;
CREATE TABLE `product_images`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NULL DEFAULT NULL,
  `image_url` varchar(300) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_product_images_product_id`(`product_id` ASC) USING BTREE,
  CONSTRAINT `fk_product_images_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_images
-- ----------------------------
INSERT INTO `product_images` VALUES (9, 1, 'iphone-1.jpg');
INSERT INTO `product_images` VALUES (10, 1, 'iphone-2.jpg');
INSERT INTO `product_images` VALUES (11, 1, 'iphone-3.jpg');
INSERT INTO `product_images` VALUES (12, 1, 'iphone-4.jpg');

-- ----------------------------
-- Table structure for product_variants
-- ----------------------------
DROP TABLE IF EXISTS `product_variants`;
CREATE TABLE `product_variants`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `variant_id` int NULL DEFAULT NULL,
  `product_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `variant_option_id`(`variant_id` ASC) USING BTREE,
  INDEX `product_id`(`product_id` ASC) USING BTREE,
  CONSTRAINT `product_variants_ibfk_1` FOREIGN KEY (`variant_id`) REFERENCES `variant_options` (`variant_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `product_variants_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8 COLLATE = utf8_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_variants
-- ----------------------------
INSERT INTO `product_variants` VALUES (0, NULL, NULL);
INSERT INTO `product_variants` VALUES (1, 7, 1);
INSERT INTO `product_variants` VALUES (2, 8, 1);
INSERT INTO `product_variants` VALUES (3, 9, 1);
INSERT INTO `product_variants` VALUES (24, 10, 1);
INSERT INTO `product_variants` VALUES (25, 11, 1);
INSERT INTO `product_variants` VALUES (26, 12, 1);
INSERT INTO `product_variants` VALUES (27, 13, 1);
INSERT INTO `product_variants` VALUES (29, 14, 1);
INSERT INTO `product_variants` VALUES (30, 15, 1);
INSERT INTO `product_variants` VALUES (31, 16, 1);
INSERT INTO `product_variants` VALUES (32, 17, 1);

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(350) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT NULL,
  `thumbnail` varchar(300) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT '',
  `description` longtext CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `category_id` int NULL DEFAULT NULL,
  `description_html` longtext CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `products_ibfk_1`(`category_id` ASC) USING BTREE,
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 477 CHARACTER SET = utf8 COLLATE = utf8_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, 'iPhone 15 Pro Max', 'iphone-avatar.jpg', 'Thông tin sản phẩm\r\n\r\nMáy mới 100% , chính hãng Apple Việt Nam. Hiện là đại lý bán lẻ uỷ quyền iPhone chính hãng VN/A của Apple Việt Nam\r\nHộp, Sách hướng dẫn, Cây lấy sim, Cáp Type C\r\n1 ĐỔI 1 trong 30 ngày nếu có lỗi phần cứng nhà sản xuất.', '2024-04-04 02:51:46', '2024-04-04 02:51:46', 1, '<div id=\"cpsContent\" class=\"cps-block-content\" style=\"max-height: 100000px;\"><div class=\"ksp-content p-2 mb-2\"><h2 class=\"ksp-title has-text-centered\">ĐẶC ĐIỂM NỔI BẬT</h2> <div><ul><li> Thiết kế khung viền từ titan chuẩn hàng không vũ trụ - Cực nhẹ, bền cùng viền cạnh mỏng cầm nắm thoải mái</li><li> Hiệu năng Pro chiến game thả ga - Chip A17 Pro mang lại hiệu năng đồ họa vô cùng sống động và chân thực</li><li> Thoả sức sáng tạo và quay phim chuyên nghiệp - Cụm 3 camera sau đến 48MP và nhiều chế độ tiên tiến</li><li> Nút tác vụ mới giúp nhanh chóng kích hoạt tính năng yêu thích của bạn</li></ul></div></div> <div><blockquote><p style=\"text-align: justify;\"><strong>iPhone 15 Pro Max</strong> sở hữu màn hình <strong>Super Retina XDR OLED 6.7 inches</strong> với độ phân giải <strong>2796 x 1290 pixels</strong>, cung cấp trải nghiệm hình ảnh sắc nét, chân thực. So với các phiên bản tiền nhiệm, thế hệ <a href=\"https://cellphones.com.vn/mobile/apple/iphone-15.html\" title=\"iPhone 15\" target=\"_blank\"><strong>iPhone 15</strong></a> bản Pro Max đảm bảo mang tới hiệu năng mạnh mẽ với sự hỗ trợ của chipset <strong>Apple A17 Pro</strong>, cùng bộ nhớ ấn tượng. Đặc biệt hơn, điện thoại iPhone 15 ProMax mới này còn được đánh giá cao với camera sau <strong>48MP</strong> và camera trước <strong>12MP</strong>, hỗ trợ chụp ảnh với độ rõ nét cực đỉnh.</p></blockquote> <h2><strong>Đánh giá những ưu điểm nổi trội mới có mặt trên iPhone 15 Pro Max</strong></h2> <p>iPhone 15 Pro Max không chỉ ghi điểm với cấu hình mạnh mẽ mà còn gây ấn tượng với nhiều tính năng mới đáng chú ý. Từ thiết kế khung titan cho tới hiệu năng đột phá, tất cả đều được nâng cấp để mang tới cho người dùng trải nghiệm smartphone tuyệt vời chưa từng có. Những tính năng này sẽ được trình bày chi tiết hơn trong các phần bài viết dưới đây, giúp bạn có cái nhìn toàn diện về sự đột phá của iPhone 15 ProMax.</p> <h3><strong>Kiểu dáng sang trọng, thời thượng với thiết kế Titan cực xịn</strong></h3> <p>Thiết kế titan dễ dàng thể hiện được nét đẳng cấp và sự tinh tế ngay từ vẻ bề ngoài của iPhone 15 Pro Max. Khung viền titan bóng bẩy của máy, được chế tác qua nhiều quy trình gia công cơ khí, chà nhám và đánh bóng, mang lại vẻ đẹp sang trọng và độ bền tuyệt vời. Với khung viền uốn cong và kiểu dáng siêu mỏng, thế hệ iPhone này đem lại trải nghiệm cầm nắm khá thoải mái.</p> <p><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max/iphone-15-pro-max-1.jpg\" alt=\"iPhone 15 Pro Max sở hữu kiểu dáng sang trọng và thời thượng\" loading=\"lazy\" title=\"iPhone 15 Pro Max sở hữu kiểu dáng sang trọng và thời thượng\"></p> <p style=\"text-align: center;\"><em>iPhone 15 Pro Max sở hữu kiểu dáng sang trọng và thời thượng</em></p> <h3><strong>Tấm nền Super Retina XDR cung cấp hình ảnh siêu mượt, độ sắc nét cao</strong></h3> <p>Mượt mà, sắc nét trong từng điểm ảnh là những gì iPhone 15 Pro Max thể hiện được về khả năng hiển thị. Theo đó, Super Retina XDR 6.7 inch OLED là tấm nền hiển thị trên iPhone 15 Pro Max, cho phép tái hiện hình ảnh với độ sống động đáng kinh ngạc ở độ phân giải 2796x1290 pixel. Đồng thời, các thao tác vuốt, chạm trên màn hình iPhone 15 ProMax cũng vô cùng luôn nhạy bén, thông qua công nghệ ProMotion 120Hz, đảm bảo tiết kiệm pin ấn tượng.</p> <p><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max/iphone-15-pro-max-2.jpg\" alt=\"Super Retina XDR 6.7 inch OLED là tấm nền hiển thị trên iPhone 15 Pro Max\" loading=\"lazy\" title=\"Super Retina XDR 6.7 inch OLED là tấm nền hiển thị trên iPhone 15 Pro Max\"></p> <p style=\"text-align: center;\"><em>Super Retina XDR 6.7 inch OLED là tấm nền hiển thị trên iPhone 15 Pro Max</em></p> <h3><strong>Hiệu năng đột phá mạnh mẽ với vi xử lý Apple A17 Pro</strong></h3> <p>Để xứng tầm với iPhone 15 Pro Max, Apple đã trang bị con chip A17 Pro, đưa sức mạnh của iPhone lên một đẳng cấp mới. Con chip A17 Pro cao cấp này đảm bảo trải nghiệm xử lý công việc mượt mà, chơi game đỉnh cao. Còn về khả năng xử lý đồ hoạ, GPU của iPhone 15 PRM cung cấp tốc độ xử lý vượt trội hơn bốn lần so với phiên bản trước với sự hỗ trợ từ công nghệ dò tia cao cấp. Qua đó, máy đảm bảo tạo nên hiệu ứng ánh sáng chân thực hàng đầu, nâng cấp độ trau chuốt về mặt hình ảnh của các tựa game đồ họa.</p> <p><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max/iphone-15-pro-max-3.jpg\" alt=\"Apple đã trang bị con chip A17 Pro đưa sức mạnh của iPhone 15 Promax lên một đẳng cấp mới\" loading=\"lazy\" title=\"Apple đã trang bị con chip A17 Pro đưa sức mạnh của iPhone 15 Promax lên một đẳng cấp mới\"></p> <p style=\"text-align: center;\"><em>Apple đã trang bị con chip A17 Pro đưa sức mạnh của iPhone 15 Promax lên một đẳng cấp mới</em></p> <h3><strong>Cụm camera Zoom 5x mạnh mẽ, hỗ trợ quay chụp với độ sắc nét cao</strong></h3> <p>Kể từ khi ra mắt iPhone 15 Pro Max luôn được ca tụng là sở hữu cụm camera chuyên nghiệp hàng đầu hiện nay, mang lại trải nghiệm chụp ảnh cực tốt. Với 7 tiêu cự khác nhau, từ góc rộng, siêu rộng rộng, cận cảnh cho tới phóng to 5x, thế hệ iPhone mới này có thể được xem như 1 chiếc máy ảnh chuyên dụng cao cấp.</p> <p>Nhờ vậy mà bạn có thể linh hoạt ghi lại nhiều tấm hình sắc nét với độ chi tiết cực cao. Bên cạnh đó, tính năng chụp ảnh chân dung được nâng cấp đáng kể, với khả năng tự động phát hiện và chuyển sang chế độ chân dung khi cần thiết.</p> <p><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max/iphone-15-pro-max-4.jpg\" alt=\"iPhone mới này có thể được xem như 1 chiếc máy ảnh chuyên dụng cao cấp\" loading=\"lazy\" title=\"iPhone mới này có thể được xem như 1 chiếc máy ảnh chuyên dụng cao cấp\"></p> <p style=\"text-align: center;\"><em>iPhone mới này có thể được xem như 1 chiếc máy ảnh chuyên dụng cao cấp</em></p> <p>Ở cảm biến camera chính 48MP, Apple đã tinh chỉnh lại để máy ảnh này có được khả năng kiểm soát ánh sáng thông minh hơn. Cụ thể, chế độ ban đêm trên máy được hỗ trợ dải tần nhạy sáng, hỗ trợ chụp ảnh sắc nét hơn ngay cả trong tối. Nhờ vậy mà những tấm hình được quay chụp qua iPhone 15 Pro Max có thể tái tạo tông màu da và màu sắc tuyệt đẹp hơn.</p> <p>Chưa dừng lại ở đó, iPhone 15 Pro Max còn cho phép zoom quang học lên đến 5 lần, điều mà các phiên bản iPhone thế hệ trước đó chưa làm được. Với ưu điểm này, iPhone 15 PRM cho phép bạn có thể chụp lại các khung cảnh từ xa một cách rõ nét mà không cần di chuyển lại gần mà vẫn có độ sắc nét cao.</p> <h3><strong>Nút tác vụ mới, cho phép thao tác nhanh với các tiện ích trên máy</strong></h3> <p>Nút tác vụ của iPhone 15 Pro Max là một tính năng mới lần đầu tiên xuất hiện trên iPhone, được chuyển đổi từ thanh gạt chuyển chế độ âm thanh. Nút này cho phép bạn thao tác một cách tiện lợi, dễ dàng hơn, với các tiện ích thường dùng trên iPhone 15 ProMax. Trên nút tác vụ mới này, bạn có thể thao tác và kích hoạt các tính năng như mở camera, ghi âm, đèn pin, dịch một cách nhanh chóng, tiện dụng.</p> <h3><strong>Cổng USB-C mới, giúp truyền tải dữ liệu cực nhanh</strong></h3> <p>iPhone 15 Pro Max giới thiệu một ưu điểm nổi bật – cổng USB-C mới trong lần ra mắt trong 2023 vừa rồi. Đây là lần đầu tiên iPhone hỗ trợ chuẩn USB 3, với tốc độ truyền dữ liệu lên đến 10Gb/s, giúp bạn truyền tải các tệp tin lớn một cách nhanh chóng.</p> <p><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max/iphone-15-pro-max-5.jpg\" alt=\"iPhone 15 Pro Max sử dụng cổng USB-C hoàn toàn mới truyền tải nhanh hơn\" loading=\"lazy\" title=\"iPhone 15 Pro Max sử dụng cổng USB-C hoàn toàn mới truyền tải nhanh hơn\"></p> <p style=\"text-align: center;\"><em>iPhone 15 Pro Max sử dụng cổng USB-C hoàn toàn mới truyền tải nhanh hơn</em></p> <p>Sự chuyển đổi sang cổng USB-C không chỉ tạo ra bước tiến lớn về giao thức kết nối mà còn mang lại sự tiện lợi khi dễ dàng kết nối với các phụ kiện và thiết bị khác. Việc này cho phép bạn sử dụng một loại cáp duy nhất cho tất cả các thiết bị của mình, tạo nên một trải nghiệm kết nối thuận tiện và hiệu quả hơn.</p> <h3><strong>Thời lượng pin liền mạch suốt ngày dài, công suất sạc nhanh ấn tượng</strong></h3> <p>Mặc dù được trang bị nhiều tính năng mạnh mẽ và hiện đại, iPhone 15 Pro Max vẫn duy trì thời lượng pin ấn tượng, đứng đầu trong các dòng smartphone hiện nay. Người dùng có thể tận hưởng giải trí với thời gian xem video liên tục lên đến 29 giờ, vượt trội hơn iPhone 12 Pro Max tới 9 giờ. Điều này cho thấy Apple đã tối ưu hóa hiệu quả pin vượt bậc, mang đến trải nghiệm liền mạch suốt ngày dài.</p> <p><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max/iphone-15-pro-max-6.jpg\" alt=\"iPhone 15 Pro Max cho thời gian xem video liên tục lên đến 29 giờ\" loading=\"lazy\" title=\"iPhone 15 Pro Max cho thời gian xem video liên tục lên đến 29 giờ\"></p> <p style=\"text-align: center;\"><em>iPhone 15 Pro Max cho thời gian xem video liên tục lên đến 29 giờ</em></p> <p>Không chỉ có thời lượng pin dài, iPhone 15 Pro Max còn hỗ trợ sạc nhanh và sạc nhanh không dây qua công nghệ MagSafe. Do vậy mà việc nạp năng lượng của iPhone 15 PRM đã trở nên tiện lợi và nhanh chóng hơn. Người dùng có thể an tâm rằng thiết bị luôn sẵn sàng cho mọi nhu cầu, từ công việc đến giải trí. Điều này giúp cuộc sống trở nên tiện lợi hơn khi không phải lo lắng về việc sạc pin, dù bạn đang ở đâu và làm gì. Với iPhone 15 Pro Max, hiệu suất sử dụng được đảm bảo liên tục và hiệu quả.</p> <h3><strong>Notch dạng Dynamic Island, cung cấp trải nghiệm sử dụng cực tiện lợi</strong></h3> <p>Dynamic Island trên iPhone 15 Pro Max là một tính năng nổi bật giúp người dùng có trải nghiệm tiện lợi hơn bao giờ hết. Không chỉ hiển thị thông báo một cách tinh tế, Dynamic Island còn cho phép kiểm soát âm nhạc và xem bản đồ mà không cần rời khỏi ứng dụng đang sử dụng.</p> <p><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max/iphone-15-pro-max-7.jpg\" alt=\"Dynamic Island trên iPhone 15 Pro Max là một tính năng nổi bật\" loading=\"lazy\" title=\"Dynamic Island trên iPhone 15 Pro Max là một tính năng nổi bật\"></p> <p style=\"text-align: center;\"><em>Dynamic Island trên iPhone 15 Pro Max là một tính năng nổi bật</em></p> <p>Đặc biệt, khi bạn thực hiện nhiều tác vụ cùng lúc, Dynamic Island sẽ tự động tách thành hai phần riêng biệt, giúp bạn dễ dàng quản lý và theo dõi. Tính năng này mang lại sự linh hoạt và hiệu quả trong việc sử dụng, khiến iPhone 15 Pro Max trở thành một lựa chọn tuyệt vời cho những ai yêu thích công nghệ hiện đại.</p> <h3><strong>Sở hữu nhiều tính năng, cải tiến độc đáo với hệ điều hành iOS 17 mới</strong></h3> <p>iPhone 15 Pro Max vận hành trên phiên bản iOS thế hệ thứ 17, đem lại nhiều nâng cấp lớn về bảo mật, hiệu suất. Một tính năng nổi bật trong phiên bản hệ điều hành mới này là Áp phích liên hệ, cho phép tạo ảnh đại diện tùy chỉnh với ảnh, văn bản và các yếu tố đồ họa khác.</p> <p>Hệ điều hành iOS 17 còn tích hợp NameDrop, một tính năng mới hỗ trợ chia sẻ thông tin liên hệ giữa các thiết bị Apple chỉ bằng cách chạm nhẹ hai thiết bị vào nhau. Ngay lập tức, cửa sổ chia sẻ sẽ xuất hiện, giúp việc trao đổi thông tin diễn ra nhanh chóng và dễ dàng.</p> <p><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max/iphone-15-pro-max-8.jpg\" alt=\"iPhone 15 Pro Max vận hành trên phiên bản iOS thế hệ thứ 17, đem lại nhiều nâng cấp lớn về bảo mật, hiệu suất\" loading=\"lazy\" title=\"iPhone 15 Pro Max vận hành trên phiên bản iOS thế hệ thứ 17, đem lại nhiều nâng cấp lớn về bảo mật, hiệu suất\"></p> <p style=\"text-align: center;\"><em>iPhone 15 Pro Max vận hành trên phiên bản iOS thế hệ thứ 17, đem lại nhiều nâng cấp lớn về bảo mật, hiệu suất</em></p> <p>Bên cạnh đó, từ Live Photo, video hoặc ảnh, iOS 17 cũng hỗ trợ người dùng sáng tạo ra các nhãn dán với hiệu ứng động độc đáo. Những nhãn dán này có thể sử dụng trong các ứng dụng như Tin nhắn, Ghi chú và Đánh dấu, mang lại trải nghiệm giao tiếp sinh động và thú vị hơn. Nhãn dán động được tạo ra thông qua công cụ cắt và chỉnh sửa ảnh hoặc video trong ứng dụng Tin nhắn, làm cho cuộc trò chuyện trở nên sinh động hơn bao giờ hết.</p> <p>Những cải tiến này không chỉ nâng cao hiệu suất của thiết bị mà còn tăng cường khả năng tương tác và cá nhân hóa. Với iOS 17, iPhone 15 Pro Max không chỉ là một thiết bị công nghệ tiên tiến mà còn là một công cụ hỗ trợ đắc lực cho cuộc sống hàng ngày của người dùng. Sự kết hợp giữa các tính năng mới mẻ và hiệu suất vượt trội đảm bảo rằng người dùng sẽ có những trải nghiệm tuyệt vời và tiện ích tối đa từ chiếc điện thoại này.</p> <h2><strong>So sánh iPhone 15 Pro Max và iPhone 14 Pro Max</strong></h2> <p>Ngay khi được ra mắt, iPhone 15 Pro Max đã nhận được khá nhiều đánh giá cao từ phía người dùng từ thiết kế, màn hình, camera cho tới hiệu năng. Tuy nhiên cũng không ít người tỏ ra thắc mắc, băn khoăn khi so sánh giữa iPhone 14 Pro Max và iPhone 15 Pro Max. Nhìn chung, thì ở hầu hết mọi khía cạnh, thế hệ 15 Pro Max của iPhone đã có nhiều cải tiến ấn tượng so với thế hệ tiền nhiệm trước đó.</p> <p>Cụ thể, thiết kế và vật liệu của iPhone 15 Pro Max vượt trội với khung titan và màu sắc mới (Đen Titan, Trắng Titan, Xanh Titan, Tự nhiên Titan). Trong khi đó, iPhone 14 PRM lại được đánh giá cao ở bộ khung hoàn thiện từ chất liệu thép không gỉ cùng các màu Đen Không Gian, Vàng, Bạc và Tím Đậm.</p> <p><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max/iphone-15-pro-max-9.jpg\" alt=\"Thiết kế và vật liệu của iPhone 15 Pro Max vượt trội 14 Pro Max với khung titan và màu sắc mới\" loading=\"lazy\" title=\"Thiết kế và vật liệu của iPhone 15 Pro Max vượt trội 14 Pro Max với khung titan và màu sắc mới\"></p> <p style=\"text-align: center;\"><em>Thiết kế và vật liệu của iPhone 15 Pro Max vượt trội 14 Pro Max với khung titan và màu sắc mới</em></p> <p>Về khả năng xử lý, nhờ được trang bị chipset A17 Pro, 15 PRM đem tới hiệu suất và đồ họa tốt hơn con chip A16 Bionic của iPhone 14 ProMax. Đồng thời, camera của iPhone 15 Pro Max cũng được cải tiến với khả năng zoom quang học xa hơn, hỗ trợ ghi Log video và cổng USB-C. Thông số này ở iPhone 14 Pro Max chỉ được giới hạn ở camera chính 48MP và cổng Lightning.</p> <p>Về dung lượng và giá, iPhone 15 Pro Max bắt đầu từ 256GB với giá khởi điểm $1,199, cao hơn so với iPhone 14 Pro Max bắt đầu từ 128GB với giá khởi điểm $1,099. Cả hai thiết bị đều có thời lượng pin tương đương và hỗ trợ sạc nhanh cùng sạc không dây MagSafe. Chi tiết các so sánh về cấu hình và thông số kỹ thuật giữa 2 dòng máy iPhone 15 PRM và iPhone 14 PRM sẽ được thể hiện trong bảng tổng hợp dưới đây.</p> <p><strong>Bảng so sánh thông số iPhone 15 Pro Max vs 14 Pro Max:</strong></p> <table><tbody><tr><td><p style=\"text-align: center;\"><strong>Thông số\\Thế hệ</strong></p></td> <td style=\"text-align: center;\"><p><strong>iPhone 15 Pro Max</strong></p></td> <td><p style=\"text-align: center;\"><strong>iPhone 14 Pro Max</strong></p></td></tr> <tr><td><p>Kích thước màn hình</p></td> <td style=\"text-align: center;\"><p>6.7 inches</p></td> <td style=\"text-align: center;\"><p>6.7 inches</p></td></tr> <tr><td><p>Loại màn hình</p></td> <td style=\"text-align: center;\"><p>Super Retina XDR, OLED</p></td> <td style=\"text-align: center;\"><p>Super Retina XDR, OLED</p></td></tr> <tr><td><p>Độ phân giải&nbsp;</p></td> <td style=\"text-align: center;\"><p>2796 x 1290 pixels</p></td> <td style=\"text-align: center;\"><p>2796 x 1290 pixels</p></td></tr> <tr><td><p>Tốc độ làm mới&nbsp;</p></td> <td style=\"text-align: center;\"><p>Up to 120Hz with ProMotion</p></td> <td style=\"text-align: center;\"><p>Up to 120Hz with ProMotion</p></td></tr> <tr><td><p>Vi xử lý</p></td> <td style=\"text-align: center;\"><p>A17 Pro&nbsp;</p></td> <td style=\"text-align: center;\"><p>A16 Bionic</p></td></tr> <tr><td><p>RAM</p></td> <td style=\"text-align: center;\"><p>8GB</p></td> <td style=\"text-align: center;\"><p>6GB</p></td></tr> <tr><td><p>Bộ nhớ trong</p></td> <td style=\"text-align: center;\"><p>256GB, 512GB, 1TB</p></td> <td style=\"text-align: center;\"><p>128GB, 256GB, 512GB, 1TB</p></td></tr> <tr><td><p>Camera chính&nbsp;</p></td> <td style=\"text-align: center;\"><p>48MP (wide)</p></td> <td style=\"text-align: center;\"><p>48MP (wide)</p></td></tr> <tr><td><p>Camera Tele</p></td> <td style=\"text-align: center;\"><p>12MP (5x optical zoom)</p></td> <td style=\"text-align: center;\"><p>12MP (3x optical zoom)</p></td></tr> <tr><td><p>Camera góc rộng</p></td> <td style=\"text-align: center;\"><p>12MP (ultra-wide)</p></td> <td style=\"text-align: center;\"><p>12MP (ultra-wide)</p></td></tr> <tr><td><p>Camera trước&nbsp;</p></td> <td style=\"text-align: center;\"><p>12MP</p></td> <td style=\"text-align: center;\"><p>12MP</p></td></tr> <tr><td><p>Dung lượng pin</p></td> <td style=\"text-align: center;\"><p>4352 mAh&nbsp;</p></td> <td style=\"text-align: center;\"><p>4352 mAh&nbsp;</p></td></tr> <tr><td><p>Khả năng sạc</p></td> <td style=\"text-align: center;\"><p>Fast charging, MagSafe wireless charging</p></td> <td style=\"text-align: center;\"><p>Fast charging, MagSafe wireless charging</p></td></tr> <tr><td><p>Hệ điều hành&nbsp;</p></td> <td style=\"text-align: center;\"><p>iOS 17</p></td> <td style=\"text-align: center;\"><p>iOS 16 (có thể nâng cấp lên)</p></td></tr> <tr><td><p>Hỗ trợ 5G</p></td> <td style=\"text-align: center;\"><p>Có</p></td> <td style=\"text-align: center;\"><p>Có</p></td></tr> <tr><td><p>Wifi</p></td> <td style=\"text-align: center;\"><p>Wifi 6E</p></td> <td style=\"text-align: center;\"><p>Wifi 6</p></td></tr> <tr><td><p>Bluetooth</p></td> <td style=\"text-align: center;\"><p>Bluetooth 5.3</p></td> <td style=\"text-align: center;\"><p>Bluetooth 5.3</p></td></tr> <tr><td><p>Kết cấu vỏ</p></td> <td style=\"text-align: center;\"><p>Vỏ hợp kim titan</p></td> <td style=\"text-align: center;\"><p>Vỏ làm bằng thép không gỉ</p></td></tr> <tr><td><p>Trọng lượng</p></td> <td style=\"text-align: center;\"><p>221g</p></td> <td style=\"text-align: center;\"><p>240g</p></td></tr> <tr><td><p>Kích thước&nbsp;</p></td> <td style=\"text-align: center;\"><p>159.9 x 76.7 x 8.25 mm</p></td> <td style=\"text-align: center;\"><p>160.7 x 77.6 x 7.85 mm</p></td></tr></tbody></table> <h2><strong>iPhone 15 Pro Max có mấy màu? Màu nào đẹp?</strong></h2> <p>iPhone 15 Pro Max được Apple giới thiệu với bốn màu sắc thời thượng, mang lại vẻ đẹp tinh tế và sang trọng hàng đầu thế giới smartphone hiện nay. Chi tiết các phiên bản màu sắc của iPhone 15 Pro Max được giới thiệu trong lần ra mắt thị trường lần lượt là: titan tự nhiên, titan trắng, titan đen và titan xanh.</p> <p><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max/iphone-15-pro-max-10.jpg\" alt=\"4 màu sắc của iPhone 15 Pro Max lần lượt là: titan tự nhiên, titan trắng, titan đen và titan xanh\" loading=\"lazy\" title=\"4 màu sắc của iPhone 15 Pro Max lần lượt là: titan tự nhiên, titan trắng, titan đen và titan xanh\"></p> <p style=\"text-align: center;\"><em>4 màu sắc của iPhone 15 Pro Max lần lượt là: titan tự nhiên, titan trắng, titan đen và titan xanh</em></p> <p><strong>- Titan Tự Nhiên</strong>: Đây là một màu sắc hoàn toàn mới mẻ, chưa từng có mặt trên bất kỳ dòng thiết bị nào trước đó của nhà Táo. Màu này tương đồng với màu bạc pha xám ánh kim, có đặc tính phản chiếu ánh sáng tốt, mang lại vẻ ngoài độc đáo và hiện đại.</p> <p><strong>- Titan Trắng</strong>: Khung viền titan mang lại cho phiên bản iPhone màu trắng này một vẻ ngoài bóng bẩy và tinh tế hơn. Bên cạnh đó, màu trắng trung tính cũng giúp dễ dàng phối hợp với các phụ kiện và trang phục khác nhau, tạo nên sự thanh lịch và tinh khiết cho người dùng.</p> <p><strong>- Titan Đen</strong>: Màu đen trên iPhone 15 ProMax là sự kết hợp giữa ánh kim loại của Titanium và sắc đen huyền bí, mang lại vẻ tinh tế, sang trọng hàng đầu. So với các phiên bản màu đen trên các thiết bị tiền nhiệm, màu đen trên iPhone 15 PRM có phần nhạt hơn, tạo nên sự độc đáo hiếm có cho dòng điện thoại này.</p> <p><strong>- Titan Xanh</strong>: Màu xanh này được pha chút xám, mang lại vẻ bí ẩn và mạnh mẽ. So với màu xanh lam trên iPhone 12 Pro, titan xanh tối và đậm hơn, phù hợp với những ai thích sự khác biệt và phong cách.</p> <p>Việc chọn màu phù hợp khi mua iPhone 15 Pro Max cũng còn tùy thuộc vào từng sở thích và cá tính của riêng mỗi người dùng. Titan Đen và Titan Trắng là hai lựa chọn khá được ưa chuộng vì khả năng dễ dàng kết hợp với các phụ kiện khác. Trong khi đó, Titan Tự Nhiên và Titan Xanh mang lại sự mới mẻ và cá tính. Do vậy mà còn tùy thuộc vào phong cách và yêu cầu của mỗi người mà tùy chọn màu sắc ưng ý trên iPhone 15 PRM sẽ có sự khác biệt.</p> <h2><strong>iPhone 15 Pro Max có mấy phiên bản bộ nhớ trong?</strong></h2> <p>Trong lần trở lại thị trường năm 2023 vừa rồi, iPhone 15 Promax có 3 phiên bản bộ nhớ trong là 256GB, 512GB và lớn nhất 1TB để đáp ứng các yêu cầu ghi nhớ dữ liệu ngày càng lớn.</p> <p><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max/iphone-15-pro-max-11.jpg\" alt=\"iPhone 15 Promax có 3 phiên bản bộ nhớ trong là 256GB, 512GB và lớn nhất 1TB\" loading=\"lazy\" title=\"iPhone 15 Promax có 3 phiên bản bộ nhớ trong là 256GB, 512GB và lớn nhất 1TB\"></p> <p style=\"text-align: center;\"><em>iPhone 15 Promax có 3 phiên bản bộ nhớ trong là 256GB, 512GB và lớn nhất 1TB</em></p> <p>iPhone 15 Pro Max 256GB: Dung lượng này có thể lưu trữ khoảng 2300 bức ảnh định dạng JPG, 362 video 4K UHD, hơn 1105 phút video FHD, và 1100 bài hát nén. Trong số các phiên bản bộ nhớ, đây phù hợp với người dùng thông thường nhất.</p> <p>iPhone 15 Pro Max 512GB: Phiên bản này giúp lưu trữ tới 1400 bài hát nén, 2095 phút video FHD hoặc 804 phút video 4K UHD và 2800 bức ảnh JPG. Với người dùng hay chụp ảnh hoặc quay video nhiều thì đây là phân khúc iPhone 15 ProMax phù hợp nên lựa chọn.</p> <p>iPhone 15 Pro Max 1TB: Phiên bản này có thể lưu trữ tới 3200 ảnh JPG, 2565 phút video FHD hay 894 phút 4K UHD, cùng với 1600 bài hát nén. Đây là tùy chọn phù hợp nhất với người dùng có nhiều nhu cầu đa phương tiện.</p> <h2 style=\"text-align: justify;\"><strong>iPhone 15 Pro Max dung lượng 256GB có đủ dùng không?</strong></h2> <p>Thế hệ điện thoại Apple mới 2023 này, Apple đã loại bỏ phiên bản dung lượng bộ nhớ trong 128GB. Theo đó,&nbsp;iPhone 15 Pro Max 256GB bộ nhớ trong sẽ là phiên bản bộ nhớ chuẩn. Vậy 256GB bộ nhớ lưu trữ có đủ dùng không, phù hợp sử dụng với những ai?</p> <p><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/apple-iphone-15-pro-22.jpg\" alt=\"iPhone 15 Pro Max dung lượng 256GB có đủ dùng\" loading=\"lazy\"></p> <p style=\"text-align: justify;\">256GB là dung lượng lưu trữ lớn, phù hợp với nhu cầu sử dụng của đại đa số người dùng cơ bản. Theo đó, nếu sử dụng điện thoại trong các nhu cầu như chơi game, gọi điện, nhắn tin, lướt web thì 256GB hoàn toàn có thể đáp ứng được nhu cầu.&nbsp;Tuy nhiên, với người dùng thực hiện các công việc về sáng tạo nội dung, cần lưu trữ những hình ảnh hay thước phim độ phân giải cao với dung lượng lớn thì có thể cân nhắc đến những phiên bản dung lượng cao hơn.</p> <h2><span><strong>iPhone 15 Pro Max giá bao nhiêu? Bảng giá mới nhất tháng 5/2024</strong></span></h2> <p>Việc Apple iPhone 15 Pro Max ra mắt đã thu hút sự chú ý lớn từ cộng đồng công nghệ toàn cầu do mức giá chênh lệch so với thế hệ trước. Mức giá iPhone 15 Pro Max ban đầu là 1.199 USD tại thị trường Mỹ. Tuy nhiên, giá thành hiện tại của dòng iPhone này đã có sự hạ nhiệt hơn so với thời điểm vừa mới được ra mắt.</p> <p>Bảng giá iPhone 15 Pro Max mới nhất tháng 5/2024 như sau:</p> <table><tbody><tr><td><p><strong>Tên máy</strong></p></td> <td><p><strong>Giá bán tại CellphoneS</strong></p> <p><strong>(Chưa bao gồm các khuyến mãi)</strong></p></td> <td><p><strong>Giá thu cũ lên đời tại CellphoneS</strong></p></td></tr> <tr><td><p>iPhone 15 Pro Max 256GB</p></td> <td style=\"text-align: center;\"><p>29.290.000 VNĐ</p></td> <td style=\"text-align: center;\"><p>26.790.000 VNĐ</p></td></tr> <tr><td><p>iPhone 15 Pro Max 512GB</p></td> <td style=\"text-align: center;\"><p>35.090.000 VNĐ</p></td> <td style=\"text-align: center;\"><p>32.590.000 VNĐ</p></td></tr> <tr><td><p>iPhone 15 Pro Max 1TB</p></td> <td style=\"text-align: center;\"><p>42.890.000 VNĐ</p></td> <td style=\"text-align: center;\"><p>38.390.000 VNĐ</p></td></tr></tbody></table> <p><strong><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max/iphone-15-pro-max-12.jpg\" alt=\"iPhone 15 Pro Max giá chỉ từ 29.290.000 VNĐ tại hệ thống CellphoneS\" loading=\"lazy\" title=\"iPhone 15 Pro Max giá chỉ từ 29.290.000 VNĐ tại hệ thống CellphoneS\"></strong></p> <p></p> <p style=\"text-align: center;\"><em>iPhone 15 Pro Max giá chỉ từ 29.290.000 VNĐ tại hệ thống CellphoneS</em></p> <p><em><strong>Lưu ý</strong>: giá bán có thể thay đổi, liên hệ trực tiếp để được tư vấn chi tiết nhất!</em></p> <h2><strong>iPhone 15 Pro Max được ra mắt vào thời gian nào?</strong></h2> <p>Thế hệ <strong>iPhone Pro Max thứ 15</strong> của Apple đã chính thức được ra mắt người tiêu dùng toàn cầu vào ngày <strong>12 tháng 9 năm 2023 tại sự kiện Wonderlust</strong> của Apple. Đây là sự kiện ra mắt iPhone 15 mới, bao gồm các phiên bản từ tiêu chuẩn cho tới ProMax có mặt trong Series.</p> <p><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max/iphone-15-pro-max-13.jpg\" alt=\"iPhone 15 Pro Max chính thức ra mắt vào ngày 12 tháng 9 năm 2023 tại sự kiện Wonderlust\" loading=\"lazy\" title=\"iPhone 15 Pro Max chính thức ra mắt vào ngày 12 tháng 9 năm 2023 tại sự kiện Wonderlust\"></p> <p style=\"text-align: center;\"><em>iPhone 15 Pro Max chính thức ra mắt vào ngày 12 tháng 9 năm 2023 tại sự kiện Wonderlust</em></p> <p>Sau khi ra mắt, các sản phẩm bắt đầu nhận đơn đặt hàng từ ngày 15 tháng 9 và chính thức bán ra vào ngày 22 tháng 9 năm 2023. Hiện tại, bạn hoàn toàn có thể ghé tới và tham khảo thêm dòng iPhone cao cấp này ở các cửa hàng công nghệ chất lượng cao như CellphoneS.</p> <h2><strong>Vì sao nên sở hữu iPhone 15 Pro Max?</strong></h2> <p>iPhone 15 Pro Max không chỉ mang đến những cải tiến vượt bậc về công nghệ mà còn sở hữu nhiều tính năng nổi bật, hỗ trợ tốt cho người dùng trong khi sử dụng. Từ thiết kế tinh tế, hiệu năng mạnh mẽ đến hệ thống camera chuyên nghiệp, iPhone 15 PRM có thể dễ dàng đáp ứng mọi nhu cầu của người dùng hiện đại. Có những nguyên nhân thuyết phục bạn sở hữu cho mình một chiếc iPhone 15 ProMax như sau:</p> <ul style=\"padding-left: 1.5em; line-height: 2; font-size: 13.5px;\"><ul style=\"padding-left: 1.5em; line-height: 2; font-size: 13.5px;\"><li style=\"list-style: disc;\">Độ hoàn thiện ấn tượng, bền chắc đỉnh cao</li> <li style=\"list-style: disc;\">Hiệu năng vượt trội, xử lý tác vụ mượt mà</li> <li style=\"list-style: disc;\">Nâng cấp bảo mật với công nghệ nhận quét khuôn mặt hiện đại</li> <li style=\"list-style: disc;\">Chuyển đổi dữ liệu đơn giản, nhanh chóng</li> <li style=\"list-style: disc;\">Thân thiện với môi trường</li> <li style=\"list-style: disc;\">Hỗ trợ đa dạng phụ kiện đi kèm</li></ul></ul> <p>Cụ thể:</p> <h3>Độ hoàn thiện ấn tượng, bền chắc đỉnh cao</h3> <p>iPhone 15 Pro Max sản xuất với tiêu chuẩn chất lượng và đã được chứng nhận theo tiêu chuẩn quốc tế, đảm bảo độ bền cao và sử dụng lâu dài. Chất liệu titan cao cấp chuẩn hàng không vũ trụ không chỉ mang lại vẻ ngoài sang trọng cho máy mà còn tăng cường độ bền chắc đỉnh cao. Điều này giúp người dùng yên tâm hơn trong quá trình sử dụng hàng ngày, giảm thiểu nguy cơ hư hỏng do va đập. Apple luôn chú trọng đến chất lượng và độ bền của sản phẩm, giúp bạn an tâm đầu tư vào một chiếc điện thoại cao cấp, bền bỉ theo thời gian.</p> <p><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max/iphone-15-pro-max-14.jpg\" alt=\"iPhone 15 Pro Max có độ hoàn thiện ấn tượng cùng thiết kế bền chắc đỉnh cao\" loading=\"lazy\" title=\"iPhone 15 Pro Max có độ hoàn thiện ấn tượng cùng thiết kế bền chắc đỉnh cao\"></p> <p style=\"text-align: center;\"><em>iPhone 15 Pro Max có độ hoàn thiện ấn tượng cùng thiết kế bền chắc đỉnh cao</em></p> <h3><strong>Hiệu năng vượt trội, xử lý tác vụ mượt mà</strong></h3> <p>Nhờ trang bị chip A17 Pro và nhiều công nghệ tiên tiến, iPhone 15 Pro Max mang lại hiệu suất đỉnh cao cho mọi tác vụ phức tạp. Khả năng xử lý mạnh mẽ này cho phép bạn bạn dễ dàng làm việc với ứng dụng nặng, chơi game yêu thích và thực hiện các tác vụ đa nhiệm cực mượt mà.</p> <p><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max/iphone-15-pro-max-15.jpg\" alt=\"Chip A17 Pro và nhiều công nghệ tiên tiến giúp iPhone 15 Pro Max xử lý mượt mà mọi tác vụ\" loading=\"lazy\" title=\"Chip A17 Pro và nhiều công nghệ tiên tiến giúp iPhone 15 Pro Max xử lý mượt mà mọi tác vụ\"></p> <p style=\"text-align: center;\"><em>Chip A17 Pro và nhiều công nghệ tiên tiến giúp iPhone 15 Pro Max xử lý mượt mà mọi tác vụ</em></p> <p>Điểm nổi bật của thế hệ iPhone 15 ProMax này là dung lượng lưu trữ lớn, giúp bạn dễ dàng lưu trữ dữ liệu, video và các bức hình quan trọng. Do đó, nếu bạn đang cần tìm kiếm một thiết bị hiệu năng cao, linh hoạt thì iPhone 15 ProMax hứa hẹn sẽ là một lựa chọn ưng ý.</p> <h3><strong>Nâng cấp bảo mật với công nghệ nhận quét khuôn mặt hiện đại</strong></h3> <p>Một trong những lý do hấp dẫn khác khiến người dùng lựa chọn iPhone 15 Pro Max là khả năng bảo mật vượt trội nhờ công nghệ nhận diện khuôn mặt tiên tiến. Theo đó, thiết bị được trang bị Camera TrueDepth, cho phép nhận diện khuôn mặt một cách chính xác ngay cả khi người dùng ở các góc độ khác nhau và trong điều kiện ánh sáng khác biệt.</p> <p>Không chỉ đảm bảo an ninh tối đa, Camera TrueDepth còn hỗ trợ nhiều tính năng hữu ích và thú vị như Animoji, Memoji, và chụp ảnh chân dung với hiệu ứng chuyên nghiệp. Nhờ công nghệ này, người dùng có thể trải nghiệm mức độ bảo mật cao cấp và tiện ích đa dạng. Nó biến iPhone 15 Pro Max trở thành lựa chọn tuyệt vời cho những ai đề cao tính bảo mật và trải nghiệm sử dụng hiện đại.</p> <h3><strong>Chuyển đổi dữ liệu đơn giản, nhanh chóng</strong></h3> <p>Một trong những ưu thế tuyệt vời khác cũng được đánh giá cao trên iPhone 15 Pro Max là khả năng chuyển đổi dữ liệu đơn giản. Quá trình chuyển đối này này khá nhanh chóng và không gây rắc rối, giúp bạn tối ưu được thời gian và công sức. Điều này cho phép bạn tận hưởng trải nghiệm mới mẻ trên iPhone 15 Pro Max ngay lập tức mà không phải lo lắng hay chờ đợi quá trình sao chép dữ liệu.</p> <p><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max/iphone-15-pro-max-16.jpg\" alt=\"iPhone 15 Pro Max chuyển đổi dữ liệu nhanh chóng và đơn giản\" loading=\"lazy\" title=\"iPhone 15 Pro Max chuyển đổi dữ liệu nhanh chóng và đơn giản\"></p> <p style=\"text-align: center;\"><em>iPhone 15 Pro Max chuyển đổi dữ liệu nhanh chóng và đơn giản</em></p> <h3><strong>Thân thiện với môi trường</strong></h3> <p>Một lý do quan trọng để cân nhắc mua iPhone 15 Pro Max là tính thân thiện với môi trường của nó. Cụ thể, máy được sản xuất từ các nguồn nguyên liệu thân thiện và vật liệu tái chế. Qua đó, nó hỗ trợ bảo vệ tài nguyên tự nhiên và giảm thiểu rác thải ra ngoài môi trường sống.</p> <p>Không chỉ vậy, iPhone 15 Pro Max còn tiêu thụ ít năng lượng hơn trong quá trình sử dụng hàng ngày, giúp hạn chế lượng khí thải nhà kính. Do đó, việc chọn mua iPhone 15 Pro Max không chỉ mang lại hiệu suất tuyệt vời cho xử lý công việc lẫn giải trí mà còn góp phần bảo vệ môi trường.</p> <h3><strong>Hỗ trợ đa dạng phụ kiện đi kèm</strong></h3> <p>Một lý do hấp dẫn khác để chọn mua iPhone 15 Pro Max là sự hỗ trợ của các phụ kiện phong phú về tính năng và màu sắc. Các phụ kiện như ốp lưng, sạc nhanh, và tai nghe không dây không chỉ tăng thêm tiện ích mà còn mang lại sự lựa chọn đa dạng về thẩm mỹ.</p> <p><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max/iphone-15-pro-max-17.jpg\" alt=\"iPhone 15 Pro Max có thể kết hợp với các phụ kiện phong phú về tính năng và màu sắc\" loading=\"lazy\" title=\"iPhone 15 Pro Max có thể kết hợp với các phụ kiện phong phú về tính năng và màu sắc\"></p> <p style=\"text-align: center;\"><em>iPhone 15 Pro Max có thể kết hợp với các phụ kiện phong phú về tính năng và màu sắc</em></p> <p>- <strong>Ốp lưng</strong>: Với nhiều loại ốp lưng khác nhau, người dùng có thể bảo vệ thiết bị của mình trong khi vẫn thể hiện phong cách cá nhân.</p> <p>- <strong>Bộ sạc nhanh</strong>: Nạp pin nhanh chóng, không phải chờ đợi quá lâu khi sạc lại năng lượng.</p> <p>- <strong>Tai nghe không dây</strong>: Cung cấp chất lượng âm thanh vượt trội và tiện lợi khi di chuyển.</p> <p>Sự kết hợp này giúp nâng cao trải nghiệm sử dụng iPhone 15 Pro Max, khiến nó trở thành lựa chọn tuyệt vời cho những ai tìm kiếm sự linh hoạt và phong cách. Với các phụ kiện chất lượng cao và đa dạng, người dùng có thể tối ưu hóa hiệu suất và thẩm mỹ của thiết bị mình sở hữu.</p> <h3><strong>Dễ dàng kết nối với người dùng hệ sinh thái Apple khác</strong></h3> <p>iPhone 15 Pro Max được xem là phương thức kết nối độc đáo, thú vị giữa những người dùng iPhone với nhau. Bạn có thể dễ dàng kết nối và chia sẻ mọi thứ với bạn bè và gia đình nhờ vào sự tích hợp liền mạch với các thiết bị và dịch vụ của Apple. Từ chia sẻ ảnh, video, và tài liệu một cách nhanh chóng qua iMessage và AirDrop, iPhone 15 Pro Max sẽ hỗ trợ bạn chuyển file hoặc truyền dữ liệu một cách thuận tiện.</p> <p><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max/iphone-15-pro-max-18.jpg\" alt=\"Chia sẻ ảnh, video, và tài liệu một cách nhanh chóng qua iMessage và AirDrop với iPhone 15 Pro Max\" loading=\"lazy\" title=\"Chia sẻ ảnh, video, và tài liệu một cách nhanh chóng qua iMessage và AirDrop với iPhone 15 Pro Max\"></p> <p style=\"text-align: center;\"><em>Chia sẻ ảnh, video, và tài liệu một cách nhanh chóng qua iMessage và AirDrop với iPhone 15 Pro Max</em></p> <p>Không dừng lại ở đó, FaceTime cũng cho phép bạn thực hiện cuộc gọi video chất lượng cao dù bạn và người thân ở bất kỳ đâu trên thế giới. Ngoài ra, hệ thống iCloud của Apple cũng giúp bạn lưu trữ và truy cập dữ liệu cá nhân từ mọi thiết bị Apple, đảm bảo mọi thứ bạn cần đều luôn trong tầm tay.</p> <h2><strong>Mua iPhone 15 Pro Max chính hãng trả góp \"3 KHÔNG\" tại CellphoneS</strong></h2> <p>Để sở hữu iPhone 15 Pro Max chính hãng với mức giá hợp lý và nhiều ưu đãi hấp dẫn, CellphoneS là điểm đến mua sắm hấp dẫn không nên bỏ lỡ. Đặc biệt là chương trình mua iPhone 15 Pro Max trả góp \"3 KHÔNG\" tại CellphoneS: 0% LÃI SUẤT - KHÔNG PHÍ ẨN - KHÔNG CẦN TRẢ TRƯỚC.</p> <p>Bên cạnh đó, những lý do bạn nên mua iPhone 15 ProMax nói riêng và iPhone chính hãng tại CellphoneS còn có:</p> <ul style=\"padding-left: 1.5em; line-height: 2; font-size: 13.5px;\"><li style=\"list-style: disc;\">Sản phẩm chính hãng, bảo hành đầy đủ: CellphoneS cung cấp iPhone 15 Pro Max chính hãng với chính sách bảo hành đổi mới trong 30 ngày đầu. Bên cạnh đó, CellphoneS còn bảo hành máy trong vòng 12 tháng tại các trung tâm bảo hành ủy quyền Apple.</li> <li style=\"list-style: disc;\">Thu cũ lên đời với trợ giá cao: CellphoneS hỗ trợ khách hàng thu cũ lên đời giúp bạn đổi chiếc iPhone cũ của mình lấy một chiếc iPhone 15 Pro Max mới với giá ưu đãi, giảm đáng kể chi phí.</li> <li style=\"list-style: disc;\">Ưu đãi phụ kiện: Khi mua kèm phụ kiện chính hãng, bạn sẽ nhận được mức giảm giá hấp dẫn, giúp bạn trang bị đầy đủ cho chiếc điện thoại mới mà vẫn tiết kiệm.</li> <li style=\"list-style: disc;\">Hệ thống cửa hàng toàn quốc, giao hàng nhanh: Bạn có thể trải nghiệm sản phẩm tại các cửa hàng trên toàn quốc và nhận hàng nhanh chóng, tiện lợi.</li></ul> <p><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max/iphone-15-pro-max-19.jpg\" alt=\"Mua iPhone 15 Pro Max chính hãng trả góp &amp;#34;3 KHÔNG&amp;#34; tại CellphoneS\" loading=\"lazy\" title=\"Mua iPhone 15 Pro Max chính hãng trả góp &amp;#34;3 KHÔNG&amp;#34; tại CellphoneS\"></p> <p style=\"text-align: center;\"><em>Mua iPhone 15 Pro Max chính hãng trả góp \"3 KHÔNG\" tại CellphoneS</em></p> <h2 style=\"text-align: justify;\"><strong>Trải nghiệm ngay sản phẩm iPhone 15 Pro Max tại CellphoneS</strong></h2> <p style=\"text-align: justify;\">Nếu những đánh giá về thông số, tính năng về sản phẩm trên chưa thể giúp bạn đọc thì tại CellphoneS có thể hỗ trợ khách hàng trên tay và trải nghiệm trực tiếp sản phẩm. Đặc biệt, trong quá trình trải nghiệm nếu có bất kỳ thắc mắc nào khách hàng sẽ được nhân viên tư vấn tận tình. Đặc biệt, tất cả các cửa hàng trên hệ thống của CellphoneS đều được trang bị bị khu vực demo - trải nghiệm. Quý khách có thể lựa chọn cửa hàng gần nhất để trải nghiệm ngay.</p> <p style=\"text-align: justify;\"><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max-42.JPG\" alt=\"Trải nghiệm ngay sản phẩm iPhone 15 Pro Max\" loading=\"lazy\"></p> <p style=\"text-align: justify;\"><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max-43.JPG\" alt=\"Trải nghiệm ngay sản phẩm iPhone 15 Pro Max\" loading=\"lazy\"></p> <p style=\"text-align: justify;\"><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max-40.JPG\" alt=\"Trải nghiệm ngay sản phẩm iPhone 15 Pro Max\" loading=\"lazy\"></p> <p style=\"text-align: justify;\"><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max-41.jpg\" alt=\"Trải nghiệm ngay sản phẩm iPhone 15 Pro Max\" loading=\"lazy\"></p> <h2><strong>Một số câu hỏi thường gặp về iPhone 15 Pro Max</strong></h2> <p>iPhone 15 Pro Max sở hữu cấu hình vượt trội nhưng người dùng còn nhiều thắc mắc đến sản phẩm này trước khi có quyết định nâng cấp. Một số thắc mắc phổ biến mà người dùng quan tâm đến sản phẩm này phải kể đến như:</p> <h3><strong>iPhone 15&nbsp;Pro Max có mấy phiên bản bộ nhớ trong</strong></h3> <p>Không giống như ba phiên bản khác, điện thoại&nbsp;iPhone 15 Pro Max không được trang bị phiên bản 128GB dung lượng bộ nhớ lưu trữ mà nâng cấp dung lượng chuẩn lên 256GB. Theo đó,&nbsp;<strong>iPhone 15 Pro Max</strong> sẽ còn <strong>ba phiên bản bộ nhớ trong: 256GB, 512GB và 1TB.</strong></p> <h3><strong>iPhone 15&nbsp;Pro Max nặng bao nhiêu</strong></h3> <p>Với khung viền titan cải tiến nhờ đó thế hệ điện thoại mới này nhẹ hơn đáng kể so với phiên bản tiền nhiệm. Cụ thể&nbsp;<strong>iPhone 15 Pro Max có trọng lượng</strong> rơi vào khoảng&nbsp;<strong>221 gram</strong>, nhẹ hơn tới 20g so với trên 14 Pro Max (240 gam). Với trọng lượng giảm, thiết bị giúp người dùng có những trải nghiệm cầm nắm thoải mái hơn.</p> <p><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-14-pro-max-16.jpg\" alt=\"iPhone 15 Pro Max nặng bao nhiêu\" loading=\"lazy\"></p> <h3><strong>iPhone 15&nbsp;Pro Max có màu hồng, đỏ không</strong></h3> <p style=\"text-align: justify;\">Đặc điểm màu sắc trên dòng iPhone Pro của Apple đó là sử dụng những tone màu trung tính. Trong khi đó phiên bản thường,&nbsp; Plus hay mini sẽ được trang bị những gam màu rực rỡ như vàng, đỏ, tím hồng,..&nbsp;iPhone 15 Pro Max cũng không nằm ngoài quy luật trên nên máy sẽ không được trang bị màu đỏ hay hồng mà sở hữu bốn màu: Titan tự nhiên, đen, trắng và xanh</p> <h3><strong>Đang dùng iPhone 14 Pro/Pro Max có nên mua 15 Pro Max không</strong></h3> <p style=\"text-align: justify;\">Sở hữu nhiều nâng cấp nổi trội về thiết kế và tính năng, vậy người dùng sử dụng phiên bản 14 Pro và Pro Max có nên nâng cấp lên thế hệ mới này không? Câu trả lời là có. 15 Pro Max với khung titan sang trọng, cổng sạc với cùng nút tác vụ tiện lợi. Bên cạnh đó, điện thoại còn được cải tiến cấu hình với con chip A17 Pro cùng camera nâng cấp khả năng chụp zoom lên 5x. Với những tính năng trên thì những người dùng muốn trải nghiệm những công nghệ mới nhất hoàn toàn nên trải nghiệm. Trường hợp người dùng muốn trải nghiệm nhưng còn vướng mắc về giá thì có thể tham khảo đến chương trình thu cũ lên đời để sở hữu điện thoại công nghệ mới nhất với khoản chi phí cần bù thêm hợp lý.</p> <h3><strong>Kích thước của iPhone 15 Pro Max bao nhiêu</strong></h3> <p>Cùng sở hữu màn hình kích thước 6.7 inch như thế hệ thệ 14 Pro Max tuy nhiên kích thước điện thoại mới này có sự thay đổi đôi chút. Cụ thể, máy dày hơn đôi chút so với trên iPhone 14 Pro Max và giảm kích thước về chiều dài và rộng. Chi tiết kích thước trên iPhone 15 Pro Max như sau: Dày&nbsp;8,25mm, rộng&nbsp;76,7 mm và dài&nbsp;159,9 mm.</p> <h3><strong>iPhone 15 Pro Max có chống nước, chống sốc không</strong></h3> <p style=\"text-align: justify;\">Mẫu điện thoại cao cấp mới này vẫn được Apple trang bị các tiêu chuẩn kháng nước và bụi bẩn như thế hệ trước đó. Cụ thể,&nbsp;iPhone 15 Pro Max được trang bị chuẩn <strong>kháng nước và bụi bẩn&nbsp;IP68 theo tiêu chuẩn IEC 60529</strong> giúp bảo vệ thiết bị dưới nước ở độ sâu 6 mét trong thời gian tối đa 30 phút. Tuy nhiên, tính năng kháng nước sẽ không được hãng bảo hành, do đó khuyến kích người dùng không test thử tính năng này.</p> <p style=\"text-align: justify;\"><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-14-pro-max-15.jpg\" alt=\"iPhone 15 Pro Max có chống nước\" loading=\"lazy\"></p> <h3><strong>Màu titan trên iPhone 15 Pro Max gần với màu gì</strong></h3> <p>iPhone 15 Pro Max được trang bị bốn màu titan hoàn toàn mới bao gồm: Titan tự nhiên, titan đen, titan trắng và titan xanh. Cả bốn màu trên phiên bản đều là những màu mới trong đó titan tự nhiêu có màu sắc của màu&nbsp;Titanium trong tự nhiên và nhận được nhiều quan tâm của người dùng. Ban phiên bản màu còn lại tuy mới nhưng vẫn có nhiều điểm tương đồng với những màu sắc trước đó, như sau:</p> <table class=\"table table-bordered\"><tbody><tr class=\"success\"><td><p style=\"text-align: center;\"><strong>Màu iPhone 15 Pro Max</strong></p></td> <td><p style=\"text-align: center;\"><strong>So sánh với màu trước đó</strong></p></td></tr> <tr><td><p>Titan tự nhiên</p></td> <td><p>Màu mới lần đầu xuất hiện</p></td></tr> <tr><td><p>Titan đen</p></td> <td><p>Khá giống&nbsp;Pacific Blue trên&nbsp;iPhone 12 Pro nhưng sắc xanh đậm hơn</p></td></tr> <tr><td><p>Titan trắng</p></td> <td><p>Có nhiều điểm tương đồng với&nbsp;Black Space trước đó</p></td></tr> <tr><td><p>Titan xanh</p></td> <td><p>Màu sắc gần giống với màu Bạc&nbsp;Silver</p></td></tr></tbody></table> <p>Nhìn chung, tuy cả bốn màu đều là màu mới nhưng chúng đều có điểm tương đồng với những màu sắc từng được xuất hiện trước đó của Apple.</p> <h3><strong>Điện thoại iPhone 15 Pro Max có kết nối 5G không? </strong></h3> <p>iPhone 15 Pro Max có được trang bị kết nối 5G nhưng để sử dụng thì nhà mạng mà người dùng đang sử dụng phải hỗ trợ kết nối này. Một số nhà mạng tại Việt Nam có hỗ trợ kết nối 5G phải kể đến như Vinaphone, Viettel, Mobifone…</p> <p><img src=\"https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/iphone-15-pro-max-24.png\" alt=\"Điện thoại iPhone 15 Pro Max có kết nối 5G không\" loading=\"lazy\"></p> <p style=\"text-align: center;\">(Nguồn ảnh Apple.com)</p> <h3><strong> Thực hiện chuyển đổi dữ liệu từ điện thoại cũ sang iPhone 15 Pro Max có khó không </strong></h3> <p>Nếu thiết bị cũ chạy hệ điều hành iOS thì việc chuyển đổi diễn ra khá đơn giản thông qua các bản sao lưu của iCloud. Nếu thiết bị cũ chạy Andoid hoặc hệ điều hành khác, người dùng cần tải thêm ứng dụng Chuyển sang iOS để hỗ trợ quá trình chuyển đổi.</p> <p>Hãy đến ngay CellphoneS để trải nghiệm và sở hữu iPhone 15 Pro Max, siêu phẩm công nghệ đỉnh cao của Apple. Với chính sách bảo hành chính hãng và chương trình thu cũ lên đời hấp dẫn, CellphoneS hứa hẹn mang đến cho bạn trải nghiệm mua sắm tuyệt vời. Đừng bỏ lỡ cơ hội quý giá để có được iPhone tiên tiến này với giá thành hấp dẫn. Ghé thăm các cửa hàng CellphoneS trên toàn quốc để nhận tư vấn và trải nghiệm trực tiếp sản phẩm ngay hôm nay nhé!</p></div> <div class=\"cps-block-content_btn-showmore\" style=\"display: none;\"><a class=\"btn-show-more button__content-show-more\">\r\n      Xem thêm  <div><svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 448 512\" width=\"10\" height=\"10\"><path d=\"M224 416c-8.188 0-16.38-3.125-22.62-9.375l-192-192c-12.5-12.5-12.5-32.75 0-45.25s32.75-12.5 45.25 0L224 338.8l169.4-169.4c12.5-12.5 32.75-12.5 45.25 0s12.5 32.75 0 45.25l-192 192C240.4 412.9 232.2 416 224 416z\"></path></svg></div></a></div></div>');
INSERT INTO `products` VALUES (2, 'ipad pro 2013', 'product-2.jpg', 'this is description', '2024-04-04 03:01:15', '2024-04-04 03:01:15', 1, '<p>This is a <strong>sample</strong> product.</p>');
INSERT INTO `products` VALUES (3, 'Awesome Wool Plate', 'product-3.jpg', 'Voluptas officiis ipsa nesciunt itaque quos placeat molestiae.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, 'This is a sample product.');
INSERT INTO `products` VALUES (5, 'Awesome Aluminum Shoes', 'product-14.jpg', 'Voluptatum impedit omnis.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (6, 'Intelligent Bronze Keyboard', 'product-5.jpg', 'Laborum totam quos.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (7, 'Durable Steel Gloves', 'product-6.jpg', 'Laborum natus perferendis natus fugiat quo dolorem.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (8, 'Aerodynamic Wool Chair', 'product-7.jpg', 'Tempora sit sequi placeat iste.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (9, 'Durable Silk Chair', 'product-8.jpg', 'Qui asperiores quod distinctio omnis quia dolor.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (10, 'Ergonomic Linen Shoes', 'product-9.jpg', 'Doloribus est odit qui et quo est.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (11, 'Durable Marble Chair', 'product-16.jpg', 'Consectetur saepe saepe.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (12, 'Gorgeous Plastic Lamp', 'product-11.jpg', 'Incidunt qui qui.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (13, 'Intelligent Copper Hat', 'product-20.jpg', 'Asperiores consectetur esse aspernatur quos nihil.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (14, 'Practical Wool Chair', 'product-1.jpg', 'Quo dolores quia reiciendis laborum quasi dolore.', '2024-02-26 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (15, 'Synergistic Granite Bench', 'product-1.jpg', 'Sed excepturi labore est enim officiis inventore.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (16, 'Gorgeous Plastic Coat', 'product-1.jpg', 'Enim ex recusandae non ducimus rerum voluptas perspiciatis.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (17, 'Aerodynamic Leather Knife', 'product-1.jpg', 'Nulla tempora ratione et ut labore.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (18, 'Practical Marble Bottle', 'product-1.jpg', 'Et aut provident sed fuga rerum praesentium.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (19, 'Ergonomic Cotton Lamp', 'product-1.jpg', 'Quisquam nam voluptatem ullam et omnis quasi.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (20, 'Durable Wooden Computer', 'product-1.jpg', 'Consectetur eum voluptatem ipsum et nihil est.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (21, 'Intelligent Silk Shoes', 'product-1.jpg', 'Quo neque accusamus.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (22, 'Lightweight Marble Gloves', 'product-1.jpg', 'Dolore sint culpa sapiente officiis.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (23, 'Practical Copper Shirt', 'product-1.jpg', 'Ut aliquid voluptatem a soluta provident rerum.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (24, 'Rustic Steel Bench', 'product-1.jpg', 'Voluptatum animi voluptatem sed autem quod tempore.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (25, 'Mediocre Rubber Chair', 'product-1.jpg', 'Quisquam asperiores quis nobis quibusdam veritatis iure eligendi.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (26, 'Enormous Paper Table', 'product-1.jpg', 'Iure consequuntur velit et.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (27, 'Fantastic Steel Wallet', 'product-1.jpg', 'Vero vel molestias fugiat dolores dolorem.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (28, 'Lightweight Cotton Bench', 'product-1.jpg', 'Est maxime ut nisi.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (29, 'Rustic Granite Bottle', 'product-1.jpg', 'Placeat temporibus quidem optio.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (30, 'Practical Silk Car', 'product-1.jpg', 'Dolorem quasi aut.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (31, 'Intelligent Aluminum Watch', 'product-1.jpg', 'Qui voluptas rem eveniet nemo quam nihil sapiente.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (32, 'Sleek Paper Coat', 'product-1.jpg', 'Neque laborum voluptates.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (33, 'Intelligent Marble Lamp', 'product-1.jpg', 'Cumque aspernatur qui.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (34, 'Small Concrete Wallet', 'product-1.jpg', 'Aliquam nulla excepturi.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (35, 'Ergonomic Copper Chair', 'product-1.jpg', 'Minima et qui.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (36, 'Synergistic Iron Knife', 'product-1.jpg', 'Tempore quasi nam.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (37, 'Enormous Linen Bottle', 'product-1.jpg', 'Repudiandae et facere quasi quas est a.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (38, 'Intelligent Marble Plate', 'product-1.jpg', 'Debitis libero corrupti velit est est.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (39, 'Heavy Duty Plastic Coat', 'product-1.jpg', 'Quidem delectus totam.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (40, 'Incredible Linen Gloves', 'product-1.jpg', 'Recusandae dicta repellendus qui et.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (41, 'Small Paper Chair', 'product-1.jpg', 'Amet amet consequuntur unde quis quia quaerat et.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (42, 'Awesome Leather Shoes', 'product-1.jpg', 'Sint magni sit voluptas.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (43, 'Ergonomic Iron Pants', 'product-1.jpg', 'Illum repudiandae incidunt at provident et et consequatur.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (44, 'Mediocre Iron Pants', 'product-1.jpg', 'Quis recusandae voluptatem.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (45, 'Enormous Linen Hat', 'product-1.jpg', 'Aspernatur non praesentium perspiciatis sit fuga accusantium.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (46, 'Sleek Rubber Clock', 'product-1.jpg', 'Exercitationem corporis minima ut modi.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (47, 'Gorgeous Concrete Computer', 'product-1.jpg', 'Non at et magnam aut autem culpa assumenda.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (48, 'Mediocre Rubber Shirt', 'product-1.jpg', 'A in quia ab.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (49, 'Gorgeous Wooden Shirt', 'product-1.jpg', 'Beatae libero quasi eius et expedita dignissimos.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (50, 'Practical Wool Shoes', 'product-1.jpg', 'Aliquid sed quos voluptatem sequi optio tempore facilis.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (51, 'Fantastic Wooden Gloves', 'product-1.jpg', 'Quas voluptatum quis quam porro doloremque.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (52, 'Durable Bronze Lamp', 'product-1.jpg', 'Est et quo nobis reprehenderit vel.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (53, 'Enormous Marble Watch', 'product-1.jpg', 'Sapiente aperiam ut.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (54, 'Ergonomic Linen Clock', 'product-1.jpg', 'Minima ut eum quis est reprehenderit repellat.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (55, 'Synergistic Linen Car', 'product-1.jpg', 'Maiores ex aliquam deserunt.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (56, 'Aerodynamic Concrete Bag', 'product-1.jpg', 'Unde earum nam voluptatem sed.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (57, 'Small Silk Pants', 'product-1.jpg', 'Exercitationem sequi voluptate facere.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (58, 'Ergonomic Leather Pants', 'product-1.jpg', 'Ut temporibus cum rerum hic.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (59, 'Small Rubber Car', 'product-1.jpg', 'Excepturi aperiam dolorem.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (60, 'Incredible Silk Gloves', 'product-1.jpg', 'Et voluptas aliquid officiis voluptatem.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (61, 'Incredible Steel Knife', 'product-1.jpg', 'Enim reiciendis facilis odio non impedit dolores.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (62, 'Gorgeous Rubber Clock', 'product-1.jpg', 'Est dolor voluptas placeat in.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (63, 'Enormous Marble Shirt', 'product-1.jpg', 'Incidunt voluptatum cumque iure laudantium qui consequatur.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (64, 'Synergistic Linen Lamp', 'product-1.jpg', 'Voluptas facilis nobis.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (65, 'Incredible Wool Bottle', 'product-1.jpg', 'Perspiciatis qui labore.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 2, '');
INSERT INTO `products` VALUES (66, 'Practical Marble Bench', 'product-1.jpg', 'Atque et voluptatem illum totam sequi iusto.', '2024-04-04 13:27:17', '2024-04-04 13:27:17', 1, '');
INSERT INTO `products` VALUES (67, 'Synergistic Linen Knife', 'product-1.jpg', 'Quidem quasi ab voluptates adipisci.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (68, 'Rustic Silk Shirt', 'product-1.jpg', 'Est autem vel aut.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (69, 'Rustic Leather Knife', 'product-1.jpg', 'Vitae minus voluptatem.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (70, 'Sleek Wooden Table', 'product-1.jpg', 'Quos architecto est et laboriosam.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (71, 'Durable Concrete Coat', 'product-1.jpg', 'Animi dolore eum.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (72, 'Aerodynamic Iron Knife', 'product-1.jpg', 'Veritatis voluptas asperiores voluptatem pariatur et earum voluptates.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (73, 'Ergonomic Aluminum Coat', 'product-1.jpg', 'Adipisci doloribus nostrum.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (74, 'Heavy Duty Paper Bench', 'product-1.jpg', 'Quod eum qui nihil eum voluptatibus.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (75, 'Practical Rubber Table', 'product-1.jpg', 'Suscipit totam voluptatem rerum.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (76, 'Incredible Linen Pants', 'product-1.jpg', 'Velit quia consequatur ducimus.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (77, 'Practical Wool Computer', 'product-1.jpg', 'Expedita quia dolore exercitationem voluptatem et ratione cum.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (78, 'Lightweight Silk Shirt', 'product-1.jpg', 'Quia officia incidunt.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (79, 'Lightweight Paper Car', 'product-1.jpg', 'Molestiae expedita aspernatur deleniti perferendis.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (80, 'Rustic Silk Computer', 'product-1.jpg', 'Et magnam commodi autem et molestiae sunt.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (81, 'Gorgeous Plastic Watch', 'product-1.jpg', 'Rerum repudiandae numquam explicabo necessitatibus quas maiores.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (82, 'Small Bronze Gloves', 'product-1.jpg', 'Beatae eius cumque corporis ex.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (83, 'Practical Granite Wallet', 'product-1.jpg', 'Culpa vero aperiam.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (84, 'Durable Silk Car', 'product-1.jpg', 'Perspiciatis dolorum quos dignissimos totam amet ut iste.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (85, 'Aerodynamic Rubber Chair', 'product-1.jpg', 'Nulla earum at dignissimos sit qui.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (86, 'Heavy Duty Linen Plate', 'product-1.jpg', 'Esse quis rerum in occaecati beatae.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (87, 'Mediocre Iron Lamp', 'product-1.jpg', 'Quia quia omnis aut aut a explicabo.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (88, 'Rustic Copper Chair', 'product-1.jpg', 'Ut aut omnis sapiente quidem.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (89, 'Small Cotton Clock', 'product-1.jpg', 'Sint molestiae voluptates ut harum iure cupiditate harum.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (90, 'Intelligent Paper Coat', 'product-1.jpg', 'Dolore illo dicta explicabo est praesentium.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (91, 'Mediocre Paper Coat', 'product-1.jpg', 'Magni possimus laborum quo impedit.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (92, 'Practical Copper Pants', 'product-1.jpg', 'Quo rerum numquam rerum sit in.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (93, 'Small Leather Bottle', 'product-1.jpg', 'Tempora ea aliquam.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (94, 'Incredible Iron Clock', 'product-1.jpg', 'Corporis nisi porro.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (95, 'Lightweight Bronze Pants', 'product-1.jpg', 'Quam optio accusamus enim soluta omnis minima.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (96, 'Intelligent Wool Wallet', 'product-1.jpg', 'Quia doloremque ut adipisci hic repellendus atque rerum.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (97, 'Incredible Granite Pants', 'product-1.jpg', 'Reprehenderit doloremque sed neque.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (98, 'Practical Rubber Bottle', 'product-1.jpg', 'Et suscipit est non optio ducimus architecto aliquid.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (99, 'Mediocre Silk Bottle', 'product-1.jpg', 'Quos minima voluptates dolor iste ratione.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (100, 'Small Leather Hat', 'product-1.jpg', 'Cumque et fuga corrupti sunt facilis.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (101, 'Small Linen Car', 'product-1.jpg', 'Omnis animi soluta eaque quos.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (102, 'Enormous Granite Shirt', 'product-1.jpg', 'Et consequatur aliquid aliquid tempore dolorum.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (103, 'Synergistic Steel Clock', 'product-1.jpg', 'Ut et quisquam accusamus sint sed ut sit.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (104, 'Ergonomic Steel Car', 'product-1.jpg', 'Vero corrupti tempore.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (105, 'Synergistic Granite Car', 'product-1.jpg', 'Mollitia veritatis facilis et.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (106, 'Practical Wool Bench', 'product-1.jpg', 'Sed repudiandae qui id.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (107, 'Sleek Concrete Car', 'product-1.jpg', 'Sed esse exercitationem delectus consequatur ipsa reprehenderit.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (108, 'Durable Cotton Watch', 'product-1.jpg', 'Dignissimos nostrum labore.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (109, 'Practical Leather Lamp', 'product-1.jpg', 'Animi et voluptas enim aut laboriosam unde.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (110, 'Sleek Steel Computer', 'product-1.jpg', 'Quia eaque a odit.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (111, 'Enormous Copper Knife', 'product-1.jpg', 'Eos et ut quaerat amet est ipsum est.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (112, 'Heavy Duty Plastic Shirt', 'product-1.jpg', 'Ullam est est.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (113, 'Ergonomic Silk Chair', 'product-1.jpg', 'Temporibus possimus eos qui assumenda.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (114, 'Intelligent Wooden Shoes', 'product-1.jpg', 'Ullam ratione fugit harum aliquid.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (115, 'Small Paper Hat', 'product-1.jpg', 'Voluptas voluptates veritatis aut eos tempore cum.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (116, 'Intelligent Granite Shirt', 'product-1.jpg', 'Facilis ratione quo.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (117, 'Small Silk Coat', 'product-1.jpg', 'Rem dolores et.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (118, 'Practical Steel Shirt', 'product-1.jpg', 'Quia mollitia omnis.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (119, 'Rustic Iron Chair', 'product-1.jpg', 'Magnam molestiae consequuntur et quia natus labore eum.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (120, 'Enormous Steel Shoes', 'product-1.jpg', 'Expedita quas ex necessitatibus.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (121, 'Incredible Plastic Plate', 'product-1.jpg', 'Nihil aliquid eos et quia laudantium vel voluptatem.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (122, 'Intelligent Granite Keyboard', 'product-1.jpg', 'Eligendi error nemo qui distinctio.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (123, 'Mediocre Leather Pants', 'product-1.jpg', 'Quidem velit tempora optio at non enim.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (124, 'Gorgeous Wool Chair', 'product-1.jpg', 'Quasi totam accusantium sed inventore.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (125, 'Mediocre Aluminum Keyboard', 'product-1.jpg', 'Aperiam aut nobis id illo magnam voluptas.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (126, 'Awesome Paper Computer', 'product-1.jpg', 'Doloremque molestias impedit.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (127, 'Small Linen Keyboard', 'product-1.jpg', 'Quia est sequi reprehenderit rerum fuga tempore.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (128, 'Durable Steel Bag', 'product-1.jpg', 'Architecto est et et consequatur quae.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (129, 'Practical Rubber Bench', 'product-1.jpg', 'Aut atque vel porro nemo veritatis et.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (130, 'Intelligent Concrete Knife', 'product-1.jpg', 'Quidem modi corporis ipsa quibusdam libero culpa.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (131, 'Small Silk Hat', 'product-1.jpg', 'Quam est aperiam accusantium quia nobis modi molestiae.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (132, 'Synergistic Marble Car', 'product-1.jpg', 'Recusandae animi deserunt consequuntur distinctio.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (133, 'Sleek Granite Chair', 'product-1.jpg', 'Minima qui aut pariatur.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (134, 'Ergonomic Granite Shoes', 'product-1.jpg', 'Nam id delectus in quas et totam sequi.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (135, 'Mediocre Steel Pants', 'product-1.jpg', 'Optio fuga cupiditate vitae nobis voluptates tempora consequatur.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (136, 'Enormous Rubber Watch', 'product-1.jpg', 'Minus placeat aut quos qui deleniti in nulla.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (137, 'Rustic Steel Clock', 'product-1.jpg', 'Mollitia consequatur dolorem vel facere.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (138, 'Gorgeous Steel Watch', 'product-1.jpg', 'Maiores est consequatur et.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (139, 'Mediocre Paper Keyboard', 'product-1.jpg', 'Voluptas sit dolorem pariatur voluptatem.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (140, 'Incredible Cotton Hat', 'product-1.jpg', 'Dolorem et quis.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (141, 'Enormous Wooden Hat', 'product-1.jpg', 'Fuga velit corporis perferendis dolor.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (142, 'Incredible Concrete Keyboard', 'product-1.jpg', 'Aut libero earum dignissimos.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (143, 'Enormous Bronze Lamp', 'product-1.jpg', 'Eligendi aut pariatur dolores dicta ex non esse.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (144, 'Heavy Duty Wool Chair', 'product-1.jpg', 'Ut distinctio unde.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (145, 'Enormous Plastic Lamp', 'product-1.jpg', 'Quisquam quos impedit ipsum iste voluptates animi.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (146, 'Small Concrete Watch', 'product-1.jpg', 'Ad reiciendis commodi officia natus voluptas quisquam.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (147, 'Enormous Leather Clock', 'product-1.jpg', 'Ut enim consequuntur error velit.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (148, 'Rustic Aluminum Bag', 'product-1.jpg', 'Est quas reprehenderit.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (149, 'Durable Wool Clock', 'product-1.jpg', 'Aut adipisci sint rerum natus.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (150, 'Synergistic Copper Watch', 'product-1.jpg', 'Vel reprehenderit fugiat sed fugit non rerum.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (151, 'Fantastic Linen Gloves', 'product-1.jpg', 'Rerum consequatur modi.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (152, 'Aerodynamic Wool Coat', 'product-1.jpg', 'Vel et eos earum est vitae maxime.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (153, 'Lightweight Wooden Keyboard', 'product-1.jpg', 'Quia tempora a odio iste numquam saepe ut.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (154, 'Rustic Granite Gloves', 'product-1.jpg', 'Iure et dolores reprehenderit ratione commodi eum reiciendis.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (155, 'Rustic Marble Watch', 'product-1.jpg', 'Ut dolorem provident.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (156, 'Mediocre Iron Hat', 'product-1.jpg', 'Veritatis libero officia.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (157, 'Lightweight Wool Knife', 'product-1.jpg', 'Et nobis est autem explicabo.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (158, 'Rustic Linen Table', 'product-1.jpg', 'Laboriosam quam autem officiis quis excepturi.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (159, 'Aerodynamic Leather Chair', 'product-1.jpg', 'Non dolorum omnis.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (160, 'Lightweight Rubber Table', 'product-1.jpg', 'Ut nisi consequuntur illo voluptatem laborum reprehenderit expedita.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (161, 'Mediocre Plastic Bench', 'product-1.jpg', 'Quis eaque sit ut voluptas rem ducimus.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (162, 'Incredible Paper Lamp', 'product-1.jpg', 'Itaque nisi minus.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (163, 'Durable Iron Table', 'product-1.jpg', 'Sit corporis ut ipsam sunt reiciendis.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (164, 'Lightweight Linen Knife', 'product-1.jpg', 'Unde provident velit amet.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (165, 'Synergistic Rubber Bag', 'product-1.jpg', 'Dolorem dolorem quia beatae non maxime possimus nihil.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (166, 'Incredible Steel Bag', 'product-1.jpg', 'Et qui et veniam molestiae blanditiis laborum aut.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (167, 'Heavy Duty Aluminum Computer', 'product-1.jpg', 'Ea veritatis eum omnis dignissimos in illo.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (168, 'Heavy Duty Wooden Car', 'product-1.jpg', 'Inventore repellendus aut.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (169, 'Intelligent Leather Bag', 'product-1.jpg', 'Sed facere distinctio.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (170, 'Gorgeous Copper Bag', 'product-1.jpg', 'Iusto magnam nihil debitis nemo pariatur.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (171, 'Awesome Leather Keyboard', 'product-1.jpg', 'Ullam consequatur deleniti qui quaerat aut eveniet accusamus.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (172, 'Practical Rubber Computer', 'product-1.jpg', 'Suscipit et saepe voluptatem praesentium quaerat eius numquam.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (173, 'Enormous Copper Bench', 'product-1.jpg', 'Fugiat similique voluptas quo iusto.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (174, 'Mediocre Silk Wallet', 'product-1.jpg', 'Quo voluptas quis impedit assumenda eius adipisci.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (175, 'Practical Steel Plate', 'product-1.jpg', 'Modi necessitatibus iure est molestiae.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (176, 'Lightweight Wool Coat', 'product-1.jpg', 'Modi incidunt in nihil sunt dolorem voluptas quae.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (177, 'Mediocre Bronze Shoes', 'product-1.jpg', 'Aut placeat eos occaecati id.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (178, 'Fantastic Silk Knife', 'product-1.jpg', 'Repellat tenetur et.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (179, 'Aerodynamic Bronze Clock', 'product-1.jpg', 'Mollitia aut unde recusandae ab distinctio ut velit.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (180, 'Practical Granite Car', 'product-1.jpg', 'Quidem nesciunt omnis beatae sed est.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (181, 'Sleek Marble Coat', 'product-1.jpg', 'Iusto nihil nulla veritatis quae est.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (182, 'Aerodynamic Plastic Plate', 'product-1.jpg', 'Velit consequatur perspiciatis dolorum facere iusto.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (183, 'Gorgeous Concrete Coat', 'product-1.jpg', 'Est id et unde.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (184, 'Lightweight Rubber Computer', 'product-1.jpg', 'Dolorem libero voluptate quia autem qui omnis.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (185, 'Fantastic Copper Knife', 'product-1.jpg', 'Debitis neque illum.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (186, 'Sleek Marble Computer', 'product-1.jpg', 'Officiis sit quis a.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (187, 'Fantastic Bronze Computer', 'product-1.jpg', 'Sunt necessitatibus placeat blanditiis nesciunt suscipit.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (188, 'Lightweight Linen Shoes', 'product-1.jpg', 'Quia vel itaque et neque quia deleniti tenetur.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (189, 'Aerodynamic Rubber Shoes', 'product-1.jpg', 'Vel magni dolor officiis sed ea repudiandae.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (190, 'Aerodynamic Plastic Coat', 'product-1.jpg', 'Eaque ullam quo ea dolorum error aut.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (191, 'Small Marble Car', 'product-1.jpg', 'Perferendis eum similique culpa quo.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (192, 'Awesome Marble Computer', 'product-1.jpg', 'Dolor sapiente ipsam et reiciendis.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (193, 'Practical Wool Pants', 'product-1.jpg', 'Est aperiam quo magnam repellat repellendus earum.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (194, 'Enormous Rubber Table', 'product-1.jpg', 'Tenetur hic pariatur consequuntur eos vitae sunt.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (195, 'Small Marble Wallet', 'product-1.jpg', 'Pariatur laborum velit repellendus.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 1, '');
INSERT INTO `products` VALUES (196, 'Mediocre Rubber Computer', 'product-1.jpg', 'Inventore totam eaque aut ut velit doloremque.', '2024-04-04 13:27:18', '2024-04-04 13:27:18', 2, '');
INSERT INTO `products` VALUES (197, 'Synergistic Paper Shirt', 'product-1.jpg', 'Non asperiores doloribus quod magnam voluptate.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (198, 'Ergonomic Concrete Gloves', 'product-1.jpg', 'Asperiores sint quo expedita.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (199, 'Lightweight Concrete Watch', 'product-1.jpg', 'Id vitae reiciendis iure quidem.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (200, 'Enormous Paper Knife', 'product-1.jpg', 'Esse cupiditate ducimus.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (201, 'Durable Copper Hat', 'product-1.jpg', 'Sunt molestiae tempora debitis minus.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (202, 'Incredible Granite Bench', 'product-1.jpg', 'Et tenetur vel a quaerat nam.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (203, 'Fantastic Leather Computer', 'product-1.jpg', 'Beatae quam maiores culpa at.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (204, 'Ergonomic Paper Pants', 'product-1.jpg', 'Iste est est qui molestiae.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (205, 'Fantastic Wool Coat', 'product-1.jpg', 'Sit est exercitationem natus accusantium officiis nihil nihil.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (206, 'Enormous Silk Hat', 'product-1.jpg', 'Ad voluptatum a non numquam.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (207, 'Mediocre Linen Table', 'product-1.jpg', 'Animi quam ipsa ut est laborum ex odit.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (208, 'Small Wool Knife', 'product-1.jpg', 'Omnis quos corporis quo voluptates.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (209, 'Practical Iron Wallet', 'product-1.jpg', 'Esse magnam non amet consectetur.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (210, 'Enormous Bronze Plate', 'product-1.jpg', 'Omnis ad voluptatem ipsum est aut vel.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (211, 'Awesome Iron Lamp', 'product-1.jpg', 'Error odio facere et numquam.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (212, 'Awesome Copper Shoes', 'product-1.jpg', 'Atque ab aut.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (213, 'Heavy Duty Iron Bag', 'product-1.jpg', 'Quo nostrum ut qui quos doloribus sit.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (214, 'Lightweight Cotton Plate', 'product-1.jpg', 'Illum enim porro.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (215, 'Ergonomic Copper Wallet', 'product-1.jpg', 'Occaecati placeat ea.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (216, 'Practical Aluminum Wallet', 'product-1.jpg', 'Est possimus occaecati quia est dolores eos.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (217, 'Enormous Linen Lamp', 'product-1.jpg', 'Cumque tempore earum sed.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (218, 'Gorgeous Marble Car', 'product-1.jpg', 'Veniam necessitatibus velit.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (219, 'Durable Marble Coat', 'product-1.jpg', 'Doloribus voluptas fugit delectus deserunt vel.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (220, 'Durable Bronze Car', 'product-1.jpg', 'Sit sint dicta.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (221, 'Heavy Duty Granite Lamp', 'product-1.jpg', 'Iure excepturi et velit.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (222, 'Ergonomic Leather Computer', 'product-1.jpg', 'Dolor numquam dicta et incidunt facere.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (223, 'Aerodynamic Paper Wallet', 'product-1.jpg', 'Architecto pariatur voluptatibus non.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (224, 'Practical Copper Bench', 'product-1.jpg', 'Voluptas officiis qui saepe porro.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (225, 'Lightweight Linen Clock', 'product-1.jpg', 'Aut non quas et velit non at eum.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (226, 'Practical Linen Shirt', 'product-1.jpg', 'Eaque magnam accusamus voluptatum quae cumque.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (227, 'Durable Steel Shirt', 'product-1.jpg', 'Molestiae pariatur perspiciatis.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (228, 'Practical Copper Wallet', 'product-1.jpg', 'Ut sunt iure et.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (229, 'Practical Silk Bag', 'product-1.jpg', 'Qui alias magnam sunt a velit tempora.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (230, 'Awesome Cotton Wallet', 'product-1.jpg', 'Provident quis quaerat quos assumenda sunt.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (231, 'Rustic Wool Bench', 'product-1.jpg', 'Et est et autem.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (232, 'Durable Iron Clock', 'product-1.jpg', 'Commodi voluptatem earum et ipsa.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (233, 'Awesome Silk Bench', 'product-1.jpg', 'Eaque consequatur nisi sunt ipsam.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (234, 'Gorgeous Wooden Car', 'product-1.jpg', 'Sed labore cupiditate nam.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (235, 'Lightweight Marble Computer', 'product-1.jpg', 'Harum repudiandae numquam delectus aut voluptas dolorum ad.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (236, 'Enormous Marble Plate', 'product-1.jpg', 'Et maxime quis debitis sit voluptas iste ratione.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (237, 'Aerodynamic Rubber Table', 'product-1.jpg', 'Excepturi exercitationem nihil possimus voluptatibus repellat accusamus.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (238, 'Aerodynamic Leather Wallet', 'product-1.jpg', 'Ut velit numquam.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (239, 'Incredible Plastic Hat', 'product-1.jpg', 'Sed atque possimus est.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (240, 'Durable Granite Shirt', 'product-1.jpg', 'Odit autem fugiat.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (241, 'Intelligent Copper Pants', 'product-1.jpg', 'Explicabo qui neque consequatur ipsa.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (242, 'Intelligent Paper Chair', 'product-1.jpg', 'Ut ipsa nemo ullam doloribus qui omnis libero.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (243, 'Synergistic Plastic Bag', 'product-1.jpg', 'Omnis minima provident vitae.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (244, 'Intelligent Steel Gloves', 'product-1.jpg', 'Officiis assumenda vitae cumque deserunt.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (245, 'Enormous Silk Shoes', 'product-1.jpg', 'Laborum doloremque odit atque odit dignissimos optio iure.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (246, 'Heavy Duty Bronze Table', 'product-1.jpg', 'Et rem dolor perferendis iste.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (247, 'Incredible Wool Computer', 'product-1.jpg', 'Iure molestiae quasi et voluptas.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (248, 'Awesome Wooden Clock', 'product-1.jpg', 'Quibusdam animi sequi quo sint eaque voluptatum.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (249, 'Gorgeous Linen Car', 'product-1.jpg', 'Et atque iure.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (250, 'Lightweight Paper Keyboard', 'product-1.jpg', 'Dolores vero id et reiciendis aperiam corrupti.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (251, 'Heavy Duty Copper Lamp', 'product-1.jpg', 'Perferendis sit tempora est expedita sequi.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (252, 'Heavy Duty Wool Computer', 'product-1.jpg', 'Reprehenderit omnis quod repellat illum sapiente.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (253, 'Mediocre Concrete Clock', 'product-1.jpg', 'Dolorem id et minima accusantium quo.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (254, 'Ergonomic Concrete Hat', 'product-1.jpg', 'Rem impedit nemo corporis autem eos cupiditate inventore.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (255, 'Small Silk Car', 'product-1.jpg', 'Eos inventore magni alias et nisi non omnis.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (256, 'Small Marble Keyboard', 'product-1.jpg', 'Error maxime dolorum fugiat.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (257, 'Fantastic Cotton Coat', 'product-1.jpg', 'Tempore modi earum non a deserunt voluptatibus et.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (258, 'Ergonomic Copper Pants', 'product-1.jpg', 'Nulla laudantium nihil aperiam nemo.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (259, 'Practical Steel Hat', 'product-1.jpg', 'Delectus animi magni nihil distinctio tempore.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (260, 'Aerodynamic Paper Bottle', 'product-1.jpg', 'Enim in aut voluptatum quia similique maiores.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (261, 'Small Wool Bag', 'product-1.jpg', 'Debitis vitae et odio nisi rerum.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (262, 'Sleek Granite Car', 'product-1.jpg', 'Fuga eius vitae qui.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (263, 'Aerodynamic Bronze Shoes', 'product-1.jpg', 'Earum sunt qui consequuntur qui eveniet doloribus.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (264, 'Enormous Paper Bottle', 'product-1.jpg', 'Aut esse aut sint repudiandae nisi reiciendis ut.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (265, 'Awesome Rubber Shoes', 'product-1.jpg', 'Omnis ut rerum nisi ut aut.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (266, 'Gorgeous Marble Plate', 'product-1.jpg', 'Aut voluptate odit mollitia dolore corporis.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (267, 'Fantastic Rubber Keyboard', 'product-1.jpg', 'Accusamus atque enim omnis.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (268, 'Sleek Paper Lamp', 'product-1.jpg', 'Hic debitis ut voluptates.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (269, 'Synergistic Wooden Watch', 'product-1.jpg', 'Perspiciatis sapiente id harum hic laboriosam.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (270, 'Incredible Cotton Bottle', 'product-1.jpg', 'Consequatur ullam commodi incidunt quasi.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (271, 'Rustic Paper Hat', 'product-1.jpg', 'Vel esse est et quibusdam tenetur.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (272, 'Sleek Aluminum Hat', 'product-1.jpg', 'Hic libero occaecati animi porro.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (273, 'Mediocre Leather Lamp', 'product-1.jpg', 'Et maxime qui omnis voluptatem culpa totam et.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (274, 'Heavy Duty Linen Shirt', 'product-1.jpg', 'Enim repellendus ipsa est.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (275, 'Mediocre Silk Computer', 'product-1.jpg', 'Occaecati quia rerum.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (276, 'Fantastic Paper Gloves', 'product-1.jpg', 'Nemo rem repudiandae veritatis.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (277, 'Practical Silk Clock', 'product-1.jpg', 'Sit blanditiis expedita voluptas est dolorem sed alias.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (278, 'Awesome Rubber Table', 'product-1.jpg', 'Pariatur ex error dolorem quod.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (279, 'Intelligent Aluminum Lamp', 'product-1.jpg', 'Animi a ducimus et.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (280, 'Intelligent Marble Table', 'product-1.jpg', 'Nostrum vel sequi ut nemo vitae totam consectetur.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (281, 'Gorgeous Concrete Clock', 'product-1.jpg', 'Ut autem libero tempore enim est hic.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (282, 'Mediocre Rubber Clock', 'product-1.jpg', 'Neque est aliquid possimus itaque placeat.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (283, 'Aerodynamic Bronze Chair', 'product-1.jpg', 'Dolores debitis cum sed dolorem molestias vel et.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (284, 'Awesome Paper Shirt', 'product-1.jpg', 'Voluptas laudantium rerum placeat quisquam.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (285, 'Gorgeous Steel Pants', 'product-1.jpg', 'Consequuntur maxime porro beatae alias earum enim.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (286, 'Mediocre Cotton Shirt', 'product-1.jpg', 'Mollitia minima ducimus et.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (287, 'Intelligent Silk Wallet', 'product-1.jpg', 'Necessitatibus eos laboriosam eaque fugit dolorem.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (288, 'Intelligent Cotton Lamp', 'product-1.jpg', 'Est ratione nemo sed dolores.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (289, 'Heavy Duty Wool Hat', 'product-1.jpg', 'Autem omnis maiores nam ipsa consequuntur earum.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (290, 'Fantastic Wool Lamp', 'product-1.jpg', 'Et numquam rerum omnis ut.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (291, 'Awesome Aluminum Lamp', 'product-1.jpg', 'Officia quasi vel reprehenderit delectus fugiat.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (292, 'Rustic Plastic Watch', 'product-1.jpg', 'Earum perferendis consequatur ab ut et.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (293, 'Mediocre Wooden Keyboard', 'product-1.jpg', 'Soluta maxime dignissimos officiis voluptatem placeat vel.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (294, 'Aerodynamic Wool Knife', 'product-1.jpg', 'Magni libero et autem ex reiciendis dolores.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (295, 'Lightweight Concrete Pants', 'product-1.jpg', 'Officiis totam sit et qui necessitatibus quis.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (296, 'Synergistic Iron Computer', 'product-1.jpg', 'Nemo aliquam aut earum rem ut.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (297, 'Durable Leather Bottle', 'product-1.jpg', 'Suscipit enim rerum.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (298, 'Ergonomic Aluminum Bench', 'product-1.jpg', 'Nobis eveniet ipsam voluptatem quia velit nemo aut.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (299, 'Mediocre Copper Table', 'product-1.jpg', 'Consequatur neque beatae beatae maxime libero excepturi.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (300, 'Synergistic Silk Gloves', 'product-1.jpg', 'Magni voluptatem id accusantium ut.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (301, 'Intelligent Bronze Bench', 'product-1.jpg', 'Doloribus est et.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (302, 'Gorgeous Concrete Car', 'product-1.jpg', 'Illo voluptatem vel.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (303, 'Awesome Rubber Plate', 'product-1.jpg', 'Est similique ut deserunt repudiandae debitis.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (304, 'Incredible Wool Keyboard', 'product-1.jpg', 'Ut quibusdam blanditiis voluptatibus voluptatem repudiandae.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (305, 'Awesome Aluminum Wallet', 'product-1.jpg', 'Quis et repellendus a.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (306, 'Practical Plastic Pants', 'product-1.jpg', 'Beatae quibusdam non aut sequi optio culpa repudiandae.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (307, 'Intelligent Granite Bottle', 'product-1.jpg', 'Cupiditate minus enim.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (308, 'Heavy Duty Silk Hat', 'product-1.jpg', 'Odit voluptatem ab fugit animi.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (309, 'Sleek Marble Knife', 'product-1.jpg', 'Eligendi dolorum vel labore qui officiis quo.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (310, 'Aerodynamic Copper Knife', 'product-1.jpg', 'Perferendis voluptatem et dolores quas laudantium quis velit.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (311, 'Enormous Plastic Bag', 'product-1.jpg', 'Perspiciatis earum minima sunt odit nihil.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (312, 'Fantastic Concrete Coat', 'product-1.jpg', 'Nobis ipsum quam voluptatibus non sint ipsam et.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (313, 'Synergistic Iron Table', 'product-1.jpg', 'Eos et voluptatem nulla nostrum temporibus alias.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (314, 'Synergistic Silk Hat', 'product-1.jpg', 'Et et vel beatae aut.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (315, 'Small Leather Pants', 'product-1.jpg', 'Inventore minima necessitatibus nisi.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (316, 'Ergonomic Rubber Lamp', 'product-1.jpg', 'Ut quas molestias earum natus at voluptatem nostrum.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (317, 'Sleek Copper Lamp', 'product-1.jpg', 'Ut vel et quo voluptas quia qui cum.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (318, 'Mediocre Bronze Keyboard', 'product-1.jpg', 'Doloremque tempora ipsa qui.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (319, 'Rustic Bronze Computer', 'product-1.jpg', 'Voluptas corrupti fugit reprehenderit nihil pariatur non.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (320, 'Fantastic Wool Watch', 'product-1.jpg', 'Ea totam qui.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (321, 'Ergonomic Marble Knife', 'product-1.jpg', 'Minima dignissimos odit nihil aperiam qui deleniti voluptas.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (322, 'Durable Silk Plate', 'product-1.jpg', 'Laboriosam minima consectetur corporis facilis error provident omnis.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (323, 'Sleek Cotton Bench', 'product-1.jpg', 'At ut atque cupiditate error dolor facere ex.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (324, 'Rustic Aluminum Table', 'product-1.jpg', 'Harum reprehenderit error.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (325, 'Awesome Plastic Lamp', 'product-1.jpg', 'Et est neque eligendi ut.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (326, 'Fantastic Concrete Bottle', 'product-1.jpg', 'Blanditiis sunt adipisci aut aut mollitia vel sint.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (327, 'Durable Paper Lamp', 'product-1.jpg', 'Sint id est et ullam voluptas qui eligendi.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (328, 'Heavy Duty Aluminum Plate', 'product-1.jpg', 'Quam nemo aut aspernatur sit distinctio sit voluptatem.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (329, 'Lightweight Silk Hat', 'product-1.jpg', 'Quis optio provident.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (330, 'Intelligent Silk Hat', 'product-1.jpg', 'Assumenda ut hic laudantium minima et omnis.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (331, 'Rustic Rubber Coat', 'product-1.jpg', 'Incidunt ut adipisci voluptatibus error.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (332, 'Aerodynamic Iron Pants', 'product-1.jpg', 'Error doloremque necessitatibus accusamus qui excepturi eaque similique.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (333, 'Aerodynamic Linen Car', 'product-1.jpg', 'Delectus et harum repudiandae autem non autem similique.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (334, 'Gorgeous Wooden Table', 'product-1.jpg', 'Numquam ut eos minima impedit.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (335, 'Small Granite Chair', 'product-1.jpg', 'Itaque ratione at dolorem architecto aliquam nesciunt ipsa.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 2, '');
INSERT INTO `products` VALUES (336, 'Heavy Duty Aluminum Shirt', 'product-1.jpg', 'Consequatur vel quod.', '2024-04-04 13:27:19', '2024-04-04 13:27:19', 1, '');
INSERT INTO `products` VALUES (337, 'Gorgeous Wooden Knife', 'product-1.jpg', 'Aut eveniet deleniti minus.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (338, 'Fantastic Cotton Shoes', 'product-1.jpg', 'Id ut exercitationem explicabo quasi libero sunt porro.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (339, 'Ergonomic Iron Keyboard', 'product-1.jpg', 'Sunt voluptate et totam ut ea.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (340, 'Intelligent Rubber Hat', 'product-1.jpg', 'Quod qui dolores in non.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (341, 'Sleek Rubber Hat', 'product-1.jpg', 'Saepe ullam debitis iusto.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (342, 'Practical Linen Plate', 'product-1.jpg', 'Sit ut sit mollitia.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (343, 'Practical Granite Shirt', 'product-1.jpg', 'Nisi ullam officiis molestiae.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (344, 'Small Wooden Wallet', 'product-1.jpg', 'Asperiores quia ea minima temporibus.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (345, 'Small Concrete Bench', 'product-1.jpg', 'Ipsa sit asperiores rerum commodi id.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (346, 'Fantastic Leather Bottle', 'product-1.jpg', 'Sint et voluptate nemo qui.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (347, 'Awesome Steel Knife', 'product-1.jpg', 'Laboriosam maiores suscipit doloribus quam.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (348, 'Enormous Rubber Computer', 'product-1.jpg', 'Voluptatem eos ducimus.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (349, 'Awesome Cotton Hat', 'product-1.jpg', 'Reprehenderit sequi optio itaque ut explicabo ipsam.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (350, 'Small Rubber Shoes', 'product-1.jpg', 'Placeat vitae nihil numquam eos ipsa reiciendis quo.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (351, 'Gorgeous Leather Keyboard', 'product-1.jpg', 'Non nostrum vero voluptatem non nemo.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (352, 'Mediocre Concrete Plate', 'product-1.jpg', 'Eos nemo et sint occaecati.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (353, 'Fantastic Iron Knife', 'product-1.jpg', 'Sapiente fuga mollitia.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (354, 'Lightweight Wooden Gloves', 'product-1.jpg', 'Omnis provident dignissimos.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (355, 'Practical Leather Coat', 'product-1.jpg', 'Nisi sed iusto.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (356, 'Gorgeous Linen Bag', 'product-1.jpg', 'Ut in iure.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (357, 'Durable Iron Bench', 'product-1.jpg', 'Eum a sunt tempore.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (358, 'Aerodynamic Bronze Bench', 'product-1.jpg', 'Sapiente sit maxime nemo sunt ut.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (359, 'Incredible Iron Bag', 'product-1.jpg', 'At odit illum quibusdam.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (360, 'Practical Marble Gloves', 'product-1.jpg', 'Consequuntur aut et et voluptatum.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (361, 'Practical Marble Car', 'product-1.jpg', 'Unde inventore sit aspernatur quibusdam.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (362, 'Fantastic Concrete Shirt', 'product-1.jpg', 'A quia commodi repellat.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (363, 'Practical Granite Clock', 'product-1.jpg', 'Perspiciatis nemo odio error libero.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (364, 'Incredible Bronze Computer', 'product-1.jpg', 'Voluptatum aliquam non odio at et eum tenetur.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (365, 'Sleek Paper Car', 'product-1.jpg', 'Qui similique animi.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (366, 'Enormous Cotton Knife', 'product-1.jpg', 'Dolorem natus iusto nemo rem commodi.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (367, 'Aerodynamic Concrete Car', 'product-1.jpg', 'Aut voluptatem sed quis molestiae et.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (368, 'Small Rubber Gloves', 'product-1.jpg', 'Sunt et laborum porro reprehenderit neque velit.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (369, 'Practical Leather Gloves', 'product-1.jpg', 'Corporis doloremque et eos earum.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (370, 'Rustic Cotton Hat', 'product-1.jpg', 'Qui asperiores sunt iure nostrum tempore.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (371, 'Sleek Steel Hat', 'product-1.jpg', 'Quia soluta excepturi natus qui vitae.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (372, 'Mediocre Leather Knife', 'product-1.jpg', 'Iste natus aliquam officia iste ducimus maxime.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (373, 'Gorgeous Paper Knife', 'product-1.jpg', 'Repellendus odit provident optio.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (374, 'Intelligent Cotton Wallet', 'product-1.jpg', 'Voluptatum quae tempore.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (375, 'Lightweight Leather Chair', 'product-1.jpg', 'Corrupti dolorem adipisci deleniti minima animi.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (376, 'Fantastic Aluminum Shoes', 'product-1.jpg', 'Facilis provident sit alias iure et.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (377, 'Fantastic Plastic Plate', 'product-1.jpg', 'Eligendi enim a blanditiis at dicta at.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (378, 'Mediocre Marble Keyboard', 'product-1.jpg', 'Est sit doloribus et sit molestiae ut quod.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (379, 'Mediocre Rubber Bench', 'product-1.jpg', 'Architecto nulla consequuntur et molestiae sed vel.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (380, 'Small Plastic Gloves', 'product-1.jpg', 'Ut ipsum ut et.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (381, 'Synergistic Wooden Lamp', 'product-1.jpg', 'Inventore quae dolores labore perspiciatis reiciendis.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (382, 'Durable Aluminum Hat', 'product-1.jpg', 'Iste iure et debitis omnis minus perferendis est.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (383, 'Awesome Granite Bottle', 'product-1.jpg', 'Nam est provident beatae commodi nulla voluptas hic.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (384, 'Sleek Silk Pants', 'product-1.jpg', 'Dolor impedit et exercitationem est.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (385, 'Durable Granite Lamp', 'product-1.jpg', 'Distinctio recusandae sed nulla.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (386, 'Incredible Copper Shirt', 'product-1.jpg', 'Cumque et et facere voluptatem.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (387, 'Fantastic Rubber Watch', 'product-1.jpg', 'Quo reiciendis alias natus ea aut.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (388, 'Synergistic Steel Lamp', 'product-1.jpg', 'Dolorem voluptas delectus numquam quaerat animi.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (389, 'Incredible Aluminum Car', 'product-1.jpg', 'Quia eos minima iusto.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (390, 'Aerodynamic Aluminum Table', 'product-1.jpg', 'Molestiae ut ea laborum animi.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (391, 'Durable Wool Keyboard', 'product-1.jpg', 'Consequuntur qui sed rerum ut.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (392, 'Synergistic Aluminum Keyboard', 'product-1.jpg', 'Vel sed delectus repellendus et aut magni.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (393, 'Lightweight Silk Computer', 'product-1.jpg', 'Eos sint qui ex maiores quia.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (394, 'Practical Wooden Knife', 'product-1.jpg', 'Reiciendis aut quis dolore.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (395, 'Small Steel Clock', 'product-1.jpg', 'Occaecati suscipit molestiae.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (396, 'Mediocre Wool Clock', 'product-1.jpg', 'Ipsa id repudiandae laudantium distinctio ipsum quis.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (397, 'Fantastic Cotton Bag', 'product-1.jpg', 'Eveniet blanditiis quia.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (398, 'Incredible Concrete Bottle', 'product-1.jpg', 'Laboriosam architecto consequatur.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (399, 'Fantastic Marble Plate', 'product-1.jpg', 'Magni voluptatibus sit modi reprehenderit magni sequi reiciendis.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (400, 'Mediocre Steel Wallet', 'product-1.jpg', 'Quae ut illo consequatur vero maiores voluptatibus.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (401, 'Intelligent Rubber Watch', 'product-1.jpg', 'Rerum odio nihil.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (402, 'Durable Silk Bench', 'product-1.jpg', 'Assumenda facilis velit voluptatem.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (403, 'Lightweight Plastic Bench', 'product-1.jpg', 'Voluptas quam sit quia quia.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (404, 'Sleek Wool Pants', 'product-1.jpg', 'Ipsa repudiandae deleniti quasi labore odit.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (405, 'Sleek Aluminum Chair', 'product-1.jpg', 'Perspiciatis repellat officiis assumenda minima quo ipsam.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (406, 'Heavy Duty Bronze Watch', 'product-1.jpg', 'Sit sint odit sit delectus rem eum.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (407, 'Intelligent Aluminum Bench', 'product-1.jpg', 'Totam odit at et.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (408, 'Enormous Iron Computer', 'product-1.jpg', 'Molestiae harum ullam culpa quod.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (409, 'Practical Wooden Shoes', 'product-1.jpg', 'Ab accusamus repellendus quia nihil hic quaerat natus.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (410, 'Intelligent Bronze Shoes', 'product-1.jpg', 'Earum corrupti aut est voluptatem voluptatem.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (411, 'Durable Bronze Computer', 'product-1.jpg', 'Esse quo ab ipsam et non facilis.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (412, 'Incredible Copper Computer', 'product-1.jpg', 'Quia amet consequatur.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (413, 'Gorgeous Bronze Coat', 'product-1.jpg', 'Non consequatur odio nulla qui.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (414, 'Ergonomic Silk Bench', 'product-1.jpg', 'Quam est sint quia quia.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (415, 'Ergonomic Leather Wallet', 'product-1.jpg', 'Repellat autem ducimus veritatis ea error nihil non.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (416, 'Durable Leather Plate', 'product-1.jpg', 'Rerum culpa delectus distinctio repudiandae vero et.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (417, 'Synergistic Bronze Bottle', 'product-1.jpg', 'Praesentium voluptatem rerum cupiditate harum non.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (418, 'Lightweight Rubber Pants', 'product-1.jpg', 'Delectus nihil officiis voluptas modi voluptas.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (419, 'Fantastic Wooden Plate', 'product-1.jpg', 'Nihil quidem vitae.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (420, 'Durable Rubber Computer', 'product-1.jpg', 'Commodi quia incidunt aut aut sequi quo cupiditate.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (421, 'Lightweight Wool Lamp', 'product-1.jpg', 'Excepturi eos architecto est a nihil iste.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (422, 'Mediocre Paper Car', 'product-1.jpg', 'Eligendi fugit molestias ut accusamus.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (423, 'Sleek Plastic Watch', 'product-1.jpg', 'Accusantium rerum rerum omnis.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (424, 'Awesome Copper Plate', 'product-1.jpg', 'Et aut cum voluptatum rem voluptatem quaerat et.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (425, 'Aerodynamic Concrete Shirt', 'product-1.jpg', 'Voluptatem quia eum tenetur molestiae.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (426, 'Aerodynamic Linen Shoes', 'product-1.jpg', 'Magni sunt provident labore similique.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (427, 'Practical Iron Gloves', 'product-1.jpg', 'Tenetur sapiente reiciendis et.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (428, 'Awesome Marble Clock', 'product-1.jpg', 'Omnis sed voluptates dignissimos laudantium nulla cum.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (429, 'Enormous Plastic Chair', 'product-1.jpg', 'Consequatur reiciendis nemo deleniti ut ut excepturi.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (430, 'Synergistic Paper Chair', 'product-1.jpg', 'Amet maiores non.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (431, 'Heavy Duty Wooden Bag', 'product-1.jpg', 'Unde aut nemo.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (432, 'Rustic Wooden Plate', 'product-1.jpg', 'Earum nihil ratione.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (433, 'Ergonomic Copper Bench', 'product-1.jpg', 'Et earum et cum nisi.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (434, 'Ergonomic Paper Computer', 'product-1.jpg', 'Repudiandae perspiciatis sed doloremque repudiandae qui unde officiis.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (435, 'Durable Bronze Knife', 'product-1.jpg', 'Sit architecto et velit sunt.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (436, 'Durable Concrete Chair', 'product-1.jpg', 'Nihil eaque est sit numquam.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (437, 'Sleek Steel Car', 'product-1.jpg', 'Magnam magni ad et harum.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (438, 'Small Wool Pants', 'product-1.jpg', 'Minima eligendi odio neque officiis omnis.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (439, 'Rustic Concrete Bottle', 'product-1.jpg', 'Quis sit consequuntur modi et.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (440, 'Gorgeous Rubber Watch', 'product-1.jpg', 'Facere veniam soluta id vel.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (441, 'Aerodynamic Marble Hat', 'product-1.jpg', 'Neque nemo aut officiis aut.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (442, 'Small Marble Plate', 'product-1.jpg', 'Commodi molestiae id dolore debitis.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (443, 'Enormous Wool Coat', 'product-1.jpg', 'Quia eum voluptatem labore provident quos maiores.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (444, 'Lightweight Copper Table', 'product-1.jpg', 'Illo dolorum neque et ab.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (445, 'Rustic Bronze Coat', 'product-1.jpg', 'Iusto sunt repellendus.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (446, 'Awesome Linen Chair', 'product-1.jpg', 'Necessitatibus ipsum hic ex.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (447, 'Awesome Steel Keyboard', 'product-1.jpg', 'Distinctio consequuntur velit iusto dolores eveniet.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (448, 'Synergistic Rubber Wallet', 'product-1.jpg', 'Officiis sed rem distinctio quod.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (449, 'Enormous Aluminum Chair', 'product-1.jpg', 'Optio sunt fuga delectus nulla.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (450, 'Sleek Wool Keyboard', 'product-1.jpg', 'Laboriosam ipsum debitis architecto.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (451, 'Sleek Granite Wallet', 'product-1.jpg', 'Adipisci corrupti facilis perferendis aut.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (452, 'Small Plastic Chair', 'product-1.jpg', 'Exercitationem perferendis aperiam quidem qui.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (453, 'Gorgeous Rubber Wallet', 'product-1.jpg', 'Qui labore sint impedit.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (454, 'Synergistic Granite Bag', 'product-1.jpg', 'Eum ut dolorem illo iure.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (455, 'Heavy Duty Granite Shirt', 'product-1.jpg', 'Ut et consectetur quae et aliquid modi.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (456, 'Intelligent Marble Bag', 'product-1.jpg', 'Veritatis eos deleniti mollitia.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (457, 'Synergistic Steel Bag', 'product-1.jpg', 'Quis est ipsa inventore totam sunt.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (458, 'Ergonomic Granite Lamp', 'product-1.jpg', 'Nulla asperiores cumque atque.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (459, 'Ergonomic Wool Wallet', 'product-1.jpg', 'Animi nihil qui quo.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (460, 'Durable Silk Hat', 'product-1.jpg', 'Iusto earum sed nulla sequi nemo asperiores et.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (461, 'Aerodynamic Granite Coat', 'product-1.jpg', 'Libero et omnis dolorem corrupti animi qui.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (462, 'Practical Concrete Bottle', 'product-1.jpg', 'Cupiditate rerum nulla saepe enim eaque nihil.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (463, 'Practical Paper Table', 'product-1.jpg', 'Deserunt ex officiis natus reiciendis magnam.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (464, 'Ergonomic Granite Coat', 'product-1.jpg', 'Quod officiis et repudiandae eaque et similique consequatur.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (465, 'Aerodynamic Wool Gloves', 'product-1.jpg', 'Ea quaerat sunt et non aut.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 1, '');
INSERT INTO `products` VALUES (466, 'Lightweight Aluminum Chair', 'product-1.jpg', 'Maiores quo quo dolorem.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (467, 'Heavy Duty Cotton Plate', 'product-1.jpg', 'Deserunt dolores a quam velit doloremque totam.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (468, 'Gorgeous Silk Keyboard', 'product-1.jpg', 'Hic voluptatum laborum omnis non voluptatem neque.', '2024-04-04 13:27:20', '2024-04-04 13:27:20', 2, '');
INSERT INTO `products` VALUES (469, 'Heavy Duty Concrete Gloves', 'product-1.jpg', 'Quia quis rerum.', '2024-04-04 13:27:21', '2024-04-04 13:27:21', 1, '');
INSERT INTO `products` VALUES (470, 'Heavy Duty Linen Bottle', 'product-1.jpg', 'Neque distinctio qui autem qui aliquam rerum sunt.', '2024-04-04 13:27:21', '2024-04-04 13:27:21', 1, '');
INSERT INTO `products` VALUES (471, 'Aerodynamic Paper Shirt', 'product-1.jpg', 'Voluptate quas reprehenderit.', '2024-04-04 13:27:21', '2024-04-04 13:27:21', 1, '');
INSERT INTO `products` VALUES (472, 'Gorgeous Cotton Gloves', 'product-1.jpg', 'Ut dolor aut quis voluptates necessitatibus omnis.', '2024-04-04 13:27:21', '2024-04-04 13:27:21', 1, '');
INSERT INTO `products` VALUES (473, 'Durable Marble Hat', 'product-1.jpg', 'Ut sit voluptatum ex aut sit.', '2024-04-04 13:27:21', '2024-04-04 13:27:21', 2, '');
INSERT INTO `products` VALUES (474, 'Lightweight Aluminum Hat', 'product-1.jpg', 'Nam sed est fugit eius.', '2024-04-04 13:27:21', '2024-04-04 13:27:21', 2, '');
INSERT INTO `products` VALUES (475, 'ipad pro 2013', 'product-1.jpg', 'this is description', '2024-04-09 01:39:23', '2024-04-09 01:39:23', 1, '');
INSERT INTO `products` VALUES (476, 'ipad pro 2013', 'product-1.jpg', 'this is description', '2024-04-09 01:44:19', '2024-04-09 01:44:19', 1, '<p>This is a <strong>sample</strong> product.</p>');

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` int NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (0, 'GUESS');
INSERT INTO `roles` VALUES (1, 'USER');
INSERT INTO `roles` VALUES (2, 'ADMIN');

-- ----------------------------
-- Table structure for social_account
-- ----------------------------
DROP TABLE IF EXISTS `social_account`;
CREATE TABLE `social_account`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider` varchar(20) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `provider_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `email` varchar(150) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `user_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `social_account_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of social_account
-- ----------------------------

-- ----------------------------
-- Table structure for tokens
-- ----------------------------
DROP TABLE IF EXISTS `tokens`;
CREATE TABLE `tokens`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` varchar(255) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `token_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `expiration_date` datetime NULL DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expired` tinyint(1) NOT NULL,
  `user_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `token`(`token` ASC) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tokens
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `fullname` varchar(100) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT '',
  `phone_number` varchar(10) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT '',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL DEFAULT '',
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `is_active` tinyint(1) NULL DEFAULT 1,
  `date_of_birth` date NULL DEFAULT NULL,
  `facebook_account_id` int NULL DEFAULT 0,
  `google_account_id` int NULL DEFAULT 0,
  `role_id` int NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role_id`(`role_id` ASC) USING BTREE,
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (0, 'Guess', '', '', '', NULL, NULL, 1, NULL, 0, 0, 0, '', NULL);
INSERT INTO `users` VALUES (1, 'Trinh Long Vu', '1231312', 'asdasd', '$10$3w0EAV8u.LSZiPldR0y4H.JAHXyyWEOdXdCpq7K6Tlb9nmscU.dkO', NULL, NULL, 1, NULL, 0, 0, 1, 'longvu17112002@gmail.com', NULL);
INSERT INTO `users` VALUES (2, 'trinh long vu', '123123', 'a, b', '$2a$10$3w0EAV8u.LSZiPldR0y4H.JAHXyyWEOdXdCpq7K6Tlb9nmscU.dkO', '2024-04-09 12:46:04', '2024-04-09 12:46:04', 0, '2003-05-11', 0, 0, 2, 'longvu17112002@gmail.com', NULL);
INSERT INTO `users` VALUES (3, 'Tài khoản Admin 1', '11223344', 'THIS IS ADMIN', '$2a$10$OJgjC1U5mfqjPi6vvnX7uuXAN6dA1fzHn1bpuFvD8OWdsgvQMx0KS', '2024-04-10 08:47:59', '2024-04-10 08:47:59', 0, '2003-05-11', 0, 0, 1, '', NULL);
INSERT INTO `users` VALUES (4, 'Tài khoản User 1', '0346019283', 'THIS IS USER', '$2a$10$dp36PDVpYXCthv4.XQCydesKr1mPBRI.hlfPT7hEu1VuD1B9wDdCO', '2024-04-20 01:37:45', '2024-04-20 01:37:45', 0, '2003-05-11', 0, 0, 1, 'longvu17112002@gmail.com', NULL);
INSERT INTO `users` VALUES (6, '', '', '', '', NULL, NULL, 1, NULL, 0, 0, NULL, '', NULL);
INSERT INTO `users` VALUES (7, 'Tài khoản User 1', '0346019283', 'THIS IS USER', '$2a$10$a4trxV7OLRHiftne4cN5ueJTenw1B.PIzvF7o0NDQZJ4N54LqAGXa', '2024-05-24 04:20:03', '2024-05-31 04:42:20', 0, '2003-05-11', 0, 0, 1, 'ki@gmail.com', 'avatar.jpg');
INSERT INTO `users` VALUES (8, 'Tài khoản Admin 666', '11223344', 'THIS IS ADMIN', '$2a$10$0B8XZJw4ovfFiRyhuQzqf.uXX.BZ64TlZrQvfuC36.LjqgRvY6//C', '2024-05-27 15:00:39', '2024-05-31 09:22:15', 0, '2003-05-01', 0, 0, 2, 'admin@gmail.com', NULL);

-- ----------------------------
-- Table structure for variant_options
-- ----------------------------
DROP TABLE IF EXISTS `variant_options`;
CREATE TABLE `variant_options`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `variant_id` int NULL DEFAULT NULL,
  `option_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `variant_id`(`variant_id` ASC) USING BTREE,
  INDEX `option_id`(`option_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 66 CHARACTER SET = utf8 COLLATE = utf8_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of variant_options
-- ----------------------------
INSERT INTO `variant_options` VALUES (37, 5, 2);
INSERT INTO `variant_options` VALUES (38, 4, 7);
INSERT INTO `variant_options` VALUES (42, 5, 1);
INSERT INTO `variant_options` VALUES (43, 4, 1);
INSERT INTO `variant_options` VALUES (44, 7, 12);
INSERT INTO `variant_options` VALUES (45, 7, 8);
INSERT INTO `variant_options` VALUES (46, 8, 12);
INSERT INTO `variant_options` VALUES (47, 8, 9);
INSERT INTO `variant_options` VALUES (48, 9, 12);
INSERT INTO `variant_options` VALUES (49, 9, 10);
INSERT INTO `variant_options` VALUES (50, 10, 13);
INSERT INTO `variant_options` VALUES (51, 10, 8);
INSERT INTO `variant_options` VALUES (52, 11, 13);
INSERT INTO `variant_options` VALUES (53, 11, 9);
INSERT INTO `variant_options` VALUES (54, 12, 13);
INSERT INTO `variant_options` VALUES (55, 12, 10);
INSERT INTO `variant_options` VALUES (56, 13, 13);
INSERT INTO `variant_options` VALUES (57, 13, 11);
INSERT INTO `variant_options` VALUES (58, 14, 14);
INSERT INTO `variant_options` VALUES (59, 14, 8);
INSERT INTO `variant_options` VALUES (60, 15, 14);
INSERT INTO `variant_options` VALUES (61, 15, 9);
INSERT INTO `variant_options` VALUES (62, 16, 14);
INSERT INTO `variant_options` VALUES (63, 16, 10);
INSERT INTO `variant_options` VALUES (64, 17, 14);
INSERT INTO `variant_options` VALUES (65, 17, 11);

-- ----------------------------
-- Table structure for variants
-- ----------------------------
DROP TABLE IF EXISTS `variants`;
CREATE TABLE `variants`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(350) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT NULL,
  `available_for_sale` int NOT NULL,
  `price` float NOT NULL,
  `currency` varchar(10) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8 COLLATE = utf8_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of variants
-- ----------------------------
INSERT INTO `variants` VALUES (4, 'Red / L', 1, 19.2, 'USD');
INSERT INTO `variants` VALUES (5, 'Red / S', 1, 19.2, 'USD');
INSERT INTO `variants` VALUES (6, 'Blue / L', 1, 15.2, 'USD');
INSERT INTO `variants` VALUES (7, '12GB 256GB / Vàng', 1, 31990000, 'VND');
INSERT INTO `variants` VALUES (8, '12GB 256GB / Xám', 1, 31990000, 'VND');
INSERT INTO `variants` VALUES (9, '12GB 256GB / Đen', 1, 31990000, 'VND');
INSERT INTO `variants` VALUES (10, '12GB 512GB / Vàng', 1, 35490000, 'VND');
INSERT INTO `variants` VALUES (11, '12GB 512GB / Xám', 1, 35490000, 'VND');
INSERT INTO `variants` VALUES (12, '12GB 512GB / Đen', 1, 35490000, 'VND');
INSERT INTO `variants` VALUES (13, '12GB 512GB / Tím', 1, 35490000, 'VND');
INSERT INTO `variants` VALUES (14, '12GB 1TB / Vàng', 1, 42490000, 'VND');
INSERT INTO `variants` VALUES (15, '12GB 1TB / Xám', 1, 42490000, 'VND');
INSERT INTO `variants` VALUES (16, '12GB 1TB / Đen', 1, 42490000, 'VND');
INSERT INTO `variants` VALUES (17, '12GB 1TB / Tím', 1, 42490000, 'VND');

-- ----------------------------
-- Table structure for wishlist
-- ----------------------------
DROP TABLE IF EXISTS `wishlist`;
CREATE TABLE `wishlist`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `product_id` int NULL DEFAULT NULL,
  `id_product_variant` int NULL DEFAULT NULL,
  `active` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk1`(`user_id` ASC) USING BTREE,
  INDEX `fk2`(`product_id` ASC) USING BTREE,
  CONSTRAINT `fk1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wishlist
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
