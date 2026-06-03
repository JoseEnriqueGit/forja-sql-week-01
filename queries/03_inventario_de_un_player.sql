-- Este script de dice si el jugador tiene objecto o no sin darme objectos fantamas o NULL, es mas confiable en pocas palabras
SELECT P.name AS NOMBRE, I.name AS NONBRE_ITEM, PI.quantity
FROM players AS P INNER JOIN player_items AS PI ON P.id = PI.player_id  INNER JOIN items AS I ON PI.items_id = I.id
WHERE P.id = 2;