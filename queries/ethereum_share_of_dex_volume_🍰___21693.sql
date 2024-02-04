-- part of a query repo
-- query name: Ethereum share of DEX volume 🍰
-- query link: https://dune.com/queries/21693

WITH
  eth AS (
    SELECT
      SUM(CAST(amount_usd AS DOUBLE)) / 1e9 AS eth_bill_vol
    FROM
      dex."trades" AS t
    WHERE
      t.blockchain = 'ethereum'
      AND block_time > NOW() - INTERVAL '7' day
  ),
  all AS (
    SELECT
      SUM(CAST(amount_usd AS DOUBLE)) / 1e9 AS all_bill_vol
    FROM
      dex."trades" AS t
    WHERE
      block_time > NOW() - INTERVAL '7' day
  )
SELECT
  eth_bill_vol / all_bill_vol * 100 AS agg_share
FROM
  eth,
  all