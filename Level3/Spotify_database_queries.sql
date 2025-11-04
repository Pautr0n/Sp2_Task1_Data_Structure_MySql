-- PRemium users by country
SELECT country, COUNT(*) AS premium_users
FROM users
WHERE type = 'Premium'
GROUP BY country;

-- Top 5 reproduced songs
SELECT title, total_reproductions
FROM songs
ORDER BY total_reproductions DESC
LIMIT 5;

-- Shared playlists
SELECT spl.playlist_id, pl.name, COUNT(spl.user_id) AS shared_with
FROM playlist_is_shared spl
join playlists pl on pl.id = spl.playlist_id
GROUP BY playlist_id
HAVING COUNT(spl.user_id) > 1;

-- Rosalia's followers
SELECT u.username
FROM users u
JOIN user_follows_artist ufa ON u.id = ufa.user_id
JOIN artists a ON ufa.artist_id = a.id
WHERE a.name = 'Rosalía';

-- Total reproductions by album
SELECT a.title AS album_title, SUM(s.total_reproductions) AS total_album_reproductions
FROM albums a
JOIN songs s ON a.id = s.album_id
GROUP BY a.title
ORDER BY total_album_reproductions DESC;

-- Artists like artist
SELECT a1.name AS artist_1, a2.name AS follows
FROM artists a1 JOIN artist_like_artist ala ON a1.id = ala.artists_id
JOIN artists a2 ON ala.artist_id1 = a2.id;

-- User Payments by card
SELECT u.username, s.payment_method
FROM users u
JOIN subscriptions s ON u.id = s.user_id
JOIN ssubscribed_by_card sbc ON s.id = sbc.subscription_id;

-- Songs inside playlist Party mix
SELECT s.title
FROM songs s
JOIN playlists_has_songs phs ON s.id = phs.song_id
JOIN playlists p ON phs.playlist_id = p.id
WHERE p.name = 'Party Mix';

-- Users that like bad bunny songs
SELECT DISTINCT u.username, s.title
FROM users u
JOIN user_likes_song uls ON u.id = uls.user_id
JOIN songs s ON uls.song_id = s.id
JOIN albums a ON s.album_id = a.id
JOIN artists ar ON a.artist_id = ar.id
WHERE ar.name = 'Bad Bunny';