-- Aqui cree un usuario admin porque me di cuenta que no puedo crear un accounts con el valor de player_id nulo
INSERT INTO players (id, name, created_at) VALUES ( 1, 'admin', '2026-05-22 10:56:00');
INSERT INTO players (id, name, created_at) VALUES ( 2, 'Jose', '2026-05-22 10:56:00');
INSERT INTO players (id, name, created_at) VALUES ( 3, 'Juan', '2026-05-22 10:56:00');

/*
  - 'player'
  - 'system'
*/

INSERT INTO accounts (id, player_id, type, created_at) VALUES ( 1, 1, 'system', '2026-05-22 10:56:00');
INSERT INTO accounts (id, player_id, type, created_at) VALUES ( 2, 2, 'player', '2026-05-22 10:56:00');
INSERT INTO accounts (id, player_id, type, created_at) VALUES ( 3, 3, 'player', '2026-05-22 10:56:00');

INSERT INTO items (id, name, description, base_value, category) VALUES ( 1, 'agua', 'Bebida hidratante', 10, 'Bebida');
INSERT INTO items (id, name, description, base_value, category) VALUES ( 2, 'pan', 'Comida en base la harina', 15, 'Comida');
INSERT INTO items (id, name, description, base_value, category) VALUES ( 3, 'camisa', 'Ropa de vestir', 20, 'Ropa');

/*
  - 'spawn' — sistema → jugador (dinero que entra al mundo)
  - 'transfer' — jugador → jugador
  - 'despawn' — jugador → sistema (dinero que sale del mundo)
*/

INSERT INTO transactions (id, from_account_id, to_account_id, type, amount, created_at) VALUES ( 1, 1, 2, 'spawn', 100, '2026-05-22 10:56:00');
INSERT INTO transactions (id, from_account_id, to_account_id, type, amount, created_at) VALUES ( 2, 1, 3, 'spawn', 100, '2026-05-22 10:56:00');
INSERT INTO transactions (id, from_account_id, to_account_id, type, amount, created_at) VALUES ( 3, 2, 3, 'transfer', 25, '2026-05-22 10:56:00');
INSERT INTO transactions (id, from_account_id, to_account_id, type, amount, created_at) VALUES (4, 1, 2, 'transfer', 50, '2026-06-02 10:14:00');

INSERT INTO player_items (id, player_id, items_id, quantity) VALUES ( 1, 2, 1, 1);
INSERT INTO player_items (id, player_id, items_id, quantity) VALUES ( 2, 3, 1, 1);