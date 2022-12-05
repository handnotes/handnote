CREATE TABLE wallet_category
(
    id        INTEGER PRIMARY KEY AUTOINCREMENT,
    pid       INTEGER,                     -- 父分类
    type      INTEGER  NOT NULL,           -- 类型 (0: 支出 1: 收入)
    name      TEXT     NOT NULL,           -- 分类名称
    icon      TEXT,                        -- 分类图标
    sort      INTEGER  NOT NULL DEFAULT 0, -- 排序
    status    INTEGER  NOT NULL DEFAULT 1, -- 状态 (0: 禁用 1: 启用)
    createdAt DATETIME NOT NULL DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW')),
    updatedAt DATETIME NOT NULL DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW')),
    deletedAt DATETIME
);

-- 系统分类
INSERT INTO wallet_category (id, pid, type, name, icon, sort)
VALUES (0, NULL, 0, '', NULL, 0),
       (1, 0, 0, '投资', '{"pack":"custom","iconData":{"codePoint":58986,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', -1),
       (2, 0, 0, '投资亏损', '{"pack":"custom","iconData":{"codePoint":59351,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', -1),
       (3, 0, 0, '借出', '{"pack":"custom","iconData":{"codePoint":58920,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', -1),
       (4, 0, 0, '还贷', '{"pack":"custom","iconData":{"codePoint":58963,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', -1),
       (5, 0, 0, '利息支出', '{"pack":"custom","iconData":{"codePoint":58891,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', -1),
       (49, 0, 0, '其他支出', '{"pack":"custom","iconData":{"codePoint":58882,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', -2),

       (-1, NULL, 0, '余额调整', '', -2),

       (50, 0, 1, '借入', '{"pack":"custom","iconData":{"codePoint":58994,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', -1),
       (51, 0, 1, '收债', '{"pack":"custom","iconData":{"codePoint":59662,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', -1),
       (52, 0, 1, '利息收入', '{"pack":"custom","iconData":{"codePoint":58910,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', -1),
       (53, 0, 1, '投资回收', '{"pack":"custom","iconData":{"codePoint":59340,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', -1),
       (54, 0, 1, '投资收益', '{"pack":"custom","iconData":{"codePoint":59344,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', -1),
       (55, 0, 1, '报销收入', '{"pack":"custom","iconData":{"codePoint":58637,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', -1),
       (56, 0, 1, '退款', '{"pack":"custom","iconData":{"codePoint":58636,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', -1),
       (99, 0, 1, '其他收入', '{"pack":"custom","iconData":{"codePoint":58918,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', -2);

-- 预设分类
INSERT INTO wallet_category (id, pid, sort, type, name, icon)
VALUES (100, 0, 0, 0, '餐饮', '{"pack":"custom","iconData":{"codePoint":57946,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}'),
       (101, 0, 0, 0, '零食烟酒', '{"pack":"custom","iconData":{"codePoint":59121,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}'),
       (102, 0, 0, 0, '日常', '{"pack":"custom","iconData":{"codePoint":58780,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}'),
       (103, 0, 0, 0, '购物', '{"pack":"custom","iconData":{"codePoint":58780,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}'),
       (104, 0, 0, 0, '住房', '{"pack":"custom","iconData":{"codePoint":58152,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}'),
       (105, 0, 0, 0, '交通', '{"pack":"custom","iconData":{"codePoint":57813,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}'),
       (106, 0, 0, 0, '通讯', '{"pack":"custom","iconData":{"codePoint":58271,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}'),
       (107, 0, 0, 0, '娱乐聚会', '{"pack":"custom","iconData":{"codePoint":58413,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}'),
       (108, 0, 0, 0, '人情交友', '{"pack":"custom","iconData":{"codePoint":59078,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}'),
       (109, 0, 0, 0, '运动健身', '{"pack":"custom","iconData":{"codePoint":59010,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}'),
       (110, 0, 0, 0, '文教', '{"pack":"custom","iconData":{"codePoint":57488,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}'),
       (111, 0, 0, 0, '医疗', '{"pack":"custom","iconData":{"codePoint":58262,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}'),
       (112, 0, 0, 0, '汽车', '{"pack":"custom","iconData":{"codePoint":57815,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}'),
       (113, 0, 0, 0, '旅行', '{"pack":"custom","iconData":{"codePoint":58009,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}'),
       (114, 0, 0, 0, '育儿', '{"pack":"custom","iconData":{"codePoint":57539,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}'),
       (115, 0, 0, 0, '宠物', '{"pack":"custom","iconData":{"codePoint":58885,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}'),
       (116, 0, 0, 0, '转出', '{"pack":"custom","iconData":{"codePoint":58739,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}'),
       (117, 0, 0, 0, '捐赠', '{"pack":"custom","iconData":{"codePoint":59078,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}'),
       (118, 0, 0, 0, '罚款', '{"pack":"custom","iconData":{"codePoint":57511,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}'),
       (119, 0, 0, 0, '软件', '{"pack":"custom","iconData":{"codePoint":58215,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}'),

       (150, 0, 0, 1, '薪资', '{"pack":"custom","iconData":{"codePoint":59043,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}'),
       (151, 0, 0, 1, '奖金', '{"pack":"custom","iconData":{"codePoint":58360,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}'),
       (152, 0, 0, 1, '兼职', '{"pack":"custom","iconData":{"codePoint":58897,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}'),
       (153, 0, 0, 1, '转入', '{"pack":"custom","iconData":{"codePoint":58380,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}'),
       (199, 0, 0, 1, '意外所得', '{"pack":"custom","iconData":{"codePoint":59009,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}');

-- 子分类
INSERT INTO wallet_category (id, pid, type, name, icon, sort) VALUES
       -- max 283
       (282, 4, 0, '房贷', '{"pack":"custom","iconData":{"codePoint":58152,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (283, 4, 0, '车贷', '{"pack":"custom","iconData":{"codePoint":57660,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),

       (200, 100, 0, '早餐', '{"pack":"custom","iconData":{"codePoint":58894,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (201, 100, 0, '日常餐', '{"pack":"custom","iconData":{"codePoint":58026,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (202, 100, 0, '外卖', '{"pack":"custom","iconData":{"codePoint":58901,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (203, 100, 0, '食材', '{"pack":"custom","iconData":{"codePoint":58896,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (204, 100, 0, '调味料', '{"pack":"custom","iconData":{"codePoint":58884,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (205, 100, 0, '方便食品', '{"pack":"custom","iconData":{"codePoint":58889,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (206, 101, 0, '水果', '{"pack":"custom","iconData":{"codePoint":58934,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (207, 101, 0, '饮料', '{"pack":"custom","iconData":{"codePoint":58887,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (208, 101, 0, '零食', '{"pack":"custom","iconData":{"codePoint":58888,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (209, 101, 0, '甜品', '{"pack":"custom","iconData":{"codePoint":59041,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (210, 101, 0, '烟', '{"pack":"custom","iconData":{"codePoint":58933,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (211, 101, 0, '酒', '{"pack":"custom","iconData":{"codePoint":58970,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (212, 101, 0, '茶水', '{"pack":"custom","iconData":{"codePoint":58895,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (213, 102, 0, '日用', '{"pack":"custom","iconData":{"codePoint":58955,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (214, 103, 0, '美容美发', '{"pack":"custom","iconData":{"codePoint":57745,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (215, 103, 0, '美妆品', '{"pack":"custom","iconData":{"codePoint":58936,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (216, 102, 0, '快递', '{"pack":"custom","iconData":{"codePoint":57469,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (217, 102, 0, '清洁', '{"pack":"custom","iconData":{"codePoint":58928,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (218, 102, 0, '卫生用品', '{"pack":"custom","iconData":{"codePoint":58924,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (219, 102, 0, '计生用品', '{"pack":"custom","iconData":{"codePoint":58942,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (220, 103, 0, '数码', '{"pack":"custom","iconData":{"codePoint":58898,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (221, 103, 0, '鞋帽服装', '{"pack":"custom","iconData":{"codePoint":58990,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (222, 103, 0, '饰品', '{"pack":"custom","iconData":{"codePoint":58922,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (223, 104, 0, '电费', '{"pack":"custom","iconData":{"codePoint":58944,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (224, 104, 0, '水费', '{"pack":"custom","iconData":{"codePoint":59001,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (225, 104, 0, '燃气费', '{"pack":"custom","iconData":{"codePoint":58258,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (226, 104, 0, '物业费', '{"pack":"custom","iconData":{"codePoint":58950,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (227, 104, 0, '房租', '{"pack":"custom","iconData":{"codePoint":58971,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (228, 104, 0, '五金维修', '{"pack":"custom","iconData":{"codePoint":58912,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (229, 104, 0, '电器', '{"pack":"custom","iconData":{"codePoint":58937,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (230, 104, 0, '家具', '{"pack":"custom","iconData":{"codePoint":58938,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (231, 105, 0, '打车', '{"pack":"custom","iconData":{"codePoint":59093,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (232, 105, 0, '公交地铁', '{"pack":"custom","iconData":{"codePoint":57813,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (233, 105, 0, '共享单车', '{"pack":"custom","iconData":{"codePoint":58995,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (234, 105, 0, '火车票', '{"pack":"custom","iconData":{"codePoint":57818,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (235, 105, 0, '机票', '{"pack":"custom","iconData":{"codePoint":57454,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),

       (236, 106, 0, '话费', '{"pack":"custom","iconData":{"codePoint":59146,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (237, 106, 0, '宽带费', '{"pack":"custom","iconData":{"codePoint":60153,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (238, 107, 0, '游戏', '{"pack":"custom","iconData":{"codePoint":58913,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (239, 107, 0, '聚餐', '{"pack":"custom","iconData":{"codePoint":58946,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (240, 107, 0, '桌游棋牌', '{"pack":"custom","iconData":{"codePoint":58921,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (241, 107, 0, '酒吧K歌', '{"pack":"custom","iconData":{"codePoint":58978,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (242, 107, 0, '约会', '{"pack":"custom","iconData":{"codePoint":58939,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (243, 107, 0, '电影演出', '{"pack":"custom","iconData":{"codePoint":58905,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (244, 107, 0, '游乐场', '{"pack":"custom","iconData":{"codePoint":59098,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (245, 108, 0, '红包', '{"pack":"custom","iconData":{"codePoint":58993,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (246, 108, 0, '礼物', '{"pack":"custom","iconData":{"codePoint":57662,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (247, 108, 0, '请客', '{"pack":"custom","iconData":{"codePoint":59123,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (248, 109, 0, '运动用品', '{"pack":"custom","iconData":{"codePoint":58925,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (249, 109, 0, '场地', '{"pack":"custom","iconData":{"codePoint":59608,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (250, 109, 0, '教练', '{"pack":"custom","iconData":{"codePoint":59105,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (251, 110, 0, '考试', '{"pack":"custom","iconData":{"codePoint":59603,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (252, 110, 0, '书籍', '{"pack":"custom","iconData":{"codePoint":58900,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (253, 110, 0, '课程', '{"pack":"custom","iconData":{"codePoint":58974,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (254, 110, 0, '讲座', '{"pack":"custom","iconData":{"codePoint":58927,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (255, 110, 0, '学费', '{"pack":"custom","iconData":{"codePoint":59198,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (256, 110, 0, '文具', '{"pack":"custom","iconData":{"codePoint":60093,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (257, 111, 0, '药品', '{"pack":"custom","iconData":{"codePoint":58914,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (258, 111, 0, '就诊', '{"pack":"custom","iconData":{"codePoint":58935,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (259, 111, 0, '保健', '{"pack":"custom","iconData":{"codePoint":58929,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (260, 111, 0, '住院', '{"pack":"custom","iconData":{"codePoint":58988,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (261, 111, 0, '健康保险', '{"pack":"custom","iconData":{"codePoint":59121,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (262, 112, 0, '维修保养', '{"pack":"custom","iconData":{"codePoint":59008,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (263, 112, 0, '停车', '{"pack":"custom","iconData":{"codePoint":58957,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (264, 112, 0, '加油', '{"pack":"custom","iconData":{"codePoint":58926,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (265, 112, 0, '罚款', '{"pack":"custom","iconData":{"codePoint":58907,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (266, 112, 0, '车险', '{"pack":"custom","iconData":{"codePoint":58930,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (267, 113, 0, '团费', '{"pack":"custom","iconData":{"codePoint":58915,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (268, 113, 0, '景点门票', '{"pack":"custom","iconData":{"codePoint":58964,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (269, 113, 0, '纪念品', '{"pack":"custom","iconData":{"codePoint":59029,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (270, 113, 0, '旅行路费', '{"pack":"custom","iconData":{"codePoint":57453,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (271, 113, 0, '酒店', '{"pack":"custom","iconData":{"codePoint":59528,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (272, 114, 0, '奶粉', '{"pack":"custom","iconData":{"codePoint":58945,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (273, 114, 0, '孕妇用品', '{"pack":"custom","iconData":{"codePoint":58943,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (274, 114, 0, '育儿嫂', '{"pack":"custom","iconData":{"codePoint":59148,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (275, 114, 0, '洗护', '{"pack":"custom","iconData":{"codePoint":59019,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (276, 114, 0, '儿童玩具', '{"pack":"custom","iconData":{"codePoint":58904,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (277, 114, 0, '童装', '{"pack":"custom","iconData":{"codePoint":58932,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (278, 115, 0, '宠物食品', '{"pack":"custom","iconData":{"codePoint":58931,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (279, 115, 0, '猫砂', '{"pack":"custom","iconData":{"codePoint":58917,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (280, 115, 0, '宠物医疗', '{"pack":"custom","iconData":{"codePoint":60482,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (281, 153, 0, '生活费', '{"pack":"custom","iconData":{"codePoint":57914,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0);
