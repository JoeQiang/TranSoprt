/*
Navicat MySQL Data Transfer

Source Server         : mysql4j
Source Server Version : 50627
Source Host           : localhost:3306
Source Database       : transport

Target Server Type    : MYSQL
Target Server Version : 50627
File Encoding         : 65001

Date: 2016-01-22 17:58:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(25) NOT NULL,
  `password` varchar(32) NOT NULL,
  `nickname` varchar(26) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'Joe', 'f1b24036355f123631e50d86742af8b2', '黄晓强');

-- ----------------------------
-- Table structure for `dealer`
-- ----------------------------
DROP TABLE IF EXISTS `dealer`;
CREATE TABLE `dealer` (
  `did` int(11) NOT NULL AUTO_INCREMENT,
  `dname` varchar(255) DEFAULT NULL,
  `dpwd` varchar(255) DEFAULT NULL,
  `phone` bigint(11) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `limitdays` int(11) DEFAULT NULL,
  `dynamic` varchar(32) DEFAULT NULL COMMENT '动态密码',
  PRIMARY KEY (`did`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dealer
-- ----------------------------
INSERT INTO `dealer` VALUES ('2', '小阿三', 'e10adc3949ba59abbe56e057f20f883e', '21', '111', '31', null);
INSERT INTO `dealer` VALUES ('3', '绝对是', '2121', '32321', '3232', '32', null);
INSERT INTO `dealer` VALUES ('4', '为车队刷', '21212', '2123', '32321', '32', null);
INSERT INTO `dealer` VALUES ('5', '程度上', '32', '323', '3232', '3232', null);
INSERT INTO `dealer` VALUES ('6', '大撒旦撒', '2', '232', '打算', '23', null);
INSERT INTO `dealer` VALUES ('7', '打算', '2', '232', '大撒旦撒', '22', null);
INSERT INTO `dealer` VALUES ('8', '大苏打', '3', '23', '大苏打', '21', null);
INSERT INTO `dealer` VALUES ('9', '大撒旦撒', '32', '3221', '地方法', '231', null);
INSERT INTO `dealer` VALUES ('10', '恶风', '32', '22', '大苏打', '3', null);
INSERT INTO `dealer` VALUES ('13', '李毅吧', 'e10adc3949ba59abbe56e057f20f883e', '18826243710', '广东光州', '21', null);

-- ----------------------------
-- Table structure for `goods_standard`
-- ----------------------------
DROP TABLE IF EXISTS `goods_standard`;
CREATE TABLE `goods_standard` (
  `gid` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  PRIMARY KEY (`gid`,`sid`),
  KEY `fk_sid` (`sid`),
  CONSTRAINT `fk_gid` FOREIGN KEY (`gid`) REFERENCES `grgoods` (`gid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_sid` FOREIGN KEY (`sid`) REFERENCES `standard` (`sid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods_standard
-- ----------------------------
INSERT INTO `goods_standard` VALUES ('11', '1');
INSERT INTO `goods_standard` VALUES ('11', '2');

-- ----------------------------
-- Table structure for `grfactory`
-- ----------------------------
DROP TABLE IF EXISTS `grfactory`;
CREATE TABLE `grfactory` (
  `fid` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(255) DEFAULT NULL,
  `fpwd` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`fid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of grfactory
-- ----------------------------
INSERT INTO `grfactory` VALUES ('1', '厂家1', '123123');

-- ----------------------------
-- Table structure for `grgoods`
-- ----------------------------
DROP TABLE IF EXISTS `grgoods`;
CREATE TABLE `grgoods` (
  `gid` int(11) NOT NULL AUTO_INCREMENT,
  `gname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of grgoods
-- ----------------------------
INSERT INTO `grgoods` VALUES ('11', '蛋糕');

-- ----------------------------
-- Table structure for `grorder`
-- ----------------------------
DROP TABLE IF EXISTS `grorder`;
CREATE TABLE `grorder` (
  `oid` int(11) NOT NULL AUTO_INCREMENT,
  `dealerid` int(11) DEFAULT NULL,
  `createday` date DEFAULT NULL,
  `sendday` date DEFAULT NULL,
  `arriveday` date DEFAULT NULL,
  `factoryid` int(11) DEFAULT NULL,
  `stauts` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`oid`),
  KEY `fk_dealer` (`dealerid`),
  KEY `fk_factory` (`factoryid`),
  CONSTRAINT `fk_dealer` FOREIGN KEY (`dealerid`) REFERENCES `dealer` (`did`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_factory` FOREIGN KEY (`factoryid`) REFERENCES `grfactory` (`fid`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of grorder
-- ----------------------------
INSERT INTO `grorder` VALUES ('1', null, '2016-01-18', '2016-01-18', '2016-01-18', '1', '未发货');

-- ----------------------------
-- Table structure for `order_goods`
-- ----------------------------
DROP TABLE IF EXISTS `order_goods`;
CREATE TABLE `order_goods` (
  `oid` int(11) NOT NULL DEFAULT '0',
  `gid` int(11) NOT NULL DEFAULT '0',
  `sid` int(11) NOT NULL DEFAULT '0',
  `num` int(11) DEFAULT NULL,
  PRIMARY KEY (`oid`,`gid`,`sid`),
  KEY `fk_gid2` (`gid`),
  KEY `fk_sid2` (`sid`),
  CONSTRAINT `fk_gid2` FOREIGN KEY (`gid`) REFERENCES `grgoods` (`gid`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_oid2` FOREIGN KEY (`oid`) REFERENCES `grorder` (`oid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_sid2` FOREIGN KEY (`sid`) REFERENCES `standard` (`sid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_goods
-- ----------------------------
INSERT INTO `order_goods` VALUES ('1', '11', '1', '22');
INSERT INTO `order_goods` VALUES ('1', '11', '2', '222');

-- ----------------------------
-- Table structure for `standard`
-- ----------------------------
DROP TABLE IF EXISTS `standard`;
CREATE TABLE `standard` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `sname` varchar(255) NOT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of standard
-- ----------------------------
INSERT INTO `standard` VALUES ('1', '1kg');
INSERT INTO `standard` VALUES ('2', '2kg');
