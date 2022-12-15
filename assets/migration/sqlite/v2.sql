CREATE TABLE wallet_asset
(
    id             INTEGER PRIMARY KEY AUTOINCREMENT,
    category       INTEGER  NOT NULL,           -- 分类 (0: 资金 1: 应收 2: 应付)
    type           TEXT     NOT NULL,           -- 资产类型
    name           TEXT     NOT NULL,           -- 资产名称 (category 0: 资产名称 1: 借出人 2: 借入人)
    remark         TEXT,                        -- 资产备注
    status         INTEGER  NOT NULL DEFAULT 1, -- 状态 (0: 禁用 1: 启用)
    showInHomePage INTEGER  NOT NULL DEFAULT 1, -- 是否在首页显示 (0: 不显示 1: 显示)
    allowBill      INTEGER  NOT NULL DEFAULT 1, -- 是否允许记账
    notCounted     INTEGER  NOT NULL DEFAULT 1, -- 是否不计入账单
    balance        REAL              DEFAULT 0, -- 余额
    bank           TEXT,                        -- 银行
    cardNumber     TEXT,                        -- 银行卡尾号
    repaymentDate  DATETIME,                    -- 到期日/还款日
    billingDate    DATETIME,                    -- (信用卡/花呗)账单日
    createdAt      DATETIME NOT NULL DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW')),
    updatedAt      DATETIME NOT NULL DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW')),
    deletedAt      DATETIME
);


INSERT INTO 'wallet_asset' (category, type, name, remark, status, showInHomePage, allowBill, notCounted, bank, cardNumber)
VALUES
-- presets
(0, 'cash', '现金钱包', '', 1, 1, 1, 0, NULL, NULL),
(0, 'alipay', '支付宝', '', 1, 1, 1, 0, NULL, NULL),
(0, 'wechat', '微信钱包', '', 1, 1, 1, 0, NULL, NULL),
(0, 'jd', '京东钱包', '', 1, 1, 1, 0, NULL, NULL),
(0, 'creditCard', '招商银行', '', 1, 1, 1, 0, 'zhaoshang', '3759'),
(0, 'debitCard', '招商银行', '工资卡', 1, 1, 1, 0, 'zhaoshang', '3415'),
(0, 'debitCard', '农业银行', '房贷卡', 1, 1, 1, 0, 'nongye', '6975'),
(0, 'debitCard', '建设银行', '社保卡', 1, 1, 1, 0, 'jianshe', '6247'),
-- (0, 'neteasePay', '网易支付', '', 1, 1, 1, 0, NULL, NULL),
-- (0, 'tenpay', '财付通', '', 1, 1, 1, 0, NULL, NULL),
(0, 'schoolCard', '校园卡', '清华大学', 1, 1, 1, 0, NULL, NULL),
(0, 'foodCard', '饭卡', '', 1, 1, 1, 0, NULL, NULL),
(0, 'foodCard', '饭卡', '黄焖鸡米饭', 1, 1, 1, 0, NULL, NULL),
(0, 'shoppingCard', '购物卡', '盒马鲜生', 1, 1, 1, 0, NULL, NULL),
(0, 'shoppingCard', '购物卡', '麦德龙', 1, 1, 1, 0, NULL, NULL),
(0, 'busCard', '公交卡', '天府通', 1, 1, 1, 0, NULL, NULL),
(0, 'haircutCard', '剪发卡', 'TAT', 1, 1, 1, 0, NULL, NULL),
-- (0, 'digitalAssets', '数字人民币', '', 1, 1, 1, 0, NULL, NULL),
-- (0, 'digitalAssets', 'Steam', '', 1, 1, 1, 0, NULL, NULL),
(0, 'otherAsset', '其他资产', '', 1, 1, 1, 0, NULL, NULL),
(1, 'reimburse', '公司', '', 1, 1, 1, 0, NULL, NULL),
(2, 'borrowIn', '蚂蚁花呗', '花呗', 1, 1, 1, 0, NULL, NULL),
(2, 'borrowIn', '成都市公积金', '住房公积金贷款', 1, 0, 1, 1, NULL, NULL),
(2, 'borrowIn', '农业银行', '住房贷款', 1, 0, 1, 1, NULL, NULL);
