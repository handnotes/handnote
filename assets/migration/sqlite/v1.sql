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
    id                INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    category          INTEGER NOT NULL,           -- 分类 (0: 资金 1: 应收 2: 应付)
    type              TEXT    NOT NULL,           -- 资产类型
    name              TEXT    NOT NULL,           -- 资产名称 (category 0: 资产名称 1: 借出人 2: 借入人)
    remark            TEXT,                       -- 银行卡尾号
    status            INTEGER NOT NULL DEFAULT 1, -- 状态 (0: 禁用 1: 启用)
    show_in_home_page INTEGER NOT NULL DEFAULT 1, -- 是否在首页显示 (0: 不显示 1: 显示)
    allow_bill        INTEGER NOT NULL DEFAULT 1, -- 是否允许记账
    not_counted       INTEGER NOT NULL DEFAULT 1, -- 是否不计入账单
    init_amount       REAL,                       -- 初始金额
    balance           REAL,                       -- 余额
    bank              TEXT,                       -- 银行
    card_number       TEXT,                       -- 卡号
    repayment_date    INTEGER,                    -- 到期日/还款日
    billing_date      INTEGER,                    -- (信用卡/花呗)账单日
    created_at        INTEGER NOT NULL,
    updated_at        INTEGER NOT NULL,
    deleted_at        INTEGER
);
