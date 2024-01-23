-- part of a query repo
-- query name: DEX 7 days volume
-- query link: https://dune.com/queries/4235


-- This query has been migrated to run on DuneSQL.
-- If you need to change back because you’re seeing issues, use the Query History view to restore the previous version.
-- If you notice a regression, please email dunesql-feedback@dune.com.

SELECT
    SUM(amount_usd)/1e9 AS billion_volume
FROM dex.trades t
WHERE block_time > now() - interval '7' day
