USE spotify;

INSERT INTO users (users_email, users_password_sha, users_username, users_birthdate, users_gender, users_country, users_postalcode, users_type)
VALUES
('ana@example.com', 'sha256ana', 'Ana', '1990-04-12', 'F', 'Spain', '08001', 'Premium'),
('bruno@example.com', 'sha256bruno', 'Bruno', '1985-11-23', 'M', 'Spain', '08002', 'Premium'),
('carla@example.com', 'sha256carla', 'Carla', '1992-07-08', 'F', 'France', '75001', 'Free'),
('david@example.com', 'sha256david', 'David', '1988-03-15', 'M', 'Germany', '10115', 'Premium'),
('eva@example.com', 'sha256eva', 'Eva', '1995-09-30', 'F', 'Italy', '00100', 'Free'),
('felix@example.com', 'sha256felix', 'Felix', '1993-06-21', 'M', 'Spain', '08003', 'Premium');

-- Subscriptions
INSERT INTO subscriptions (users_user_id, subscriptions_starts_on, subscriptions_finishes_on, subscriptions_payment_method)
VALUES
(1, '2025-01-01', '2025-12-31', 'Card'),
(2, '2025-02-01', '2025-08-01', 'Paypal'),
(4, '2025-03-15', '2025-09-15', 'Card'),
(6, '2025-04-01', '2025-10-01', 'Paypal');

-- By Card
INSERT INTO subscribed_by_card (users_user_id, subscriptions_subscriptions_id, subscribed_by_card_card_number, subscribed_by_card_card_expiry_month, subscribed_by_card_card_expiry_year, subscribed_by_card_card_cvv)
VALUES
(1, 1, '4111111111111111', '12', '2026', '123'),
(4, 3, '5555555555554444', '06', '2027', '456');

-- By Paypal
INSERT INTO subscribed_by_paypayl (users_user_id, subscriptions_subscriptions_id, subscribed_by_paypayl_paypal_username)
VALUES
(2, 2, 'bruno.paypal'),
(6, 4, 'felix.paypal');

INSERT INTO subscription_payment (subscriptions_subscriptions_id, subscription_payment_date, subscription_payment_total)
VALUES
(1, '2025-01-01', 9.99),
(1, '2025-02-01', 9.99),
(2, '2025-02-01', 9.99),
(3, '2025-03-15', 9.99),
(4, '2025-04-01', 9.99);

INSERT INTO artists (artists_name, artists_image)
VALUES
('Coldplay', 'img1'),
('Adele', 'img2'),
('Ed Sheeran', 'img3'),
('Rosalía', 'img4'),
('The Weeknd', 'img5'),
('Dua Lipa', 'img6');

INSERT INTO albums (artists_artists_id, albums_title, albums_released_in, albums_cover)
VALUES
(1, 'Parachutes', '2000-07-10', 'cover1'),
(2, '25', '2015-11-20', 'cover2'),
(3, 'Divide', '2017-03-03', 'cover3'),
(4, 'Motomami', '2022-03-18', 'cover4'),
(5, 'After Hours', '2020-03-20', 'cover5'),
(6, 'Future Nostalgia', '2020-03-27', 'cover6');

INSERT INTO songs (songs_title, songs_length, songs_total_reproductions, albums_albums_id)
VALUES
('Yellow', '00:04:29', 1000000, 1),
('Hello', '00:04:55', 2000000, 2),
('Shape of You', '00:03:53', 3000000, 3),
('Saoko', '00:03:15', 500000, 4),
('Blinding Lights', '00:03:20', 4000000, 5),
('Levitating', '00:03:23', 2500000, 6);

INSERT INTO playlists (users_user_id, playlists_name, playlists_created_on, playlists_total_songs, playlists_status, playlists_deleted_on)
VALUES
(1, 'Morning Vibes', '2025-10-01', 0, 'Active', NULL),
(2, 'Workout Mix', '2025-09-15', 0, 'Active', NULL),
(3, 'Chill Out', '2025-08-20', 0, 'Deleted', '2025-10-10'),
(4, 'Party Time', '2025-07-01', 0, 'Active', NULL),
(6, 'Focus Mode', '2025-06-01', 0, 'Active', NULL);


INSERT INTO playlists_has_songs (playlists_playlists_id, songs_songs_id, users_user_id, playlists_has_songs_song_position)
VALUES
(1, 1, 1, 1),
(1, 3, 1, 2),
(2, 2, 2, 1),
(2, 4, 2, 2),
(2, 5, 2, 3),
(3, 5, 3, 1),
(4, 6, 4, 1),
(4, 3, 4, 2);

INSERT INTO playlist_is_shared (playlists_playlists_id, users_user_id)
VALUES
(1, 2),
(2, 3),
(4, 6);

-- Liked songs
INSERT INTO user_likes_song (users_user_id, songs_songs_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6);

-- Liked albums favoritos
INSERT INTO user_likes_album (users_user_id, albums_albums_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6);

INSERT INTO artist_like_artist (artists_artists_id, artists_artists_id1)
VALUES
(1, 3),
(2, 5),
(4, 5),
(6, 5),
(3, 6);

INSERT INTO user_follows_artist (users_user_id, artists_artists_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(1, 5),
(2, 4),
(3, 6);

-- Premium Users with payment method
SELECT u.users_username, s.subscriptions_payment_method,
IF(s.subscriptions_payment_method = 'Card', c.subscribed_by_card_card_number, p.subscribed_by_paypayl_paypal_username) AS metodo_pago
FROM users u
JOIN subscriptions s ON u.user_id = s.users_user_id
LEFT JOIN subscribed_by_card c ON s.subscriptions_id = c.subscriptions_subscriptions_id
LEFT JOIN subscribed_by_paypayl p ON s.subscriptions_id = p.subscriptions_subscriptions_id
WHERE u.users_type = 'Premium';

-- Payment history
SELECT u.users_username, sp.subscription_payment_date, sp.subscription_payment_total
FROM subscription_payment sp
JOIN subscriptions s ON sp.subscriptions_subscriptions_id = s.subscriptions_id
JOIN users u ON s.users_user_id = u.user_id
ORDER BY u.users_username, sp.subscription_payment_date;

-- Songs added by user songs inside each playlists
SELECT pl.playlists_name, s.songs_title, u.users_username, phs.playlists_has_songs_added_on
FROM playlists_has_songs phs
JOIN playlists pl ON phs.playlists_playlists_id = pl.playlists_id
JOIN songs s ON phs.songs_songs_id = s.songs_id
JOIN users u ON phs.users_user_id = u.user_id
ORDER BY pl.playlists_name, phs.playlists_has_songs_song_position;

-- Shared playlists
SELECT pl.playlists_name AS playlist, u.users_username AS compartida_con
FROM playlist_is_shared ps
JOIN playlists pl ON ps.playlists_playlists_id = pl.playlists_id
JOIN users u ON ps.users_user_id = u.user_id
ORDER BY pl.playlists_name;

-- Artists followed by
SELECT u.users_username, a.artists_name
FROM user_follows_artist ufa
JOIN users u ON ufa.users_user_id = u.user_id
JOIN artists a ON ufa.artists_artists_id = a.artists_id
ORDER BY u.users_username;

-- favorite songs
SELECT u.users_username, s.songs_title
FROM user_likes_song uls
JOIN users u ON uls.users_user_id = u.user_id
JOIN songs s ON uls.songs_songs_id = s.songs_id
ORDER BY u.users_username;

-- Related artists
SELECT a1.artists_name AS artista, a2.artists_name AS relacionado_con
FROM artist_like_artist ala
JOIN artists a1 ON ala.artists_artists_id = a1.artists_id
JOIN artists a2 ON ala.artists_artists_id1 = a2.artists_id
ORDER BY a1.artists_name;

-- Active and deleted playlists
SELECT u.users_username,
SUM(pl.playlists_status = 'Active') AS activas,
SUM(pl.playlists_status = 'Deleted') AS eliminadas
FROM playlists pl
JOIN users u ON pl.users_user_id = u.user_id
GROUP BY u.users_username;

-- Artist and album for each song
SELECT s.songs_title, al.albums_title, ar.artists_name
FROM songs s
JOIN albums al ON s.albums_albums_id = al.albums_id
JOIN artists ar ON al.artists_artists_id = ar.artists_id
ORDER BY ar.artists_name, al.albums_title;



-- Check total songs is working SELECT before inserting songs
SELECT playlists_name AS Playlist, playlists_total_songs AS Songs, playlists_created_on AS Created
FROM playlists;

INSERT INTO playlists_has_songs (playlists_playlists_id, songs_songs_id, users_user_id, playlists_has_songs_song_position)
VALUES
(1, 1, 1, 1),
(1, 3, 1, 2);

-- Check total songs is working SELECT after inserting songs
SELECT playlists_name AS Playlist, playlists_total_songs AS Songs, playlists_created_on AS Created
FROM playlists;

