EXPLAIN SELECT * FROM transactions WHERE type = 'transfer';
/*
+------+-------------+--------------+------+---------------+------+---------+------+------+-------------+
| id   | select_type | table        | type | possible_keys | key  | key_len | ref  | rows | Extra       |
+------+-------------+--------------+------+---------------+------+---------+------+------+-------------+
|    1 | SIMPLE      | transactions | ALL  | NULL          | NULL | NULL    | NULL | 4    | Using where |
+------+-------------+--------------+------+---------------+------+---------+------+------+-------------+
*/
CREATE INDEX idx_tx_type ON transactions(type);
EXPLAIN SELECT * FROM transactions WHERE type = 'transfer';
-- Observacion: con solo 4 filas el indice IGUAL fue usado (type paso de ALL a ref,
-- key = idx_tx_type, rows de 4 a 2). En tablas diminutas el optimizador a veces
-- prefiere el full scan; aqui decidio que el indice valia la pena.
/*
+------+-------------+--------------+------+---------------+-------------+---------+-------+------+-----------------------+
| id   | select_type | table        | type | possible_keys | key         | key_len | ref   | rows | Extra                 |
+------+-------------+--------------+------+---------------+-------------+---------+-------+------+-----------------------+
|    1 | SIMPLE      | transactions | ref  | idx_tx_type   | idx_tx_type | 202     | const | 2    | Using index condition |
+------+-------------+--------------+------+---------------+-------------+---------+-------+------+-----------------------+
*/