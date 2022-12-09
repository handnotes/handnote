CREATE TABLE wallet_category_match_rule
(
    id           TEXT PRIMARY KEY,            -- 16 位 nanoid
    type         INTEGER  NOT NULL,           -- 0: 支出 1: 收入
    pattern      TEXT     NOT NULL,           -- 正则匹配模式
    categoryName TEXT     NOT NULL,           -- 分类 (空格分隔 逆序优先级)
    minAmount    REAL,                        -- 最小匹配金额 (非负数, 空则不限制)
    maxAmount    REAL,                        -- 最大匹配金额 (非负数, 空则不限制)
    weight       INTEGER  NOT NULL DEFAULT 0, -- 权重
    createdAt    DATETIME NOT NULL DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW')),
    updatedAt    DATETIME NOT NULL DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW'))
);

-- 婚纱 婚礼 阿里云 太保财产险 办公

INSERT INTO wallet_category_match_rule (id, type, weight, minAmount, maxAmount, pattern, categoryName)
VALUES
    -- 收入
    (LOWER(HEX(RANDOMBLOB(8))), 1, 0, 800, NULL, '(工资|人力资源|薪资|薪酬)', '薪资'),
    (LOWER(HEX(RANDOMBLOB(8))), 1, 0, NULL, NULL, '(奖金|年终奖)', '奖金'),
    (LOWER(HEX(RANDOMBLOB(8))), 1, 0, NULL, NULL, '(利息|结息|余额宝.*天弘基金)', '利息收入'),
    (LOWER(HEX(RANDOMBLOB(8))), 1, 0, NULL, NULL, '(转存|转账)', '转入'),
    (LOWER(HEX(RANDOMBLOB(8))), 1, 0, NULL, NULL, '(报销)', '报销'),
    (LOWER(HEX(RANDOMBLOB(8))), 1, 0, NULL, NULL, '(退款|冲正)', '退款'),
    (LOWER(HEX(RANDOMBLOB(8))), 1, 0, NULL, NULL, '(偿还.房贷)', '投资回收'),
    (LOWER(HEX(RANDOMBLOB(8))), 1, 0, NULL, 100, '(红包)', '其他收入,意外所得'),
    (LOWER(HEX(RANDOMBLOB(8))), 1, 0, NULL, 10, '^wechat:', '其他收入,意外所得'),

    -- 支出
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(饿了么|外卖)', '餐饮,外卖'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(早餐|包子|早饭|包点|馅包)', '餐饮,早餐'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(饭|米粉|米线|螺.粉|汉堡|黄焖鸡|冒菜)', '餐饮,日常餐'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(面庄|面馆|板凳面|牛肉面|拉面|燃面)', '餐饮,日常餐'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(乡村基|大米先生|肯德基|麦当劳|华莱士|多几谷)', '餐饮,日常餐'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(方便面|流口水|柳江人家|好欢螺|食品专.店)', '餐饮,方便食品'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(餐饮|卤|煮|火锅|串串|虾|蟹|烧烤|牛肉|羊肉|鸡爪|啤酒鸭)', '餐饮'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(水果)', '零食烟酒,水果'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(奶茶|咖啡|蜜雪|星巴克)', '零食烟酒,饮料'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(零食|面筋|副食)', '零食烟酒,零食'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(酒|茅台|五粮液)', '零食烟酒,酒'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, 300, '(快递|菜鸟|顺丰|速递|EMS)', '日常,快递'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(美发|美业|发型)', '日常,美容美发'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(美容|医美)', '日常,美容美发'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(美甲|迪奥)', '日常,美妆品'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(纸巾|抽纸|卷纸|卫生纸|保洁)', '日常,清洁'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(卫生巾|卫生棉|夜安裤)', '日常,卫生用品'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(成人用品|杜蕾斯|杰士邦|避孕)', '日常,计生用品'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, -1, NULL, NULL, '(商超|超市|商店|商行|麦德龙|盒马|永辉|红旗连锁|便利店|WOWO)', '日常'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(数码|电子|3C|手机|电脑|平板|相机|电池|电线|充电宝)', '购物,数码'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(绿联|南孚|公牛|小米)', '购物,数码'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(鞋|帽子|鞋帽|服装|衣服|裙子)', '购物,鞋帽服装'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, -1, NULL, NULL, '(旗舰店|专卖店)', '购物'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(电商|淘宝|天猫|拼多多|京东|当当)', '购物'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(购物|伊藤|万达|苏宁)', '购物'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(五金|箭牌|卫浴)', '住房,五金维修'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(电器|美的|格力|海尔|智能家)', '住房,电器'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(家具|家居)', '住房,家具'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(天然气|燃气|气费)', '住房,燃气费'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(电费|供电|电网|国网)', '住房,电费'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(水费|水厂)', '住房,水费'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(物业)', '住房,物业费'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(课程)', '文教,课程'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(图书)', '文教,书籍'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(文具)', '文教,文具'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(教育)', '文教'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(单车|摩拜|青桔|哈啰)', '交通,共享单车'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(打车|滴滴)', '交通,打车'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(机票|航服|航空)', '交通,机票'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(公交|地铁|轻轨|天府通|成都金控数据服务)', '交通,公交地铁'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(汽车)', '汽车'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(自行车|山地车|公路车|喜德胜|捷安特)', '运动健身,运动用品'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(酒店|汉庭|七天|Airbnb)', '旅行,住宿'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(话费|联通|电信|移动)', '通讯,话费'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(游戏|电玩|Smart2Pay B.V.|Steam|Valve)', '娱乐聚会,游戏'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(药品|药业|药店|药房)', '医疗,药品'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(门诊|医院)', '医疗,就诊'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(医疗)', '医疗健康'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(知乎|知识星球)', '软件应用,知识教育'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(转出)', '转出'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, 100, '^wechat:.*群红包', '人情交友,红包'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, NULL, '(还款|贷款|公积金)', '还贷'),
    (LOWER(HEX(RANDOMBLOB(8))), 0, 0, NULL, 10, '(批扣.*平台批量)', '日常,卡管理费')
;
