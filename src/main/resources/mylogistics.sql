/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE IF NOT EXISTS `logistics` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin */;
USE `logistics`;

CREATE TABLE IF NOT EXISTS `t_base_data` (
  `base_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `base_name` varchar(100) DEFAULT NULL COMMENT '数据名称',
  `base_desc` varchar(200) DEFAULT NULL COMMENT '数据描述',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父id',
  PRIMARY KEY (`base_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='基础数据表';

/*!40000 ALTER TABLE `t_base_data` DISABLE KEYS */;
INSERT INTO `t_base_data` (`base_id`, `base_name`, `base_desc`, `parent_id`) VALUES
	(1, '区间管理', '物流能运送的区间范围', NULL),
	(2, '大陆', '国内', 1),
	(3, '香港', '香港', 1),
	(4, '美国', '', 1),
	(5, '取件方式', '', NULL),
	(6, '上门取件', '', 5),
	(7, '客户自行配送到仓库', '', 5),
	(8, '货运方式', '', NULL),
	(9, '海运', '', 8),
	(10, '空运', '坐飞机', 8),
	(11, '陆运', '', 8),
	(12, '付款方式', '', NULL),
	(13, '预付全款', '', 12),
	(14, '预付定金&到付全款', '', 12),
	(15, '到付', '到付', 12),
	(16, '单位', '描述货品单位', NULL),
	(27, '性别', '性别', NULL),
	(30, '下单方式', '下订单的方式', NULL),
	(32, '性别', '性别', NULL),
	(33, '男', 'boy', 32),
	(34, '女', 'girl', 32),
	(35, '保密', '保密', 32),
	(36, '只', '', 16),
	(37, '箱', '', 16),
	(38, '吨', '', 16),
	(39, '辆', '车的单位', 16),
	(40, '仓库', NULL, NULL),
	(41, '仓库1', NULL, 40),
	(42, '仓库2', NULL, 40);
/*!40000 ALTER TABLE `t_base_data` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `t_customer` (
  `customer_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '客户id',
  `customer_name` varchar(50) DEFAULT NULL COMMENT '客户名称',
  `phone` varchar(20) DEFAULT NULL COMMENT '电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `address` varchar(100) DEFAULT NULL COMMENT '地址',
  `gender` int(11) DEFAULT NULL COMMENT '性别 1男 2女',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `id_card` varchar(20) DEFAULT NULL COMMENT '身份证号码',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `base_id` bigint(20) NOT NULL COMMENT '基础数据id',
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='客户表';

/*!40000 ALTER TABLE `t_customer` DISABLE KEYS */;
INSERT INTO `t_customer` (`customer_id`, `customer_name`, `phone`, `email`, `address`, `gender`, `remark`, `id_card`, `user_id`, `base_id`) VALUES
	(1, '张无忌', '13553421632', 'zhangwuji@qq.com', '光明顶', 1, '我是张无忌', '234243243212323', 114, 3),
	(2, '乔峰', '13553334444', 'qiaof@qq.com', '襄阳', 1, '乔帮主厉害', '4353453234324', 3, 4),
	(4, '西门吹雪', '13212344321', 'xumen@qq.com', '不知道', 1, '西门吹雪厉害的角色', '2343234543535', 5, 2),
	(9, '虚竹', '13552431234', 'xuzhu@qq.com', '广东', 1, '和尚', '123456781234567890', 5, 3),
	(10, '东方姑娘', '13553421234', 'dongfang@qq.com', '黑木崖', 2, '搞不清楚性别', '123412341234123412', 5, 3),
	(12, '东方不败', '123123123', 'dfbb@163.com', '黑木崖，哈哈', 1, '搞不清性别的客户，哈哈', '123123123123', 114, 2);
/*!40000 ALTER TABLE `t_customer` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `t_order` (
  `order_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `customer_id` bigint(20) NOT NULL COMMENT '客户id',
  `shipping_address` varchar(100) DEFAULT NULL COMMENT '收货地址',
  `shipping_name` varchar(20) DEFAULT NULL COMMENT '收货人',
  `shipping_phone` varchar(20) DEFAULT NULL COMMENT '收货电话',
  `take_name` varchar(20) DEFAULT NULL COMMENT '取件联系人',
  `take_address` varchar(100) DEFAULT NULL COMMENT '取件地址',
  `take_phone` varchar(20) DEFAULT NULL COMMENT '取件电话',
  `order_status` int(11) DEFAULT NULL COMMENT '订单状态 1 取件 2 运送中 3 完成',
  `payment_method_id` bigint(20) DEFAULT NULL COMMENT '付款方式',
  `interval_id` bigint(20) DEFAULT NULL COMMENT '到达区域',
  `take_method_id` bigint(20) DEFAULT NULL COMMENT '取件方式',
  `freight_method_id` bigint(20) DEFAULT NULL COMMENT '货运方式',
  `order_remark` varchar(100) DEFAULT NULL COMMENT '订单备注',
  `take_money` bigint(20) DEFAULT NULL COMMENT '运费',
  `volume_rate` double DEFAULT NULL COMMENT '体积费率',
  `weight_rate` double DEFAULT NULL COMMENT '体重费率',
  `warehouse_id` bigint(20) DEFAULT NULL COMMENT '仓库id',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='订单表';

/*!40000 ALTER TABLE `t_order` DISABLE KEYS */;
INSERT INTO `t_order` (`order_id`, `user_id`, `customer_id`, `shipping_address`, `shipping_name`, `shipping_phone`, `take_name`, `take_address`, `take_phone`, `order_status`, `payment_method_id`, `interval_id`, `take_method_id`, `freight_method_id`, `order_remark`, `take_money`, `volume_rate`, `weight_rate`, `warehouse_id`) VALUES
	(6, 3, 1, '广州', '张三', '23123213', '小李子', '北京', '13552431632', 2, 13, 3, 6, 9, '国际物流', 1000, 100, 10, 41),
	(7, 2, 3, '北京', '李四', '13552431632', '李四', '香港', '13552431632', 1, 13, 3, 6, 9, '香港订单', NULL, NULL, NULL, NULL),
	(8, 2, 3, '上海', '王五', '13552431632', '李四', '香港', '13552431632', 1, 13, 3, 6, 9, '香港订单', NULL, NULL, NULL, NULL),
	(11, 3, 2, '天河', '小王', '123213213', '小李子', '元岗', '123123123', 1, 13, 4, 6, 9, '这是订单的备注', NULL, NULL, NULL, NULL),
	(22, 3, 2, '美国', '露西', '123213123', '汤姆', '美国-纽约', '12312321321', 1, 13, 4, 6, 9, '不知道物流的啥', NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `t_order` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `t_order_detail` (
  `order_detail_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单明细id',
  `order_id` bigint(20) NOT NULL COMMENT '订单id',
  `goods_name` varchar(20) DEFAULT NULL COMMENT '货物名称',
  `goods_number` int(11) DEFAULT NULL COMMENT '货物数量',
  `goods_unit` bigint(20) DEFAULT NULL COMMENT '货物单位',
  `goods_unit_price` decimal(10,0) DEFAULT NULL COMMENT '货物单价',
  `goods_total` decimal(10,0) DEFAULT NULL COMMENT '获取总价',
  `goods_remark` varchar(50) DEFAULT NULL COMMENT '备注',
  `goods_length` double DEFAULT NULL,
  `goods_width` double DEFAULT NULL,
  `goods_height` double DEFAULT NULL,
  `goods_volume` double DEFAULT NULL,
  `goods_weight` double DEFAULT NULL,
  PRIMARY KEY (`order_detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='订单明细';

/*!40000 ALTER TABLE `t_order_detail` DISABLE KEYS */;
INSERT INTO `t_order_detail` (`order_detail_id`, `order_id`, `goods_name`, `goods_number`, `goods_unit`, `goods_unit_price`, `goods_total`, `goods_remark`, `goods_length`, `goods_width`, `goods_height`, `goods_volume`, `goods_weight`) VALUES
	(1, 6, '冰箱fasdf', 1, 36, 1000, 1000, '格力', 10, 10, 20, 0.002, 0),
	(2, 6, '红酒', 2, 36, 10000, 20000, '82年拉菲', 10, 10, 20, 0.004, 0),
	(3, 6, '小汽车', 1, 36, 1000000, 1000000, '保时捷', 12, 10, 200, 0.024, 0),
	(4, 7, '汽车', 1, 23, 10000000, 10000000, '法拉利', NULL, NULL, NULL, NULL, NULL),
	(5, 7, '红酒', 2, 24, 30000, 60000, '82年的拉菲', NULL, NULL, NULL, NULL, NULL),
	(6, 8, '汽车', 1, 23, 10000000, 10000000, '法拉利', NULL, NULL, NULL, NULL, NULL),
	(7, 8, '红酒', 2, 24, 30000, 60000, '82年的拉菲', NULL, NULL, NULL, NULL, NULL),
	(9, 11, '桌子', 2, 21, 10000, 20000, '红木桌子', NULL, NULL, NULL, NULL, NULL),
	(10, 11, '洗衣机', 3, 17, 20000, 60000, '海尔', NULL, NULL, NULL, NULL, NULL),
	(11, 11, '白酒', 5, 24, 5000, 25000, '茅台', NULL, NULL, NULL, NULL, NULL),
	(16, 22, '电脑', 2, 36, 20000, 40000, '苹果电脑', NULL, NULL, NULL, NULL, NULL),
	(17, 22, '洗衣机', 3, 36, 2000, 6000, '海尔洗衣机', NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `t_order_detail` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `t_permission` (
  `permission_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  `expression` varchar(50) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `sort` int(10) DEFAULT NULL,
  PRIMARY KEY (`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `t_permission` DISABLE KEYS */;
INSERT INTO `t_permission` (`permission_id`, `name`, `type`, `url`, `expression`, `parent_id`, `sort`) VALUES
	(1, '管理员管理', 'menu', '', 'admin:adminManager', 0, NULL),
	(2, '系统管理', 'menu', '', 'system:systemManager', 0, NULL),
	(3, '物流管理', 'menu', '', 'logistics:logisticsManager', 0, NULL),
	(4, '管理员操作', 'menu', '/admin/adminPage.do', 'admin:adminPage', 1, NULL),
	(5, '角色操作', 'menu', '/role/rolePage.do', 'role:rolePage', 1, NULL),
	(6, '权限操作', 'menu', '/permission/permissionPage.do', 'permission:permissionPage', 1, NULL),
	(7, '客户操作', 'menu', '/customer/customerPage.do', 'customer:customerPage', 1, NULL),
	(8, '基础数据操作', 'menu', '/baseData/baseDataPage.do', 'basicData:basicDatapage', 2, NULL),
	(9, '订单管理操作', 'menu', '/order/orderPage.do', 'order:orderPage', 3, NULL),
	(10, '核对入库操作', 'menu', '/order/checkOrderPage.do', 'order:checkOrderPage', 3, NULL),
	(11, '财务审核操作', 'menu', '/order/financePage.do', 'order:financePage', 3, NULL),
	(12, '管理员列表', 'permission', '/admin/list.do', 'admin:list', 4, NULL),
	(13, '添加管理员', 'permission', '/admin/insert.do', 'admin:insert', 4, NULL),
	(14, '删除管理员', 'permission', '/admin/delete.do', 'admin:delete', 4, NULL),
	(15, '修改管理员', 'permission', '/admin/update.do', 'admin:update', 4, NULL),
	(16, '批量删除管理员', 'permission', '/admin/batchDelete.do', 'admin:batchDelete', 4, NULL),
	(17, '角色列表', 'permission', '/role/list.do', 'role:list', 5, NULL),
	(18, '添加角色', 'permission', '/role/insert.do', 'role:insert', 5, NULL),
	(19, '删除角色', 'permission', '/role/delete.do', 'role:delete', 5, NULL),
	(20, '修改角色', 'permission', '/role/update.do', 'role:update', 5, NULL),
	(21, '批量删除角色', 'permission', '/role/batchDelete.do', 'role:batchDelete', 5, NULL),
	(22, '权限列表', 'permission', '/permission/list.do', 'permission:list', 6, NULL),
	(23, '添加权限', 'permission', '/permission/insert.do', 'permission:insert', 6, NULL),
	(24, '删除权限', 'permission', '/permission/delete.do', 'permission:delete', 6, NULL),
	(25, '修改权限', 'permission', '/permission/update.do', 'permission:update', 6, NULL),
	(26, '批量删除权限', 'permission', '/permission/batchDelete.do', 'permission:batchDelete', 6, NULL),
	(27, '客户列表', 'permission', '/customer/list.do', 'customer:list', 7, NULL),
	(28, '添加客户', 'permission', '/customer/insert.do', 'customer:insert', 7, NULL),
	(29, '删除客户', 'permission', '/customer/delete.do', 'customer:delete', 7, NULL),
	(30, '修改客户', 'permission', '/customer/update.do', 'customer:update', 7, NULL),
	(31, '批量删除客户', 'permission', '/customer/batchDelete.do', 'customer:batchDelete', 7, NULL),
	(32, '基础数据列表', 'permission', '/baseData/list.do', 'basicData:list', 8, NULL),
	(33, '添加基础数据', 'permission', '/baseData/insert.do', 'basicData:insert', 8, NULL),
	(34, '删除基础数据', 'permission', '/baseData/delete.do', 'basicData:delete', 8, NULL),
	(35, '修改基础数据', 'permission', '/baseData/update.do', 'basicData:update', 8, NULL),
	(36, '批量删除基础数据', 'permission', '/baseData/batchDelete.do', 'basicData:batchDelete', 8, NULL),
	(37, '订单列表', 'permission', '/order/list.do', 'order:list', 9, NULL),
	(38, '添加订单', 'permission', '/order/insert.do', 'order:insert', 9, NULL),
	(39, '删除订单', 'permission', '/order/delete.do', 'order:delete', 9, NULL),
	(40, '修改订单', 'permission', '/order/update.do', 'order:update', 9, NULL),
	(41, '批量删除订单', 'permission', '/order/batchDelete.do', 'order:batchDelete', 9, NULL);
/*!40000 ALTER TABLE `t_permission` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `t_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(50) DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  `permission_ids` varchar(200) DEFAULT NULL COMMENT '角色id，多个角色使用逗号隔开 1,2,3,4',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `t_role` DISABLE KEYS */;
INSERT INTO `t_role` (`role_id`, `rolename`, `remark`, `permission_ids`) VALUES
	(1, '超级管理员', '拥有至高无上的权力', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41'),
	(2, '总经理', '领导', '1,5,17,18,19,20,21,6,22,23,24,25,26,7,27,28,29,30,31,2,8,32,33,34,35,36,3,9,37,38,39,40,41,10,11'),
	(3, '业务员', '跑业务，拉单', '1,7,27,28,29,30,31,3,9,37,38,39,40,41,10,11'),
	(4, '操作员', '操作订单数据', '3,9,37,38,39,40,41,10,11'),
	(5, '财务', '管钱的', '3,9,37,38,39,40,10,11'),
	(6, '仓管员', '管仓库的', '3,10'),
	(7, '管理员', '物流业务的管理的管理员', '1,4,12,13,14,15,16');
/*!40000 ALTER TABLE `t_role` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `t_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `realname` varchar(50) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `salt` varchar(50) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  `create_date` date DEFAULT NULL,
  `role_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `t_user` DISABLE KEYS */;
INSERT INTO `t_user` (`user_id`, `username`, `realname`, `password`, `salt`, `status`, `create_date`, `role_id`) VALUES
	(1, 'admin', '林林', '210a0f8019e04dd0a76b3c1eba31b49a', '14b00', 1, '2019-07-16', 1),
	(121, 'linx_x', '黑寡妇', 'e3234c2da5435dff240a68c6dfb9698a', '468e7', NULL, '2020-03-05', 2);
/*!40000 ALTER TABLE `t_user` ENABLE KEYS */;

CREATE TABLE `v_customer` (
	`customer_id` BIGINT(20) NOT NULL COMMENT '客户id',
	`customer_name` VARCHAR(50) NULL COMMENT '客户名称' COLLATE 'utf8_general_ci',
	`phone` VARCHAR(20) NULL COMMENT '电话' COLLATE 'utf8_general_ci',
	`email` VARCHAR(50) NULL COMMENT '邮箱' COLLATE 'utf8_general_ci',
	`address` VARCHAR(100) NULL COMMENT '地址' COLLATE 'utf8_general_ci',
	`gender` INT(11) NULL COMMENT '性别 1男 2女',
	`remark` VARCHAR(100) NULL COMMENT '备注' COLLATE 'utf8_general_ci',
	`id_card` VARCHAR(20) NULL COMMENT '身份证号码' COLLATE 'utf8_general_ci',
	`user_id` BIGINT(20) NOT NULL COMMENT '用户id',
	`base_id` BIGINT(20) NOT NULL COMMENT '基础数据id',
	`realname` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`base_name` VARCHAR(100) NULL COMMENT '数据名称' COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `v_customer`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_customer` AS select `c`.`customer_id` AS `customer_id`,`c`.`customer_name` AS `customer_name`,`c`.`phone` AS `phone`,`c`.`email` AS `email`,`c`.`address` AS `address`,`c`.`gender` AS `gender`,`c`.`remark` AS `remark`,`c`.`id_card` AS `id_card`,`c`.`user_id` AS `user_id`,`c`.`base_id` AS `base_id`,`u`.`realname` AS `realname`,`b`.`base_name` AS `base_name` from ((`t_customer` `c` join `t_user` `u`) join `t_base_data` `b`) where ((`c`.`user_id` = `u`.`user_id`) and (`c`.`base_id` = `b`.`base_id`)) ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
