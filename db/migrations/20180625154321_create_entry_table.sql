-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE TABLE entries(
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  category VARCHAR NOT NULL,
  memo TEXT NOT NULL,
  entry_date DATETIME NOT NULL
);


-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE entries;
