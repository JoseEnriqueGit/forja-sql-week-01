-- Calcular el saldo de cada cuenta
SELECT A.id AS Id, A.player_id AS Jugador,
    SUM(CASE WHEN to_account_id = A.id THEN  amount
         WHEN from_account_id = A.id THEN -amount
    END) AS Saldo
FROM accounts A LEFT JOIN transactions T 
                    ON A.id = T.to_account_id OR A.id = T.from_account_id
GROUP BY A.id;