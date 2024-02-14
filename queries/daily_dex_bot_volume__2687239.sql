WITH
    botActivityByDay AS (
        SELECT
            DATE_TRUNC ('day', block_time) AS block_date, -- DATE_TRUNC ('{{Granularity}}', block_time) AS block_date,
            bot,
            SUM(amount_usd) AS volumeUSD,
            SUM(fee_usd) AS botRevenueUSD,
            COUNT(DISTINCT (user)) AS numberOfUsers,
            COUNT(DISTINCT (tx_hash)) AS numberOfTrades
        FROM
            dune.unibot.result_dex_trading_bot_trades
        WHERE
            isLastTradeInTransaction = true
            -- AND blockchain IN (
            --     SELECT
            --         blockchain
            --     FROM
            --         UNNEST (SPLIT ('{{Blockchain}}', ',')) as b (blockchain)
            -- )
        GROUP BY
            bot,
            DATE_TRUNC ('day', block_time) -- DATE_TRUNC ('{{Granularity}}', block_time)
    ),
    defCafeActivityByDay AS (
        SELECT
            DATE_TRUNC ('day', block_date) AS block_date, -- DATE_TRUNC ('{{Granularity}}', block_date) AS block_date,
            '0xDefCafe' AS bot,
            SUM(totalVolumeUSD) AS volumeUSD,
            SUM(totalFeesUSD) AS botRevenueUSD,
            MIN(numberOfUsers) AS numberOfUsers,
            SUM(numberOfTrades) AS numberOfTrades
        FROM
            query_3040168 -- 0xDefCafe only has aggregated data
            -- WHERE
            --     blockchain IN (
            --         SELECT
            --             blockchain
            --         FROM
            --             UNNEST (SPLIT ('{{Blockchain}}', ',')) as b (blockchain)
            --     )
        GROUP BY
            DATE_TRUNC ('day', block_time) -- DATE_TRUNC ('{{Granularity}}', block_time)
    ),
    botActivityByDayWithCumulativeValues AS (
        SELECT
            *,
            SUM(volumeUSD) OVER (
                PARTITION BY
                    bot
                ORDER BY
                    block_date
            ) AS cumulative_volumeUSD,
            SUM(numberOfTrades) OVER (
                PARTITION BY
                    bot
                ORDER BY
                    block_date
            ) AS cumulative_numberOfTrades
        FROM
            (
                SELECT
                    *
                FROM
                    botActivityByDay
                UNION ALL
                SELECT
                    *
                FROM
                    defCafeActivityByDay
            )
    )
SELECT
    *
FROM
    botActivityByDayWithCumulativeValues
WHERE
    block_date >= NOW () - INTERVAL '180' day --'{{Timeframe in Days}}' day
ORDER BY
    block_date DESC,
    bot ASC