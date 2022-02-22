CREATE TABLE common
(
    key   TEXT PRIMARY KEY UNIQUE NOT NULL,
    value TEXT
);
INSERT INTO common (key, value)
VALUES ('last_update_at', NULL);
