-- part of a query repo
-- query name: Monthly DEX Volume By Project
-- query link: https://dune.com/queries/1847


SELECT
  project,
  DATE_TRUNC('month', block_time),
  SUM(CAST(amount_usd AS DOUBLE)) AS usd_volume
FROM
  dex."trades" AS t
WHERE
 block_time > CAST('2019-01-01' AS TIMESTAMP)
GROUP BY
  1,
  2