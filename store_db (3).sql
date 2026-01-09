-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 19, 2025 at 04:25 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `store_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `status` enum('pending','processing','completed','cancelled') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `total_price`, `status`, `created_at`) VALUES
(1, 3, 1950.00, 'cancelled', '2025-10-18 13:55:16'),
(2, 3, 6270.00, 'cancelled', '2025-10-19 11:01:55'),
(3, 3, 1560.00, 'cancelled', '2025-10-19 13:01:26'),
(4, 3, 700.00, 'completed', '2025-10-19 13:04:00'),
(5, 3, 4260.00, 'processing', '2025-10-19 13:15:05');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `size` int(11) DEFAULT NULL
) ;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `size`) VALUES
(1, 1, 101, 2, 58),
(2, 1, 202, 1, 60),
(3, 1, 201, 2, 62),
(4, 2, 101, 6, 60),
(5, 2, 102, 6, 62),
(6, 2, 202, 1, 62),
(7, 3, 102, 3, 60),
(8, 4, 202, 2, 60),
(9, 5, 102, 3, 60),
(10, 5, 101, 6, 60);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price1` int(11) NOT NULL,
  `price2` int(11) DEFAULT NULL,
  `image` varchar(400) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price1`, `price2`, `image`) VALUES
(101, 'شماغ كلاسيك ابيض', 450, NULL, 'https://media.zid.store/thumbs/1a3773d3-4551-460a-9894-7c8e77a8f5b8/e7da9b31-01d5-4b92-8fdf-43d338fb3303-thumbnail-500x500-70.jpg'),
(102, 'شماغ احمر فاخر', 520, NULL, 'https://media.zid.store/1a3773d3-4551-460a-9894-7c8e77a8f5b8/7cc90eaf-0867-479a-9e14-1a1c41ad2f05.jpg'),
(103, 'شماغ اسود ملكي', 600, NULL, 'https://cdn.salla.sa/lGqmV/2YLvekfxo6HRYH7Gzu3PvT0ZB3rw8prDVL94Gtj2.jpg'),
(201, 'شماغ كلاسيك مخفض', 400, 300, 'https://backend.ajstore.com//pub/media/catalog/product/cache/d3470a8a7a3ceb0328c354c4622cde6a/y/a/yasmagh-2_2.jpg?auto=webp&format=pjpg&width=320&height=320&fit=cover'),
(202, 'شماغ فاخر مخفض', 600, 350, 'https://backend.ajstore.com//pub/media/catalog/product/cache/d3470a8a7a3ceb0328c354c4622cde6a/y/a/yasmagh-1.jpg?auto=webp&format=pjpg&width=320&height=320&fit=cover'),
(203, 'شماغ ملكي مخفض', 750, 500, 'https://backend.ajstore.com//pub/media/catalog/product/cache/d3470a8a7a3ceb0328c354c4622cde6a/p/h/photo-_3_4.jpg?auto=webp&format=pjpg&width=320&height=320&fit=cover');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `role`) VALUES
(1, 'Baraa1', 'bara777764@gmail.com', '$2y$10$2doKU/XbdbzI7doB2ovglerNZoPISiJl9Wh39W9BZfRQ6FhSt78zq', 'user'),
(2, 'Baraa', 'mr.bkl918@gmail.com', '$2y$10$p8AHZdYNkQAh97Z4.F7feO9vPT6VYAfue1dvcztkIwm3ncie5OMcu', 'admin'),
(3, 'khalid', 'dsaff@gmail.com', '$2y$10$v3LqlotBZrgKYuAH9LTXXuf80GEe6bKZSvBYtUBxjxhGvlHL8hofS', 'user');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order_id` (`order_id`),
  ADD KEY `idx_product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=206;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
