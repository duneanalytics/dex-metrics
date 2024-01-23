-- part of a query repo
-- query name: Daily DEX volume
-- query link: https://dune.com/queries/4388


/* Migration success :)

There are some cases such as unnest/sequence and array/json functions the migrator won't take care of for you 
(but we have examples of in the docs linked above!)

If you're still running into issues, check out the doc examples https://dune.com/docs/reference/dune-v2/query-engine/
or reach out to us in the Dune discord in the #dune-sql channel. 
 */
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