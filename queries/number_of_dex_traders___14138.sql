-- part of a query repo
-- query name: Number of DEX traders
-- query link: https://dune.com/queries/14138


SELECT
  COUNT(*)
FROM
  (
    SELECT
      maker AS user
    FROM
      dex.trades
    UNION
    SELECT
      taker AS address
    FROM
      dex.trades
  ) AS traders