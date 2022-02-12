CREATE TABLE common
(
    key   TEXT PRIMARY KEY UNIQUE NOT NULL,
    value TEXT
);
INSERT INTO common (key, value)
VALUES ('last_update_at', NULL);

CREATE TABLE wallet_bill
(
    id          TEXT    NOT NULL PRIMARY KEY,
    category    INTEGER NOT NULL, -- 分类
    subCategory INTEGER,          -- 子分类
    outAssets   INTEGER,          -- 支出资产账户
    outAmount   REAL,             -- 支出金额
    inAssets    INTEGER,          -- 收入资产账户
    inAmount    REAL,             -- 收入金额
    time        INTEGER NOT NULL,
    description TEXT,
    imported_id TEXT,             -- 导入数据的唯一标识符 (非导入数据留空)
    created_at  INTEGER NOT NULL,
    updated_at  INTEGER NOT NULL,
    deleted_at  INTEGER
);

CREATE TABLE wallet_category
(
    id         INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    pid        INTEGER,                    -- 父分类
    type       INTEGER NOT NULL,           -- 类型 (0: 支出 1: 收入)
    name       TEXT    NOT NULL,           -- 分类名称
    sort       INTEGER,                    -- 排序
    status     INTEGER NOT NULL DEFAULT 1, -- 状态 (0: 禁用 1: 启用)
    created_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL,
    deleted_at INTEGER
);
CREATE UNIQUE INDEX wallet_category_id_uindex ON wallet_category (id);

CREATE TABLE wallet_asset
(
    id             INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    category       INTEGER NOT NULL,           -- 分类 (1: 资金 2: 应收 3: 应付)
    type           INTEGER NOT NULL,           -- 资产类型 (100: 其他账户 101: 信用卡 102: 借记卡 103: 支付宝 104. 微信钱包 105. 现金 106. 公交卡 107. 饭卡 108. 购物卡 109. Steam 200: 其他应收 201: 借出 202: 报销 300: 其他应付 301: 借入 302: 贷款)
    name           TEXT    NOT NULL,           -- 资产名称 (category 1: 资产名称 2: 借出人 3: 借入人)
    remark         TEXT,                       -- 银行卡尾号
    status         INTEGER NOT NULL DEFAULT 1, -- 状态 (0: 禁用 1: 启用 2: 不在首页展示)
    allow_bill     INTEGER NOT NULL DEFAULT 1, -- 是否允许记账
    init_amount    REAL,                       -- 初始金额
    bank           INTEGER,                    -- 银行 (1: 工商银行 2:建设银行 3: 农业银行 4. 招商银行 5. 中国银行 6. 交通银行 7. 中信银行 8. 浦发银行 9. 兴业银行 10. 广发银行 11. 华夏银行 12. 民生银行 13. 其他银行)
    repayment_date INTEGER,                    -- 到期日/还款日
    billing_date   INTEGER,                    -- (信用卡/花呗)账单日
    created_at     INTEGER NOT NULL,
    updated_at     INTEGER NOT NULL,
    deleted_at     INTEGER
);
