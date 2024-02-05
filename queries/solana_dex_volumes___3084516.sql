-- part of a query repo
-- query name: Solana DEX Volumes
-- query link: https://dune.com/queries/3084516


--colors phoe F37A44 whirl FFCE5B ray AB0DEB lif 5D5AE5 meteora 609A00 goosefx 726FFF
SELECT 
    date_trunc('week', block_time) as time
    , project
    , sum(amount_usd) as amount_usd
    , sum(COALESCE(amount_usd, tr.token_bought_amount*p.median_price)) as amount_usd_other
FROM dex_solana.trades tr
LEFT JOIN dune.dune.result_dex_prices_solana p ON p.token_mint_address = tr.token_bought_mint_address 
    AND date_trunc('day',tr.block_time) = p.day
    AND rolling_two_months_trades > 100
WHERE block_time > timestamp '{{start date}}'
group by 1, 2