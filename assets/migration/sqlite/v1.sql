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
