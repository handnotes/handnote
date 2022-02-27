CREATE TABLE wallet_bill
(
    id            TEXT PRIMARY KEY,  -- 16位 nanoid
    category      INTEGER,           -- 分类
    sub_category  INTEGER,           -- 子分类
    out_assets    INTEGER,           -- 支出资产账户
    out_amount    REAL,              -- 支出金额
    out_type      TEXT,              -- 支出币种
    in_assets     INTEGER,           -- 收入资产账户
    in_amount     REAL,              -- 收入金额
    in_type       TEXT,              -- 收入币种
    time          DATETIME NOT NULL, -- 交易时间
    description   TEXT,              -- 描述
    counter_party TEXT,              -- 交易对方
    imported_id   TEXT,              -- 导入账单批次唯一标识符, 用于识别重复导入
    created_at    DATETIME NOT NULL DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW')),
    updated_at    DATETIME NOT NULL DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW')),
    deleted_at    DATETIME
);
