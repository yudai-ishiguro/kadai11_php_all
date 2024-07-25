-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- ホスト: 127.0.0.1
-- 生成日時: 2024-07-24 15:30:25
-- サーバのバージョン： 10.4.32-MariaDB
-- PHP のバージョン: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- データベース: `kadai11_php_all`
--

-- --------------------------------------------------------

--
-- テーブルの構造 `conditions`
--

CREATE TABLE `conditions` (
  `id` int(11) NOT NULL,
  `judge` varchar(64) NOT NULL,
  `image` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- テーブルのデータのダンプ `conditions`
--

INSERT INTO `conditions` (`id`, `judge`, `image`) VALUES
(1, 'Good', NULL),
(2, 'So-So', NULL),
(3, 'Bad', NULL);

-- --------------------------------------------------------

--
-- テーブルの構造 `diving_area`
--

CREATE TABLE `diving_area` (
  `id` int(11) NOT NULL,
  `area_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- テーブルのデータのダンプ `diving_area`
--

INSERT INTO `diving_area` (`id`, `area_name`) VALUES
(1, '阿嘉島'),
(2, '座間味島'),
(3, '渡嘉敷島');

-- --------------------------------------------------------

--
-- テーブルの構造 `diving_log`
--

CREATE TABLE `diving_log` (
  `id` int(12) NOT NULL,
  `dive_no` int(12) DEFAULT NULL,
  `diving_point_id` int(12) NOT NULL,
  `date` date NOT NULL,
  `wind_direction_id` int(12) DEFAULT NULL,
  `conditions_id` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- テーブルのデータのダンプ `diving_log`
--

INSERT INTO `diving_log` (`id`, `dive_no`, `diving_point_id`, `date`, `wind_direction_id`, `conditions_id`) VALUES
(1, 40, 1, '2007-07-05', 11, 1),
(2, 47, 1, '2008-08-22', 11, 1),
(3, 35, 2, '2006-10-09', 3, 1),
(4, 39, 2, '2006-10-11', 3, 1),
(5, 43, 2, '2007-07-06', 11, 1),
(6, 44, 3, '2007-07-06', 11, 1),
(7, 6, 4, '1998-08-09', 15, 1),
(8, 37, 4, '2006-10-10', 5, 1),
(9, 48, 4, '2008-08-22', 11, 1),
(10, 59, 5, '2010-06-26', 8, 1),
(11, 45, 7, '2007-07-06', 11, 1),
(12, 86, 10, '2013-09-15', 1, 1),
(13, 87, 13, '2013-09-15', 1, 1),
(14, 60, 14, '2010-06-26', 8, 1),
(15, 36, 16, '2006-10-10', 5, 1),
(16, 8, 17, '1998-08-10', 13, 1),
(17, 29, 17, '2003-10-14', 1, 1),
(18, 38, 20, '2006-10-11', 3, 1);

-- --------------------------------------------------------

--
-- テーブルの構造 `diving_point`
--

CREATE TABLE `diving_point` (
  `id` int(12) NOT NULL,
  `diving_area_id` int(12) NOT NULL,
  `point_name` varchar(64) NOT NULL,
  `level` varchar(64) NOT NULL,
  `depth` varchar(64) NOT NULL,
  `image` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- テーブルのデータのダンプ `diving_point`
--

INSERT INTO `diving_point` (`id`, `diving_area_id`, `point_name`, `level`, `depth`, `image`) VALUES
(1, 3, '黒島ツインロック', '中級以上', '5～35m', NULL),
(2, 3, '自津留', '中級以上', '5～35m', NULL),
(3, 3, '儀志布 西', '初級以上', '7～20m', NULL),
(4, 3, 'タマルル', '初級以上', '4～15m', NULL),
(5, 3, 'カミグー', '初級以上', '3～17m', NULL),
(6, 3, 'アカンア', '初級以上', '4～20m', NULL),
(7, 3, '運瀬', '中級以上', '6～35m', NULL),
(8, 3, 'ムチズニ', '中級以上', '7～35m', NULL),
(9, 3, 'アハレン灯台下', '初級以上', '3～15m', NULL),
(10, 3, '中頭', '初級以上', '3～10m', NULL),
(11, 3, 'Ｖ', '中級以上', '5～20m', NULL),
(12, 3, 'ハナレビーチ前', '初級以上', '3～6m', NULL),
(13, 3, '海人', '中級以上', '20～25m', NULL),
(14, 3, 'とかしくビーチ前', '初級以上', '1～3m', NULL),
(15, 3, '三本根', '初級以上', '7～15m', NULL),
(16, 3, 'アリガー南', '初級以上', '4～20m', NULL),
(17, 3, 'アリガーケーブル', '初級以上', '5～25m', NULL),
(18, 3, 'アリガー北', '初級以上', '3～20m', NULL),
(19, 3, 'スン崎', '初級以上', '4～25m', NULL),
(20, 3, '野崎', '初級以上', '3～15m', NULL);

-- --------------------------------------------------------

--
-- テーブルの構造 `wind_direction`
--

CREATE TABLE `wind_direction` (
  `id` int(11) NOT NULL,
  `direction` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- テーブルのデータのダンプ `wind_direction`
--

INSERT INTO `wind_direction` (`id`, `direction`) VALUES
(1, '北'),
(2, '北北東'),
(3, '北東'),
(4, '東北東'),
(5, '東'),
(6, '東南東'),
(7, '南東'),
(8, '南南東'),
(9, '南'),
(10, '南南西'),
(11, '南西'),
(12, '西南西'),
(13, '西'),
(14, '西北西'),
(15, '北西'),
(16, '北北西');

--
-- ダンプしたテーブルのインデックス
--

--
-- テーブルのインデックス `conditions`
--
ALTER TABLE `conditions`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `diving_area`
--
ALTER TABLE `diving_area`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `diving_log`
--
ALTER TABLE `diving_log`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `diving_point`
--
ALTER TABLE `diving_point`
  ADD PRIMARY KEY (`id`),
  ADD KEY `diving_area_id` (`diving_area_id`);

--
-- テーブルのインデックス `wind_direction`
--
ALTER TABLE `wind_direction`
  ADD PRIMARY KEY (`id`);

--
-- ダンプしたテーブルの AUTO_INCREMENT
--

--
-- テーブルの AUTO_INCREMENT `conditions`
--
ALTER TABLE `conditions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- テーブルの AUTO_INCREMENT `diving_area`
--
ALTER TABLE `diving_area`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- テーブルの AUTO_INCREMENT `diving_log`
--
ALTER TABLE `diving_log`
  MODIFY `id` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- テーブルの AUTO_INCREMENT `diving_point`
--
ALTER TABLE `diving_point`
  MODIFY `id` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- テーブルの AUTO_INCREMENT `wind_direction`
--
ALTER TABLE `wind_direction`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- ダンプしたテーブルの制約
--

--
-- テーブルの制約 `diving_point`
--
ALTER TABLE `diving_point`
  ADD CONSTRAINT `diving_point_ibfk_1` FOREIGN KEY (`diving_area_id`) REFERENCES `diving_area` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
