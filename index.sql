CREATE DATABASE clone_x;

\c clone_x;

CREATE TABLE utilisateurs (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password TEXT NOT NULL,
    bio TEXT,
    avatar TEXT,
    date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tweets (
    id SERIAL PRIMARY KEY,
    contenu VARCHAR(280) NOT NULL,
    date_publication TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INT NOT NULL,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES utilisateurs(id) ON DELETE CASCADE
);

CREATE TABLE likes (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    tweet_id INT NOT NULL,
    date_like TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_user_like FOREIGN KEY (user_id) REFERENCES utilisateurs(id) ON DELETE CASCADE,
    CONSTRAINT fk_tweet_like FOREIGN KEY (tweet_id) REFERENCES tweets(id) ON DELETE CASCADE,
    CONSTRAINT unique_like UNIQUE(user_id, tweet_id)
);

CREATE TABLE follows (
    follower_id INT NOT NULL,
    following_id INT NOT NULL,
    date_follow TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (follower_id, following_id),
    CONSTRAINT fk_follower FOREIGN KEY (follower_id) REFERENCES utilisateurs(id) ON DELETE CASCADE,
    CONSTRAINT fk_following FOREIGN KEY (following_id) REFERENCES utilisateurs(id) ON DELETE CASCADE,
    CONSTRAINT no_self_follow CHECK (follower_id <> following_id)
);

INSERT INTO utilisateurs (username, email, password, bio) VALUES
('alice', 'alice@mail.com', 'hashpass1', 'Fan de dev'),
('bob', 'bob@mail.com', 'hashpass2', 'Trader crypto'),
('charlie', 'charlie@mail.com', 'hashpass3', 'Gamer');

INSERT INTO tweets (contenu, user_id) VALUES
('Hello Twitter !', 1),
('Je code en PostgreSQL 🚀', 2),
('Qui veut jouer ce soir ?', 3);

INSERT INTO likes (user_id, tweet_id) VALUES
(2, 1),
(3, 1),
(1, 2);

INSERT INTO follows (follower_id, following_id) VALUES
(1, 2),
(2, 1),
(3, 1);
