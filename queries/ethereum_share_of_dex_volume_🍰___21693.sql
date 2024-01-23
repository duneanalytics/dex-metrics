-- part of a query repo
-- query name: Ethereum share of DEX volume 🍰
-- query link: https://dune.com/queries/21693


/* Migration success :)

There are some cases such as unnest/sequence and array/json functions the migrator won't take care of for you 
(but we have examples of in the docs linked below!)

If you're still running into issues, check out the doc examples https://dune.com/docs/reference/dune-v2/query-engine/
or reach out to us in the Dune discord in the #dune-sql channel. 
 */
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