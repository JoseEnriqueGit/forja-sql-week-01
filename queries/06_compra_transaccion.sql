/*
Sin transaccion, si el servidor se cae entre el INSERT de transactions y el de player_items:
Primero le quitara los 20 dolares pero el item no se registrara en el invetario de jugador.
Si estuvieran al revés, recibiría el item gratis
Le cuesta al dueño del server
*/

SELECT A.id AS Id, A.player_id AS Jugador,
    SUM(CASE WHEN to_account_id = A.id THEN  amount
             WHEN from_account_id = A.id THEN -amount
    END) AS Saldo
FROM accounts A LEFT JOIN transactions T
    ON A.id = T.to_account_id OR A.id = T.from_account_id
GROUP BY A.id;

-- Predicion: 1       1       -250.00
-- Predicion: 2       2       125.00
-- Predicion: 3       3       125.00

START TRANSACTION;

INSERT INTO transactions (from_account_id, to_account_id, type, amount) VALUES ( 2, 1, 'despawn', 20);
INSERT INTO player_items (player_id, items_id, quantity) VALUES (2, 3, 1);

COMMIT;

SELECT A.id AS Id, A.player_id AS Jugador,
    SUM(CASE WHEN to_account_id = A.id THEN  amount
             WHEN from_account_id = A.id THEN -amount
    END) AS Saldo
FROM accounts A LEFT JOIN transactions T
    ON A.id = T.to_account_id OR A.id = T.from_account_id
GROUP BY A.id;

-- Predicion: 1       1       -230.00
-- Predicion: 2       2       105.00
-- Predicion: 3       3       125.00

START TRANSACTION;

INSERT INTO transactions (from_account_id, to_account_id, type, amount) VALUES ( 2, 1, 'despawn', 20);
INSERT INTO player_items (player_id, items_id, quantity) VALUES (2, 3, 1);

SELECT A.id AS Id, A.player_id AS Jugador,
    SUM(CASE WHEN to_account_id = A.id THEN  amount
             WHEN from_account_id = A.id THEN -amount
    END) AS Saldo
FROM accounts A LEFT JOIN transactions T
    ON A.id = T.to_account_id OR A.id = T.from_account_id
GROUP BY A.id;

-- Predicion: 1       1       -210.00
-- Predicion: 2       2       85.00
-- Predicion: 3       3       125.00

SELECT P.name AS NOMBRE, I.name AS NONBRE_ITEM, PI.quantity
FROM players AS P INNER JOIN player_items AS PI ON P.id = PI.player_id  INNER JOIN items AS I ON PI.items_id = I.id
WHERE P.id = 2;

-- Predicion: Jose    agua    1
-- Predicion: Jose    camisa  1
-- Predicion: Jose    camisa  1

ROLLBACK;

SELECT A.id AS Id, A.player_id AS Jugador,
    SUM(CASE WHEN to_account_id = A.id THEN  amount
             WHEN from_account_id = A.id THEN -amount
    END) AS Saldo
FROM accounts A LEFT JOIN transactions T
    ON A.id = T.to_account_id OR A.id = T.from_account_id
GROUP BY A.id;

SELECT P.name AS NOMBRE, I.name AS NONBRE_ITEM, PI.quantity
FROM players AS P INNER JOIN player_items AS PI ON P.id = PI.player_id  INNER JOIN items AS I ON PI.items_id = I.id
WHERE P.id = 2;

-- Predicion: Jose    agua    1
-- Predicion: Jose    camisa  1