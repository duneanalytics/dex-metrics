-- part of a query repo
-- query name: Monthly DEX volume grouped by year
-- query link: https://dune.com/queries/4424


SELECT
  date_format(block_time, '%Y') AS year,
  date_format(block_time, '%m') AS month,
  SUM(CAST(amount_usd AS DOUBLE)) AS usd_volume
FROM
  dex."trades" AS t
WHERE
  block_time >= CAST('2019-01-01' AS TIMESTAMP)
GROUP BY
  1,
  2