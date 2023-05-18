/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50620
Source Host           : localhost:3306
Source Database       : book_db

Target Server Type    : MYSQL
Target Server Version : 50620
File Encoding         : 65001

Date: 2019-10-16 18:21:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_book`
-- ----------------------------
DROP TABLE IF EXISTS `t_book`;
CREATE TABLE `t_book` (
  `barcode` varchar(20) NOT NULL COMMENT 'barcode',
  `bookName` varchar(20) NOT NULL COMMENT '图书名称',
  `bookTypeObj` int(11) NOT NULL COMMENT '图书所在类别',
  `price` float NOT NULL COMMENT '图书价格',
  `count` int(11) NOT NULL COMMENT '库存',
  `publishDate` varchar(20) DEFAULT NULL COMMENT '出版日期',
  `publish` varchar(20) DEFAULT NULL COMMENT '出版社',
  `bookPhoto` varchar(60) NOT NULL COMMENT '图书图片',
  `hitNum` int(11) NOT NULL COMMENT '浏览量',
  `bookDesc` varchar(500) DEFAULT NULL COMMENT '图书简介',
  PRIMARY KEY (`barcode`),
  KEY `bookTypeObj` (`bookTypeObj`),
  CONSTRAINT `t_book_ibfk_1` FOREIGN KEY (`bookTypeObj`) REFERENCES `t_booktype` (`bookTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_book
-- ----------------------------
INSERT INTO `t_book` VALUES ('TS001', 'php网站开发入门', '1', '38.8', '12', '2019-10-15', '人民教育出版社', 'upload/03a5a705-b7a0-4a19-a345-5c869734bb05.jpg', '23', '本书内容充实条理，结构严谨，对PHP的功能进行了循序渐进有层次的讲解。书中所列举案例的选择均突出知识点的实际应用性，并配合有TIPS技巧讲解，让读者能快速掌握HTML关键技能。\r\n\r\n全书共分为22章，包括PHP基础入门、流程控制语句、字符串的操作、PHP数组、正则表达式、JavaScript交互、日期与时间、Cookie与Session、图形图像处理技术、文件系统、面向对象、PHP加密技术、MySQL数据库基础、PHP+MySQL数据库、PHP与XML技术、PHP与Ajax技术、Smarty模板技术、ThinkPHP框架');
INSERT INTO `t_book` VALUES ('TS002', '微信小程序开发', '1', '35.5', '18', '2019-10-15', '人民教育出版社', 'upload/646558e6-2de2-4a67-8afd-eeef9b364e3a.jpg', '9', '微信小程序可以实现App软件的原生交互操作效果，无需安装卸载，解放用户手机内存。商家使用微信小程序也可以被更多用户找到自己的产品，成为有利的宣传。 《微信小程序开发图解案例教程》助你3步学会微信小程序设计： Step1图、文、代码、视频快速理解小程序基本原理和应用方法； Step2海量案例，边练边学； Step3综合实战，感受真实商业项目制作过程； 平台支撑，免费赠送资源 1.全部案例源代码、素材、*终文件 2.全书电子教案 3.全书配套1399分钟高清精讲视频教程，手机扫码看或登录人邮学院免费观看 4.赠送8大类商业案例1332分钟视频课程 ');
INSERT INTO `t_book` VALUES ('TS003', '中国近代史', '2', '35', '20', '2019-10-07', '人民教育出版社', 'upload/39b05de1-5b55-4266-9481-81c1eebf7e3f.jpg', '3', '中国近代史是从第一次鸦片战争1840年到1949年南京国民党政权迁至台湾、 [1]  中华人民共和国成立的历史。历经清王朝晚期、中华民国临时政府时期、 [2]  北洋军阀时期和国民政府时期，是中国半殖民地半封建社会逐渐形成到瓦解的历史');

-- ----------------------------
-- Table structure for `t_booktype`
-- ----------------------------
DROP TABLE IF EXISTS `t_booktype`;
CREATE TABLE `t_booktype` (
  `bookTypeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '图书类别id',
  `bookTypeName` varchar(18) NOT NULL COMMENT '类别名称',
  `days` int(11) NOT NULL COMMENT '可借阅天数',
  PRIMARY KEY (`bookTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_booktype
-- ----------------------------
INSERT INTO `t_booktype` VALUES ('1', '计算机类', '30');
INSERT INTO `t_booktype` VALUES ('2', '历史类', '25');
INSERT INTO `t_booktype` VALUES ('3', '经济类', '20');

-- ----------------------------
-- Table structure for `t_loaninfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_loaninfo`;
CREATE TABLE `t_loaninfo` (
  `loadId` int(11) NOT NULL AUTO_INCREMENT COMMENT '借阅编号',
  `book` varchar(20) NOT NULL COMMENT '图书对象',
  `reader` varchar(20) NOT NULL COMMENT '读者对象',
  `borrowDate` varchar(20) DEFAULT NULL COMMENT '借阅时间',
  `returnDate` varchar(20) DEFAULT NULL COMMENT '归还时间',
  PRIMARY KEY (`loadId`),
  KEY `book` (`book`),
  KEY `reader` (`reader`),
  CONSTRAINT `t_loaninfo_ibfk_1` FOREIGN KEY (`book`) REFERENCES `t_book` (`barcode`),
  CONSTRAINT `t_loaninfo_ibfk_2` FOREIGN KEY (`reader`) REFERENCES `t_reader` (`readerNo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_loaninfo
-- ----------------------------
INSERT INTO `t_loaninfo` VALUES ('1', 'TS001', 'DZ001', '2019-09-11 22:42:08', '2019-10-16 22:42:09');
INSERT INTO `t_loaninfo` VALUES ('2', 'TS002', 'DZ001', '2019-10-01 13:41:02', '2019-10-16 13:41:06');
INSERT INTO `t_loaninfo` VALUES ('3', 'TS003', '13688886666', '2019-10-16 14:39:29', '2019-10-16 14:39:26');
INSERT INTO `t_loaninfo` VALUES ('4', 'TS001', '13688886666', '2019-10-16 14:41:36', '--');

-- ----------------------------
-- Table structure for `t_reader`
-- ----------------------------
DROP TABLE IF EXISTS `t_reader`;
CREATE TABLE `t_reader` (
  `readerNo` varchar(20) NOT NULL COMMENT 'readerNo',
  `password` varchar(20) DEFAULT NULL COMMENT '登录密码',
  `readerTypeObj` int(11) NOT NULL COMMENT '读者类型',
  `readerName` varchar(20) NOT NULL COMMENT '姓名',
  `sex` varchar(2) NOT NULL COMMENT '性别',
  `photo` varchar(60) NOT NULL COMMENT '读者头像',
  `birthday` varchar(20) DEFAULT NULL COMMENT '读者生日',
  `telephone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '联系Email',
  `address` varchar(80) DEFAULT NULL COMMENT '读者地址',
  `openid` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`readerNo`),
  KEY `readerTypeObj` (`readerTypeObj`),
  CONSTRAINT `t_reader_ibfk_1` FOREIGN KEY (`readerTypeObj`) REFERENCES `t_readertype` (`readerTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_reader
-- ----------------------------
INSERT INTO `t_reader` VALUES ('13688886666', '123', '1', '鼠鼠', '男', 'upload/495334ce49924c7185e5732527cd8325', '1990-01-01', '13688886666', '', '', 'oM7Mu5XyeVJSc8roaUCRlcz_IP9k');
INSERT INTO `t_reader` VALUES ('DZ001', '123', '1', '张晓梅', '女', 'upload/ab1eb909-e3bb-4f76-b15e-7fc50afee499.jpg', '2019-10-15', '13490224234', 'fang@126.com', '成都红星路10号', null);

-- ----------------------------
-- Table structure for `t_readertype`
-- ----------------------------
DROP TABLE IF EXISTS `t_readertype`;
CREATE TABLE `t_readertype` (
  `readerTypeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '读者类型编号',
  `readerTypeName` varchar(20) NOT NULL COMMENT '读者类型',
  `number` int(11) NOT NULL COMMENT '可借阅数目',
  PRIMARY KEY (`readerTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_readertype
-- ----------------------------
INSERT INTO `t_readertype` VALUES ('1', '学生类', '3');
INSERT INTO `t_readertype` VALUES ('2', '教师类', '5');
