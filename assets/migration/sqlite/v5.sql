CREATE TABLE wallet_book
(
    id        TEXT PRIMARY KEY,            -- 16位 nanoid
    name      TEXT     NOT NULL,           -- 账本名称
    status    INTEGER  NOT NULL DEFAULT 1, -- 状态 (0: 禁用 1: 启用)
    createdAt DATETIME NOT NULL DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW')),
    updatedAt DATETIME NOT NULL DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW')),
    deletedAt DATETIME
);
