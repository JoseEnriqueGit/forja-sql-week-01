START TRANSACTION;

INSERT INTO transactions (from_account_id, to_account_id, type, amount) VALUES ( 2, 1, 'despawn', 15);

COMMIT;

SELECT * FROM transactions WHERE id = 5;