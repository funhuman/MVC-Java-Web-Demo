/*
SQLyog Ultimate v12.3.1 (64 bit)
MySQL - 5.5.20 : Database - ems
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ems` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `ems`;

/*Table structure for table `checkinfo` */

DROP TABLE IF EXISTS `checkinfo`;

CREATE TABLE `checkinfo` (
  `staffid` int(64) unsigned NOT NULL COMMENT '员工编号（用户编号）',
  `checkstatus` varchar(255) DEFAULT NULL COMMENT '签到状态(未签到,已签到,代签,迟到,旷工)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `checkinfo` */

insert  into `checkinfo`(`staffid`,`checkstatus`) values 
(1,'未签到'),
(10,'未签到'),
(12,'未签到'),
(101,'未签到'),
(102,'未签到'),
(103,'未签到'),
(104,'未签到'),
(105,'未签到'),
(106,'未签到');

/*Table structure for table `info` */

DROP TABLE IF EXISTS `info`;

CREATE TABLE `info` (
  `infoid` int(32) unsigned NOT NULL AUTO_INCREMENT COMMENT '信息内容',
  `infotitle` varchar(20) DEFAULT NULL COMMENT '信息标题',
  `infotinytext` varchar(1000) DEFAULT NULL COMMENT '信息开头',
  `infotext` text COMMENT '信息内容',
  `createtime` time DEFAULT NULL COMMENT '创建时间',
  `updatetime` time DEFAULT NULL COMMENT '修改时间',
  `isdeleted` tinyint(1) unsigned DEFAULT NULL COMMENT '删除标记（0:正常,1:删除）',
  PRIMARY KEY (`infoid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `info` */

/*Table structure for table `staffinfo` */

DROP TABLE IF EXISTS `staffinfo`;

CREATE TABLE `staffinfo` (
  `staffid` int(64) unsigned NOT NULL COMMENT '员工编号（用户编号）',
  `staffname` varchar(255) DEFAULT NULL COMMENT '员工姓名',
  `staffphone` varchar(255) DEFAULT NULL COMMENT '手机号',
  `staffsex` varchar(10) DEFAULT NULL COMMENT '性别（男,女）',
  `staffage` tinyint(4) DEFAULT NULL COMMENT '年龄'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `staffinfo` */

insert  into `staffinfo`(`staffid`,`staffname`,`staffphone`,`staffsex`,`staffage`) values 
(1,'经理','12345678923','男',28),
(10,'员工','12322221231','男',23),
(12,'Employee','12313131233','女',22),
(106,'Worker','+86 12121212332','女',22);

/*Table structure for table `userinfo` */

DROP TABLE IF EXISTS `userinfo`;

CREATE TABLE `userinfo` (
  `userid` int(64) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `staffrole` varchar(255) DEFAULT NULL COMMENT '角色（经理,员工）',
  `isdeleted` int(1) unsigned DEFAULT NULL COMMENT '删除标记（0:正常,1:删除）',
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8;

/*Data for the table `userinfo` */

insert  into `userinfo`(`userid`,`username`,`password`,`staffrole`,`isdeleted`) values 
(1,'admin','Ad.123','经理',0),
(10,'ad','1','员工',0),
(12,'12','12','员工',0),
(106,'asddddddddd','ass','员工',0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
