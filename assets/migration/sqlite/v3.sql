CREATE TABLE wallet_category
(
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    pid        INTEGER,                    -- 父分类
    type       INTEGER NOT NULL,           -- 类型 (0: 支出 1: 收入)
    name       TEXT    NOT NULL,           -- 分类名称
    icon       TEXT,                       -- 分类图标
    sort       INTEGER NOT NULL DEFAULT 0, -- 排序
    status     INTEGER NOT NULL DEFAULT 1, -- 状态 (0: 禁用 1: 启用)
    created_at DATETIME NOT NULL DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW')),
    updated_at DATETIME NOT NULL DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW')),
    deleted_at DATETIME
);

INSERT INTO wallet_category (id, pid, type, name, icon, sort)
VALUES (0, NULL, 0, '', NULL, 0),
       (1, 0, 0, '投资', '{"pack":"custom","iconData":{"codePoint":58986,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', -1),
       (2, 0, 0, '投资亏损', '{"pack":"custom","iconData":{"codePoint":59351,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', -1),
       (3, 0, 0, '借出', '{"pack":"custom","iconData":{"codePoint":58920,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', -1),
       (4, 0, 0, '还债', '{"pack":"custom","iconData":{"codePoint":58963,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', -1),
       (5, 0, 0, '利息支出', '{"pack":"custom","iconData":{"codePoint":58891,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', -1),
       (49, 0, 0, '其他支出', '{"pack":"custom","iconData":{"codePoint":58882,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', -2),

       (50, 0, 1, '借入', '{"pack":"custom","iconData":{"codePoint":58994,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', -1),
       (51, 0, 1, '收债', '{"pack":"custom","iconData":{"codePoint":59662,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', -1),
       (52, 0, 1, '利息收入', '{"pack":"custom","iconData":{"codePoint":58910,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', -1),
       (53, 0, 1, '投资回收', '{"pack":"custom","iconData":{"codePoint":59340,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', -1),
       (54, 0, 1, '投资收益', '{"pack":"custom","iconData":{"codePoint":59344,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', -1),
       (55, 0, 1, '报销收入', '{"pack":"custom","iconData":{"codePoint":58637,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', -1),
       (56, 0, 1, '退款', '{"pack":"custom","iconData":{"codePoint":58636,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', -1),
       (99, 0, 1, '其他收入', '{"pack":"custom","iconData":{"codePoint":58918,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', -2);

INSERT INTO wallet_category (id, pid, type, name, icon, sort)
VALUES (100, 0, 0, '餐饮', '{"pack":"custom","iconData":{"codePoint":57946,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (101, 0, 0, '零食烟酒', '{"pack":"custom","iconData":{"codePoint":59121,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (102, 0, 0, '日常开销', '{"pack":"custom","iconData":{"codePoint":58780,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (103, 0, 0, '住房', '{"pack":"custom","iconData":{"codePoint":58152,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (104, 0, 0, '交通', '{"pack":"custom","iconData":{"codePoint":57813,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (105, 0, 0, '通讯', '{"pack":"custom","iconData":{"codePoint":58271,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (106, 0, 0, '娱乐聚会', '{"pack":"custom","iconData":{"codePoint":58413,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (107, 0, 0, '人情交友', '{"pack":"custom","iconData":{"codePoint":59078,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (108, 0, 0, '运动健身', '{"pack":"custom","iconData":{"codePoint":59010,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (109, 0, 0, '文教', '{"pack":"custom","iconData":{"codePoint":57488,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (110, 0, 0, '医疗', '{"pack":"custom","iconData":{"codePoint":58262,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (111, 0, 0, '汽车', '{"pack":"custom","iconData":{"codePoint":57815,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (112, 0, 0, '旅行', '{"pack":"custom","iconData":{"codePoint":58009,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (113, 0, 0, '育儿', '{"pack":"custom","iconData":{"codePoint":57539,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (114, 0, 0, '宠物', '{"pack":"custom","iconData":{"codePoint":58885,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (150, 0, 1, '薪资', '{"pack":"custom","iconData":{"codePoint":59043,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (151, 0, 1, '奖金', '{"pack":"custom","iconData":{"codePoint":58360,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (152, 0, 1, '兼职', '{"pack":"custom","iconData":{"codePoint":58897,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (199, 0, 1, '意外所得', '{"pack":"custom","iconData":{"codePoint":59009,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0);

INSERT INTO wallet_category (pid, type, name, icon, sort) VALUES
       (100, 0, '堂食', '{"pack":"custom","iconData":{"codePoint":58889,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (100, 0, '外卖', '{"pack":"custom","iconData":{"codePoint":58901,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (100, 0, '早餐', '{"pack":"custom","iconData":{"codePoint":58894,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (100, 0, '食材', '{"pack":"custom","iconData":{"codePoint":58896,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (100, 0, '调味料', '{"pack":"custom","iconData":{"codePoint":58884,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (101, 0, '水果', '{"pack":"custom","iconData":{"codePoint":58934,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (101, 0, '饮料', '{"pack":"custom","iconData":{"codePoint":58887,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (101, 0, '零食', '{"pack":"custom","iconData":{"codePoint":58888,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (101, 0, '甜品', '{"pack":"custom","iconData":{"codePoint":59041,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (101, 0, '烟', '{"pack":"custom","iconData":{"codePoint":58933,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (101, 0, '酒', '{"pack":"custom","iconData":{"codePoint":58970,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (101, 0, '茶水', '{"pack":"custom","iconData":{"codePoint":58895,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (102, 0, '日用', '{"pack":"custom","iconData":{"codePoint":58955,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (102, 0, '数码', '{"pack":"custom","iconData":{"codePoint":58898,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (102, 0, '鞋帽服装', '{"pack":"custom","iconData":{"codePoint":58990,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (102, 0, '饰品', '{"pack":"custom","iconData":{"codePoint":58922,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (102, 0, '美容美发', '{"pack":"custom","iconData":{"codePoint":57745,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (102, 0, '美妆品', '{"pack":"custom","iconData":{"codePoint":58936,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (102, 0, '清洁', '{"pack":"custom","iconData":{"codePoint":58928,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (102, 0, '卫生用品', '{"pack":"custom","iconData":{"codePoint":58924,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (102, 0, '计生用品', '{"pack":"custom","iconData":{"codePoint":58942,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (103, 0, '电费', '{"pack":"custom","iconData":{"codePoint":58944,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (103, 0, '水费', '{"pack":"custom","iconData":{"codePoint":59001,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (103, 0, '燃气费', '{"pack":"custom","iconData":{"codePoint":58258,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (103, 0, '物业费', '{"pack":"custom","iconData":{"codePoint":58950,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (103, 0, '房租', '{"pack":"custom","iconData":{"codePoint":58971,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (103, 0, '五金维修', '{"pack":"custom","iconData":{"codePoint":58912,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (103, 0, '电器', '{"pack":"custom","iconData":{"codePoint":58937,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (103, 0, '家具', '{"pack":"custom","iconData":{"codePoint":58938,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (104, 0, '打车', '{"pack":"custom","iconData":{"codePoint":59093,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (104, 0, '公交地铁', '{"pack":"custom","iconData":{"codePoint":57813,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (104, 0, '共享单车', '{"pack":"custom","iconData":{"codePoint":58995,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (104, 0, '火车票', '{"pack":"custom","iconData":{"codePoint":57818,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (104, 0, '机票', '{"pack":"custom","iconData":{"codePoint":57454,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),

       (105, 0, '话费', '{"pack":"custom","iconData":{"codePoint":59146,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (105, 0, '宽带费', '{"pack":"custom","iconData":{"codePoint":60153,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (106, 0, '游戏', '{"pack":"custom","iconData":{"codePoint":58913,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (106, 0, '聚餐', '{"pack":"custom","iconData":{"codePoint":58946,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (106, 0, '桌游棋牌', '{"pack":"custom","iconData":{"codePoint":58921,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (106, 0, '酒吧K歌', '{"pack":"custom","iconData":{"codePoint":58978,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (106, 0, '约会', '{"pack":"custom","iconData":{"codePoint":58939,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (106, 0, '电影演出', '{"pack":"custom","iconData":{"codePoint":58905,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (106, 0, '游乐场', '{"pack":"custom","iconData":{"codePoint":59098,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (107, 0, '红包', '{"pack":"custom","iconData":{"codePoint":58993,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (107, 0, '礼物', '{"pack":"custom","iconData":{"codePoint":57662,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (107, 0, '请客', '{"pack":"custom","iconData":{"codePoint":59123,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (108, 0, '运动用品', '{"pack":"custom","iconData":{"codePoint":58925,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (108, 0, '场地', '{"pack":"custom","iconData":{"codePoint":59608,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (108, 0, '教练', '{"pack":"custom","iconData":{"codePoint":59105,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (109, 0, '考试', '{"pack":"custom","iconData":{"codePoint":59603,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (109, 0, '书籍', '{"pack":"custom","iconData":{"codePoint":58900,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (109, 0, '课程', '{"pack":"custom","iconData":{"codePoint":58974,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (109, 0, '讲座', '{"pack":"custom","iconData":{"codePoint":58927,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (109, 0, '学费', '{"pack":"custom","iconData":{"codePoint":59198,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (109, 0, '文具', '{"pack":"custom","iconData":{"codePoint":60093,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (110, 0, '药品', '{"pack":"custom","iconData":{"codePoint":58914,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (110, 0, '就诊', '{"pack":"custom","iconData":{"codePoint":58935,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (110, 0, '保健', '{"pack":"custom","iconData":{"codePoint":58929,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (110, 0, '住院', '{"pack":"custom","iconData":{"codePoint":58988,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (110, 0, '健康保险', '{"pack":"custom","iconData":{"codePoint":59121,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (111, 0, '维修保养', '{"pack":"custom","iconData":{"codePoint":59008,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (111, 0, '停车', '{"pack":"custom","iconData":{"codePoint":58957,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (111, 0, '加油', '{"pack":"custom","iconData":{"codePoint":58926,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (111, 0, '罚款', '{"pack":"custom","iconData":{"codePoint":58907,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (111, 0, '车险', '{"pack":"custom","iconData":{"codePoint":58930,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (112, 0, '团费', '{"pack":"custom","iconData":{"codePoint":58915,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (112, 0, '景点门票', '{"pack":"custom","iconData":{"codePoint":58964,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (112, 0, '纪念品', '{"pack":"custom","iconData":{"codePoint":59029,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (112, 0, '旅行路费', '{"pack":"custom","iconData":{"codePoint":57453,"fontFamily":"MaterialIcons","fontPackage":null,"matchTextDirection":false}}', 0),
       (112, 0, '酒店', '{"pack":"custom","iconData":{"codePoint":59528,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (113, 0, '奶粉', '{"pack":"custom","iconData":{"codePoint":58945,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (113, 0, '孕妇用品', '{"pack":"custom","iconData":{"codePoint":58943,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (113, 0, '育儿嫂', '{"pack":"custom","iconData":{"codePoint":59148,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (113, 0, '洗护', '{"pack":"custom","iconData":{"codePoint":59019,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (113, 0, '儿童玩具', '{"pack":"custom","iconData":{"codePoint":58904,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (113, 0, '童装', '{"pack":"custom","iconData":{"codePoint":58932,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),

       (114, 0, '宠物食品', '{"pack":"custom","iconData":{"codePoint":58931,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (114, 0, '猫砂', '{"pack":"custom","iconData":{"codePoint":58917,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0),
       (114, 0, '宠物医疗', '{"pack":"custom","iconData":{"codePoint":60482,"fontFamily":"HandnoteIcon","fontPackage":null,"matchTextDirection":false}}', 0);
