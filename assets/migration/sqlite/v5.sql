CREATE TABLE wallet_book
(
    id            TEXT     PRIMARY KEY,        -- 16位 nanoid
    name          TEXT     NOT NULL,
    status        INTEGER  NOT NULL DEFAULT 1, -- 状态 (0: 禁用 1: 启用)
    created_at    DATETIME NOT NULL DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW')),
    updated_at    DATETIME NOT NULL DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW')),
    deleted_at    DATETIME
);

INSERT INTO wallet_book (id, name, status, created_at, updated_at, deleted_at)
