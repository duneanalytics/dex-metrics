-- part of a query repo
-- query name: DEX 7 days volume
-- query link: https://dune.com/queries/4235

SELECT
    SUM(amount_usd)/1e9 AS billion_volume
FROM dex.trades t
WHERE block_time > now() - interval '7' day
