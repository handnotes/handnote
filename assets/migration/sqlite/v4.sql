CREATE TABLE wallet_bill
(
    id           TEXT PRIMARY KEY, -- 16位 nanoid
    category     INTEGER,          -- 分类
    sub_category INTEGER,          -- 子分类
    out_assets   INTEGER,          -- 支出资产账户
    out_amount   REAL,             -- 支出金额
    in_assets    INTEGER,          -- 收入资产账户
    in_amount    REAL,             -- 收入金额
    time         INTEGER NOT NULL,
    description  TEXT,
    created_at   INTEGER NOT NULL,
    updated_at   INTEGER NOT NULL,
    deleted_at   INTEGER
);
