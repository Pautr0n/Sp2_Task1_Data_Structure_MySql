INSERT INTO users (email, password_hash, name, birth_date, gender, country, postal_code) VALUES
('alice@example.com', 'hash1', 'Alice Smith', '1990-05-12', 'F', 'Spain', '08001'),
('bob@example.com', 'hash2', 'Bob Johnson', '1985-11-23', 'M', 'USA', '90210'),
('carla@example.com', 'hash3', 'Carla Ruiz', '1993-03-08', 'F', 'Mexico', '11000'),
('daniel@example.com', 'hash4', 'Daniel Lee', '2000-07-19', 'M', 'UK', 'E1 6AN'),
('eva@example.com', 'hash5', 'Eva Müller', '1995-01-30', 'F', 'Germany', '10115');

INSERT INTO videos (users_id, title, description, size, file_name, length, reproductions, thumbnail, state) VALUES
(1, 'Barcelona Travel Vlog', 'Exploring the city', 104857600, 'barcelona.mp4', 600, 12000, '0x00', 'Public'),
(2, 'Guitar Tutorial', 'Learn basic chords', 52428800, 'guitar.mp4', 300, 8500, '0x00', 'Public'),
(3, 'Cooking Tacos', 'Step-by-step recipe', 73400320, 'tacos.mp4', 420, 9500, '0x00', 'Public'),
(4, 'Gaming Highlights', 'Top plays of the week', 157286400, 'gaming.mp4', 900, 20000, '0x00', 'Private'),
(5, 'Yoga for Beginners', 'Morning routine', 62914560, 'yoga.mp4', 480, 11000, '0x00', 'Public');

INSERT INTO tags (name) VALUES
('Travel'), ('Music'), ('Cooking'), ('Gaming'), ('Fitness');

INSERT INTO channels (user_id, video_id, name, description) VALUES
(1, 1, 'Alice Adventures', 'Travel and lifestyle'),
(2, 2, 'Bob Music', 'Guitar tutorials and covers'),
(3, 3, 'Carla Cocina', 'Recetas mexicanas'),
(4, 4, 'Dan Plays', 'Gaming content'),
(5, 5, 'Eva Wellness', 'Yoga and fitness');

INSERT INTO user_is_subscribed (channel_id, user_id) VALUES
(1, 2), (1, 3), (2, 1), (3, 4), (4, 5), (5, 1);

INSERT INTO playlists (name, state, users_id) VALUES
('My Travel Picks', 'Public', 1),
('Workout Motivation', 'Private', 5),
('Cooking Ideas', 'Public', 3);

INSERT INTO playlist_details (video_id, playlist_id) VALUES
(1, 1), (5, 2), (3, 3), (2, 1), (4, 2);

INSERT INTO user_reacts_video (user_id, video_id, reaction) VALUES
(2, 1, 'Like'), (3, 1, 'Like'), (1, 2, 'Like'),
(4, 3, 'Dislike'), (5, 5, 'Like');

INSERT INTO video_has_tags (tag_id, video_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

INSERT INTO video_comments (user_id, video_id, comment) VALUES
(2, 1, 'Amazing shots!'), (3, 1, 'Loved the vibe!'),
(1, 2, 'Very helpful tutorial'), (5, 5, 'Great routine!'),
(4, 3, 'Looks delicious!');

INSERT INTO user_reacts_comment (user_id, video_comment_id, reaction) VALUES
(1, 1, 'Like'), (2, 3, 'Like'), (3, 5, 'Dislike'), (4, 2, 'Like'), (5, 4, 'Like');