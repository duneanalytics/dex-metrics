-- part of a query repo
-- query name: DEX 24 hours volume
-- query link: https://dune.com/queries/4234

SELECT
  SUM(CAST(amount_usd AS DOUBLE)) / 1e9 AS billion_volume
FROM
  dex."trades" AS t
WHERE
  block_time > NOW() - INTERVAL '24' hour