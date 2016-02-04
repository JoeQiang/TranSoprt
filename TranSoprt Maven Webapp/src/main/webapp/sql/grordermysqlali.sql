/*
Navicat MySQL Data Transfer

Source Server         : test
Source Server Version : 50624
Source Host           : localhost:3306
Source Database       : grordermysqlali

Target Server Type    : MYSQL
Target Server Version : 50624
File Encoding         : 65001

Date: 2016-02-05 00:05:08
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
INSERT INTO `admin` VALUES ('1', 'admin', '202cb962ac59075b964b07152d234b70', '管理员');

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
INSERT INTO `dealer` VALUES ('2', 'jerry', '202cb962ac59075b964b07152d234b70', '18826243880', '广州', '3', 'a17d9b51192a0fefe5a6f6feba16411e');

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
INSERT INTO `goods_standard` VALUES ('2', '2');

-- ----------------------------
-- Table structure for `grfactory`
-- ----------------------------
DROP TABLE IF EXISTS `grfactory`;
CREATE TABLE `grfactory` (
  `fid` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(255) DEFAULT NULL,
  `fpwd` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`fid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of grfactory
-- ----------------------------
INSERT INTO `grfactory` VALUES ('3', '甲', '202cb962ac59075b964b07152d234b70');

-- ----------------------------
-- Table structure for `grgoods`
-- ----------------------------
DROP TABLE IF EXISTS `grgoods`;
CREATE TABLE `grgoods` (
  `gid` int(11) NOT NULL AUTO_INCREMENT,
  `gname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of grgoods
-- ----------------------------
INSERT INTO `grgoods` VALUES ('2', '牛奶');

-- ----------------------------
-- Table structure for `grorder`
-- ----------------------------
DROP TABLE IF EXISTS `grorder`;
CREATE TABLE `grorder` (
  `oid` int(11) NOT NULL AUTO_INCREMENT,
  `seqnum` varchar(255) DEFAULT NULL COMMENT '序号',
  `dealerid` int(11) DEFAULT NULL,
  `createday` date DEFAULT NULL,
  `sendday` date DEFAULT NULL,
  `reqarrday` int(11) DEFAULT NULL COMMENT '发货后规定到达天数',
  `gid` int(11) DEFAULT NULL,
  `sid` int(11) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `factoryid` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`oid`),
  KEY `fk_dealer` (`dealerid`),
  KEY `fk_factory` (`factoryid`),
  KEY `fk_gid45435` (`gid`),
  KEY `fk_sid3432` (`sid`),
  CONSTRAINT `fk_dealer` FOREIGN KEY (`dealerid`) REFERENCES `dealer` (`did`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_factory` FOREIGN KEY (`factoryid`) REFERENCES `grfactory` (`fid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_gid45435` FOREIGN KEY (`gid`) REFERENCES `grgoods` (`gid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_sid3432` FOREIGN KEY (`sid`) REFERENCES `standard` (`sid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of grorder
-- ----------------------------
INSERT INTO `grorder` VALUES ('3', null, '2', '2016-02-04', null, '8', '2', '2', '2', '3', '未发货');
INSERT INTO `grorder` VALUES ('4', null, '2', '2016-02-04', null, '3', '2', '2', '23', '3', '未发货');
INSERT INTO `grorder` VALUES ('5', null, '2', '2016-02-04', null, '19', '2', '2', '20', '3', '未发货');

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
INSERT INTO `standard` VALUES ('2', '1kg');

-- ----------------------------
-- Table structure for `t_public`
-- ----------------------------
DROP TABLE IF EXISTS `t_public`;
CREATE TABLE `t_public` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_public
-- ----------------------------
INSERT INTO `t_public` VALUES ('1', '');
