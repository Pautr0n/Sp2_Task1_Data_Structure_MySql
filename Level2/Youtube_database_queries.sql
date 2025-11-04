-- Users' channels and country
SELECT u.name AS usuario, u.email, u.country, c.name AS canal
FROM users u
JOIN channels c ON u.id = c.user_id;

-- Uploaded videos by user and reproductions
SELECT u.name AS autor, v.title, v.state, v.reproductions
FROM videos v
JOIN users u ON v.users_id = u.id;

-- videos' tags
SELECT v.title AS video, t.name AS etiqueta
FROM video_has_tags vt
JOIN videos v ON vt.video_id = v.id
JOIN tags t ON vt.tag_id = t.id;

-- Channels' subscriptors
SELECT c.name AS canal, u.name AS suscriptor
FROM user_is_subscribed us
JOIN channels c ON us.channel_id = c.id
JOIN users u ON us.user_id = u.id;

-- playlists details
SELECT p.name AS playlist, v.title AS video
FROM playlist_details pd
JOIN playlists p ON pd.playlist_id = p.id
JOIN videos v ON pd.video_id = v.id;

-- videos' reactions
SELECT v.title AS video, urv.reaction, COUNT(*) AS total
FROM user_reacts_video urv
JOIN videos v ON urv.video_id = v.id
GROUP BY v.title, urv.reaction;

-- video comments
SELECT v.title AS video, u.name AS autor_comentario, vc.comment, vc.created_on
FROM video_comments vc
JOIN videos v ON vc.video_id = v.id
JOIN users u ON vc.user_id = u.id;

-- comments' reactions
SELECT u.name AS usuario, vc.comment AS comentario, urc.reaction, urc.reaction_date
FROM user_reacts_comment urc
JOIN video_comments vc ON urc.video_comment_id = vc.id
JOIN users u ON urc.user_id = u.id;

-- total videos by status of  user
SELECT v.state, COUNT(*) AS total_videos
FROM videos v
JOIN users u ON v.users_id = u.id
WHERE u.name = 'Alice Smith'
GROUP BY v.state;

-- top 5
SELECT title, reproductions
FROM videos
ORDER BY reproductions DESC
LIMIT 5;