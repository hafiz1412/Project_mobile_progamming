-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 27, 2020 at 12:56 AM
-- Server version: 10.3.23-MariaDB
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shababit_lab_3`
--

-- --------------------------------------------------------

--
-- Table structure for table `CART`
--

CREATE TABLE `CART` (
  `EMAIL` varchar(50) NOT NULL,
  `PRODID` varchar(20) NOT NULL,
  `CQUANTITY` varchar(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CART`
--

INSERT INTO `CART` (`EMAIL`, `PRODID`, `CQUANTITY`) VALUES
('pis@gmail.com', '9556231111110', '1'),
('pis@gmail.com', '8690890200011', '1');

-- --------------------------------------------------------

--
-- Table structure for table `CARTHISTORY`
--

CREATE TABLE `CARTHISTORY` (
  `EMAIL` varchar(100) NOT NULL,
  `ORDERID` varchar(100) NOT NULL,
  `BILLID` varchar(20) NOT NULL,
  `PRODID` varchar(30) NOT NULL,
  `CQUANTITY` varchar(10) NOT NULL,
  `DATE` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CARTHISTORY`
--

INSERT INTO `CARTHISTORY` (`EMAIL`, `ORDERID`, `BILLID`, `PRODID`, `CQUANTITY`, `DATE`) VALUES
('admin@grocery.com', 'dmi-25062020-mN787q', 'rzpzuw3j', '9556231111110', '1', '2020-06-25 21:15:28'),
('admin@grocery.com', 'dmi-25062020-421E10', 'adgeqw0h', '9556231111110', '1', '2020-06-25 21:16:51'),
('hafizismadi1999@gmail.com', 'afi-25062020-BY632X', 'xbnizjdd', '9556231111110', '6', '2020-06-25 21:23:11'),
('hafizismadi1999@gmail.com', 'afi-25062020-aK2qG7', 'ugkuau90', '9556231111110', '1', '2020-06-25 23:35:22'),
('hafizismadi1999@gmail.com', 'afi-25062020-IFe4kg', 'blgkg3u6', '9556231111110', '1', '2020-06-25 23:38:18'),
('hafizismadi1999@gmail.com', 'afi-25062020-8L48ER', '4wulos4x', '9556231111110', '1', '2020-06-25 23:54:36');

-- --------------------------------------------------------

--
-- Table structure for table `PAYMENT`
--

CREATE TABLE `PAYMENT` (
  `ORDERID` varchar(100) NOT NULL,
  `BILLID` varchar(10) NOT NULL,
  `TOTAL` varchar(10) NOT NULL,
  `USERID` varchar(100) NOT NULL,
  `DATE` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `PAYMENT`
--

INSERT INTO `PAYMENT` (`ORDERID`, `BILLID`, `TOTAL`, `USERID`, `DATE`) VALUES
('dmi-25062020-mN787q', 'rzpzuw3j', '2.50', 'admin@grocery.com', '2020-06-25 21:15:28'),
('dmi-25062020-421E10', 'adgeqw0h', '2.50', 'admin@grocery.com', '2020-06-25 21:16:51'),
('afi-25062020-BY632X', 'xbnizjdd', '15.00', 'hafizismadi1999@gmail.com', '2020-06-25 21:23:11'),
('afi-25062020-aK2qG7', 'ugkuau90', '22.50', 'hafizismadi1999@gmail.com', '2020-06-25 23:35:22'),
('afi-25062020-IFe4kg', 'blgkg3u6', '22.50', 'hafizismadi1999@gmail.com', '2020-06-25 23:38:18'),
('afi-25062020-8L48ER', '4wulos4x', '22.50', 'hafizismadi1999@gmail.com', '2020-06-25 23:54:36');

-- --------------------------------------------------------

--
-- Table structure for table `PRODUCT`
--

CREATE TABLE `PRODUCT` (
  `ID` varchar(30) NOT NULL,
  `NAME` varchar(100) NOT NULL,
  `PRICE` varchar(10) NOT NULL,
  `QUANTITY` varchar(10) NOT NULL,
  `WEIGHT` varchar(10) NOT NULL,
  `TYPE` varchar(20) NOT NULL,
  `DATE` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `PRODUCT`
--

INSERT INTO `PRODUCT` (`ID`, `NAME`, `PRICE`, `QUANTITY`, `WEIGHT`, `TYPE`, `DATE`) VALUES
('8690890200011', 'Caution Cone', '16.90', '20', '500.00', 'Other', '2020-05-26 11:11:50'),
('9556231111110', 'Car Tool', '22.50', '10', '400.00', 'Tool', '2020-05-26 11:14:04');

-- --------------------------------------------------------

--
-- Table structure for table `USER`
--

CREATE TABLE `USER` (
  `NAME` varchar(50) NOT NULL,
  `EMAIL` varchar(50) NOT NULL,
  `PHONE` varchar(12) NOT NULL,
  `PASSWORD` varchar(60) NOT NULL,
  `CREDIT` varchar(5) NOT NULL,
  `VERIFY` varchar(1) NOT NULL,
  `DATEREG` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `USER`
--

INSERT INTO `USER` (`NAME`, `EMAIL`, `PHONE`, `PASSWORD`, `CREDIT`, `VERIFY`, `DATEREG`) VALUES
('admin', 'admin@grocery.com', '0123456789', '87acec17cd9dcd20a716cc2cf67417b71c8a7016', '0', '1', '2020-06-13 22:46:22'),
('hafiz', 'hafizismadi1999@gmail.com', '01156902698', '87acec17cd9dcd20a716cc2cf67417b71c8a7016', '10', '1', '2020-06-25 21:18:48'),
('pis', 'pis@gmail.com', '019', '4db899287a36c495c98306ba0e0ee5f45d27ff3b', '10', '1', '2020-07-02 22:53:35');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `PRODUCT`
--
ALTER TABLE `PRODUCT`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `USER`
--
ALTER TABLE `USER`
  ADD PRIMARY KEY (`EMAIL`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
