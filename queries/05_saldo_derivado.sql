-- escrita de memoria en N min, verificada: suma = 0
SELECT P.id, P.name, A.id,
    SUM(CASE WHEN to_account_id = A.player_id THEN amount
    WHEN from_account_id = A.player_id THEN -amount END) AS Total
        FROM players P
            INNER JOIN accounts A ON P.id = A.player_id
            INNER JOIN transactions T ON P.id = T.from_account_id OR P.id = T.to_account_id
    GROUP BY A.id;
