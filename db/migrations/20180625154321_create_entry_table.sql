-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE TABLE entries(
  id BIGSERIAL PRIMARY KEY,
  category VARCHAR NOT NULL,
  memo TEXT NOT NULL,
  entry_date VARCHAR NOT NULL,
  created_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ
);


-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE entries;
