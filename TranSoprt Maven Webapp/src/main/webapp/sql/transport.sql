/*
Navicat MySQL Data Transfer

Source Server         : test
Source Server Version : 50624
Source Host           : localhost:3306
Source Database       : transport

Target Server Type    : MYSQL
Target Server Version : 50624
File Encoding         : 65001

Date: 2016-01-26 11:59:44
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

-- ----------------------------
-- Table structure for `dealer`
-- ----------------------------
DROP TABLE IF EXISTS `dealer`;
CREATE TABLE `dealer` (
  `did` int(11) NOT NULL AUTO_INCREMENT,
  `dname` varchar(255) DEFAULT NULL,
  `dpwd` varchar(255) DEFAULT NULL,
  `phone` char(11) NOT NULL,
  `province` varchar(255) DEFAULT NULL,
  `limitdays` int(11) DEFAULT NULL,
  `dynamic` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`did`),
  UNIQUE KEY `index_phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dealer
-- ----------------------------
INSERT INTO `dealer` VALUES ('1', '经销商1', 'b3ddbc502e307665f346cbd6e52cc10d', '23432', '广州', '4', null);
INSERT INTO `dealer` VALUES ('2', '经销商2', 'f1b24036355f123631e50d86742af8b2', '18826243880', '饶平', '1', null);

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
INSERT INTO `goods_standard` VALUES ('18', '1');
INSERT INTO `goods_standard` VALUES ('32', '1');
INSERT INTO `goods_standard` VALUES ('34', '1');
INSERT INTO `goods_standard` VALUES ('35', '1');
INSERT INTO `goods_standard` VALUES ('19', '2');
INSERT INTO `goods_standard` VALUES ('20', '2');
INSERT INTO `goods_standard` VALUES ('22', '2');
INSERT INTO `goods_standard` VALUES ('32', '2');
INSERT INTO `goods_standard` VALUES ('22', '8');
INSERT INTO `goods_standard` VALUES ('11', '10');
INSERT INTO `goods_standard` VALUES ('39', '10');
INSERT INTO `goods_standard` VALUES ('32', '11');
INSERT INTO `goods_standard` VALUES ('36', '11');
INSERT INTO `goods_standard` VALUES ('38', '11');
INSERT INTO `goods_standard` VALUES ('38', '13');
INSERT INTO `goods_standard` VALUES ('38', '14');
INSERT INTO `goods_standard` VALUES ('44', '17');
INSERT INTO `goods_standard` VALUES ('11', '19');

-- ----------------------------
-- Table structure for `grfactory`
-- ----------------------------
DROP TABLE IF EXISTS `grfactory`;
CREATE TABLE `grfactory` (
  `fid` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(255) DEFAULT NULL,
  `fpwd` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`fid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of grfactory
-- ----------------------------
INSERT INTO `grfactory` VALUES ('1', '厂家1', '123123');
INSERT INTO `grfactory` VALUES ('2', '厂家2', '123');

-- ----------------------------
-- Table structure for `grgoods`
-- ----------------------------
DROP TABLE IF EXISTS `grgoods`;
CREATE TABLE `grgoods` (
  `gid` int(11) NOT NULL AUTO_INCREMENT,
  `gname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of grgoods
-- ----------------------------
INSERT INTO `grgoods` VALUES ('11', '蛋糕');
INSERT INTO `grgoods` VALUES ('18', '奶酪6');
INSERT INTO `grgoods` VALUES ('19', '奶酪7');
INSERT INTO `grgoods` VALUES ('20', '奶酪8');
INSERT INTO `grgoods` VALUES ('22', '奶酪11');
INSERT INTO `grgoods` VALUES ('32', '花生2');
INSERT INTO `grgoods` VALUES ('34', '海鲜');
INSERT INTO `grgoods` VALUES ('35', '炸鸡');
INSERT INTO `grgoods` VALUES ('36', '果子');
INSERT INTO `grgoods` VALUES ('38', '白酒');
INSERT INTO `grgoods` VALUES ('39', '可乐');
INSERT INTO `grgoods` VALUES ('44', '水');

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
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`oid`),
  KEY `fk_dealer` (`dealerid`),
  KEY `fk_factory` (`factoryid`),
  CONSTRAINT `fk_dealer` FOREIGN KEY (`dealerid`) REFERENCES `dealer` (`did`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_factory` FOREIGN KEY (`factoryid`) REFERENCES `grfactory` (`fid`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of grorder
-- ----------------------------
INSERT INTO `grorder` VALUES ('2', '1', '2016-01-18', '2016-01-31', '2016-01-18', null, '已发货');
INSERT INTO `grorder` VALUES ('3', '1', '2016-01-22', '2016-01-13', '2016-01-06', null, '已发货');
INSERT INTO `grorder` VALUES ('4', '1', '2016-01-18', '2016-01-18', '2016-01-18', null, null);
INSERT INTO `grorder` VALUES ('5', '1', '2016-01-18', '2016-01-18', '2016-01-18', null, null);
INSERT INTO `grorder` VALUES ('7', '1', '2016-01-18', '2016-01-18', '2016-01-18', null, null);
INSERT INTO `grorder` VALUES ('8', '1', '2016-01-18', '2016-01-18', '2016-01-18', null, null);
INSERT INTO `grorder` VALUES ('9', '1', '2016-01-18', '2016-01-18', '2016-01-18', null, null);
INSERT INTO `grorder` VALUES ('10', '1', '2016-01-18', '2016-01-18', '2016-01-18', null, null);
INSERT INTO `grorder` VALUES ('11', '1', '2016-01-18', '2016-01-18', '2016-01-18', null, null);
INSERT INTO `grorder` VALUES ('12', '1', '2016-01-18', '2016-01-18', '2016-01-18', null, null);
INSERT INTO `grorder` VALUES ('22', '1', '2016-01-19', '2016-01-25', '2016-01-06', '1', '已发货');

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
INSERT INTO `order_goods` VALUES ('2', '11', '2', '222');
INSERT INTO `order_goods` VALUES ('2', '11', '8', '33');
INSERT INTO `order_goods` VALUES ('22', '11', '1', '22');

-- ----------------------------
-- Table structure for `standard`
-- ----------------------------
DROP TABLE IF EXISTS `standard`;
CREATE TABLE `standard` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `sname` varchar(255) NOT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of standard
-- ----------------------------
INSERT INTO `standard` VALUES ('1', '1kg');
INSERT INTO `standard` VALUES ('2', '2kg');
INSERT INTO `standard` VALUES ('8', '5kg');
INSERT INTO `standard` VALUES ('10', '500g');
INSERT INTO `standard` VALUES ('11', '6kg');
INSERT INTO `standard` VALUES ('13', '2斤');
INSERT INTO `standard` VALUES ('14', '5斤');
INSERT INTO `standard` VALUES ('17', '1盒');
INSERT INTO `standard` VALUES ('19', '100mg');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(25) NOT NULL,
  `password` varchar(16) NOT NULL,
  `nickname` varchar(26) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'Joe', '19940816', '黄晓强');
