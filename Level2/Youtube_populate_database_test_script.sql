use youtube;

INSERT INTO users (users_email, users_password_hash, users_name, users_birth_date, users_gender, users_country, users_postal_code) VALUES
('pau@example.com', 'hash123', 'Pau', '1992-10-28', 'M', 'España', '08001'),
('laura@example.com', 'hash456', 'Laura', '1990-05-12', 'F', 'España', '08002'),
('joan@example.com', 'hash789', 'Joan', '1988-03-22', 'M', 'España', '08003');

INSERT INTO videos (users_users_id, videos_title, videos_description, videos_size, videos_file_name, videos_length, videos_reproductions, videos_thumbnail, videos_state) VALUES
(1, 'Intro a SQL', 'Tutorial básico de SQL', 10485760, 'intro_sql.mp4', 15, 120, '', 'Public'),
(2, 'Java desde cero', 'Curso completo de Java', 20971520, 'java_curso.mp4', 45, 300, '', 'Public'),
(3, 'Diseño ER', 'Cómo hacer diagramas entidad-relación', 5242880, 'er_modelado.mp4', 20, 80, '', 'Private');

INSERT INTO video_tags (video_tags_name) VALUES
('SQL'), ('Java'), ('Modelado'), ('Tutorial');

INSERT INTO video_tags_has_videos (video_tags_video_tags_id, videos_videos_id) VALUES
(1, 1), (4, 1),
(2, 2), (4, 2),
(3, 3), (4, 3);

INSERT INTO channels (users_users_id, videos_videos_id, channels_name, channels_description) VALUES
(1, 1, 'Canal de Pau', 'Tutoriales técnicos'),
(2, 2, 'Laura Aprende', 'Cursos de programación'),
(3, 3, 'Joan Dev', 'Modelado de datos');

INSERT INTO user_is_subscribed (channels_channels_id, users_users_id) VALUES
(1, 2),
(2, 1),
(3, 1);

INSERT INTO user_playlist (user_playlist_name, user_playlist_state, users_users_id) VALUES
('Favoritos SQL', 'Public', 1),
('Aprender Java', 'Private', 2);

INSERT INTO playlist_details (videos_videos_id, user_playlist_user_playlist_id) VALUES
(1, 1), (2, 2);

INSERT INTO user_video_reactions (users_users_id, videos_videos_id, user_video_reactions_reaction) VALUES
(2, 1, 'Like'),
(1, 2, 'Dislike');

INSERT INTO video_comments (users_users_id, videos_videos_id, video_comments_comment) VALUES
(2, 1, 'Muy buen tutorial, gracias!'),
(1, 2, 'No me gustó el ritmo del vídeo');

INSERT INTO user_comment_reactions (users_users_id, video_comments_video_comments_id, user_comment_reaction_reaction) VALUES
(1, 1, 'Like'),
(2, 2, 'Dislike');

-- Checking likes and dislikes in videos.
SELECT v.videos_title AS Video,
SUM(CASE WHEN uvr.user_video_reactions_reaction = 'Like' THEN 1 ELSE 0 END) AS Likes,
SUM(CASE WHEN uvr.user_video_reactions_reaction = 'Dislike' THEN 1 ELSE 0 END) AS Dislikes
FROM videos v
LEFT JOIN user_video_reactions uvr ON v.videos_id = uvr.videos_videos_id
GROUP BY v.videos_id;

-- Checking number of comments in videos
SELECT v.videos_title AS Video,
COUNT(vc.video_comments_id) AS Comments
FROM videos v
LEFT JOIN video_comments vc ON v.videos_id = vc.videos_videos_id
GROUP BY v.videos_id;

-- Comments by user
SELECT u.users_name AS Usuario,
COUNT(vc.video_comments_id) AS Comments_done
FROM users u
LEFT JOIN video_comments vc ON u.users_id = vc.users_users_id
GROUP BY u.users_id;

-- Videos published by channel
SELECT c.channels_name AS Channel,
v.videos_title AS Video
FROM channels c
JOIN videos v ON c.videos_videos_id = v.videos_id;

-- Subscribed channels for each user
SELECT u.users_name AS User,
COUNT(uis.channels_channels_id) AS Subscriptions
FROM users u
LEFT JOIN user_is_subscribed uis ON u.users_id = uis.users_users_id
GROUP BY u.users_id;

-- Videos inside a playlist
SELECT up.user_playlist_name AS Playlist,
v.videos_title AS Video
FROM user_playlist up
JOIN playlist_details pd ON up.user_playlist_id = pd.user_playlist_user_playlist_id
JOIN videos v ON pd.videos_videos_id = v.videos_id;

-- Tags in each video
SELECT v.videos_title AS Video,
GROUP_CONCAT(vt.video_tags_name SEPARATOR ', ') AS Tags
FROM videos v
JOIN video_tags_has_videos vthv ON v.videos_id = vthv.videos_videos_id
JOIN video_tags vt ON vthv.video_tags_video_tags_id = vt.video_tags_id
GROUP BY v.videos_id;