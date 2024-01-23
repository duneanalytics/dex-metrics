-- part of a query repo
-- query name: 30 days DEX volume
-- query link: https://dune.com/queries/8243


SELECT
  SUM(CAST(amount_usd AS DOUBLE) / 1e9) AS usd_volume_in_billion
FROM
  dex."trades" AS t
WHERE
    block_time > NOW() - INTERVAL '30' day