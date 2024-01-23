-- part of a query repo
-- query name: DEX 24 hours volume
-- query link: https://dune.com/queries/4234


/* Migration success :)

There are some cases such as unnest/sequence and array/json functions the migrator won't take care of for you 
(but we have examples of in the docs linked above!)

If you're still running into issues, check out the doc examples https://dune.com/docs/reference/dune-v2/query-engine/
or reach out to us in the Dune discord in the #dune-sql channel. 
 */
SELECT
  SUM(CAST(amount_usd AS DOUBLE)) / 1e9 AS billion_volume
FROM
  dex."trades" AS t
WHERE
  block_time > NOW() - INTERVAL '24' hour