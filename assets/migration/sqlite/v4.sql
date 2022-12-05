CREATE TABLE wallet_bill
(
    id                 TEXT PRIMARY KEY,  -- 16位 nanoid
    category           INTEGER,           -- 分类
    subCategory        INTEGER,           -- 子分类
    outAssets          INTEGER,           -- 支出资产账户
    outAmount          REAL,              -- 支出金额
    outType            TEXT,              -- 支出币种
    outImportedSummary TEXT,              -- 支出导入摘要
    inAssets           INTEGER,           -- 收入资产账户
    inAmount           REAL,              -- 收入金额
    inType             TEXT,              -- 收入币种
    inImportedSummary  TEXT,              -- 收入导入摘要
    time               DATETIME NOT NULL, -- 交易时间
    description        TEXT,              -- 描述
    counterParty       TEXT,              -- 交易对方
    importedId         TEXT,              -- 导入账单批次唯一标识符, 用于识别重复导入
    createdAt          DATETIME NOT NULL DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW')),
    updatedAt          DATETIME NOT NULL DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW')),
    deletedAt          DATETIME
);
