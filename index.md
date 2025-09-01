https://drive.google.com/file/d/1yYQRBk0eL0ZteBZpcMLJXKy2pV3xpUvm/view?usp=sharing
📖 Dictionnaire de données (PostgreSQL)
Table : utilisateurs
Attribut	Type	Contraintes	Description
id	SERIAL	PRIMARY KEY, NOT NULL	Identifiant unique de l’utilisateur
username	VARCHAR(50)	UNIQUE, NOT NULL	Nom d’utilisateur (pseudo affiché)
email	VARCHAR(100)	UNIQUE, NOT NULL	Adresse e-mail utilisée pour l’authentification
password	TEXT	NOT NULL	Mot de passe (hashé)
bio	TEXT	NULLABLE	Courte description du profil
avatar	TEXT	NULLABLE	URL de l’image de profil
date_inscription	TIMESTAMP	DEFAULT CURRENT_TIMESTAMP	Date et heure d’inscription
Table : tweets
Attribut	Type	Contraintes	Description
id	SERIAL	PRIMARY KEY, NOT NULL	Identifiant unique du tweet
contenu	VARCHAR(280)	NOT NULL	Contenu du tweet (limité à 280 caractères)
date_publication	TIMESTAMP	DEFAULT CURRENT_TIMESTAMP	Date et heure de publication
user_id	INT	NOT NULL, FK → utilisateurs(id)	Auteur du tweet
Table : likes
Attribut	Type	Contraintes	Description
id	SERIAL	PRIMARY KEY, NOT NULL	Identifiant unique du like
user_id	INT	NOT NULL, FK → utilisateurs(id)	Utilisateur qui a liké
tweet_id	INT	NOT NULL, FK → tweets(id)	Tweet liké
date_like	TIMESTAMP	DEFAULT CURRENT_TIMESTAMP	Date du like
(user_id, tweet_id)	UNIQUE	Empêche un utilisateur de liker plusieurs fois le même tweet	
Table : follows
Attribut	Type	Contraintes	Description
follower_id	INT	NOT NULL, FK → utilisateurs(id)	Utilisateur qui suit
following_id	INT	NOT NULL, FK → utilisateurs(id)	Utilisateur suivi
date_follow	TIMESTAMP	DEFAULT CURRENT_TIMESTAMP	Date du follow
(follower_id, following_id)	PRIMARY KEY	Empêche les doublons	Clé primaire composée
no_self_follow	CHECK	follower_id <> following_id	Empêche un utilisateur de se suivre lui-même