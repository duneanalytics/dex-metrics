-- part of a query repo
-- query name: Daily DEX volume
-- query link: https://dune.com/queries/4388

SELECT
  project,
  DATE_TRUNC('day', block_time),
  SUM(CAST(amount_usd AS DOUBLE)) AS usd_volume
FROM
  dex."trades" AS t
WHERE
 block_time > DATE_TRUNC('day', NOW()) - INTERVAL '30' day
  AND block_time < DATE_TRUNC('day', NOW())
GROUP BY
  1,
  2