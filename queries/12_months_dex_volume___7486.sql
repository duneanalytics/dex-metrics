-- part of a query repo
-- query name: 12 Months DEX volume
-- query link: https://dune.com/queries/7486


SELECT
  SUM(CAST(amount_usd AS DOUBLE)) / 1000000000 /* Convert to billion :D */ AS usd_volume_in_billion
FROM
  dex."trades" AS t
WHERE
  block_time >= NOW() - INTERVAL '12' month