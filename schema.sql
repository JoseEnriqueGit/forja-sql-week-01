CREATE OR REPLACE TABLE players (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(25) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)ENGINE=InnoDB;

CREATE OR REPLACE TABLE  accounts (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    player_id BIGINT NOT NULL,
    type VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `fk_accounts_players`
    FOREIGN KEY (player_id) REFERENCES players (id)
)ENGINE=InnoDB;

CREATE OR REPLACE TABLE transactions (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    from_account_id BIGINT NOT NULL,
    to_account_id BIGINT NOT NULL,
    type VARCHAR(50) NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `fk_transaction_from_account_id`
    FOREIGN KEY (from_account_id) REFERENCES accounts (id),
    CONSTRAINT `fk_transaction_to_account_id`
    FOREIGN KEY (to_account_id) REFERENCES accounts (id)
)ENGINE=InnoDB;

CREATE OR REPLACE TABLE items (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(25) NOT NULL,
    description VARCHAR(255),
    base_value DECIMAL(10,2), 
    category VARCHAR (50) NOT NULL
)ENGINE=InnoDB;

CREATE OR REPLACE TABLE player_items (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    player_id BIGINT NOT NULL,
    items_id BIGINT NOT NULL,
    quantity INT NOT NULL,
    CONSTRAINT `fk_player_items_player`
    FOREIGN KEY (player_id) REFERENCES players (id),
    CONSTRAINT `fk_player_items_item`
    FOREIGN KEY (items_id) REFERENCES items (id)
)ENGINE=InnoDB;
