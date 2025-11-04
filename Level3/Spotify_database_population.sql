

INSERT INTO spotify.users (email, password_sha, username, birthdate, gender, country, postalcode, type) VALUES
('laura.martin@gmail.com', 'sha256$abc123', 'lauram', '1990-05-12', 'F', 'Spain', '08001', 'Premium'),
('david.rojas@yahoo.com', 'sha256$def456', 'davidr', '1985-11-23', 'M', 'Spain', '28013', 'Free'),
('maria.lopez@outlook.com', 'sha256$ghi789', 'marial', '1993-07-08', 'F', 'Mexico', '11560', 'Premium'),
('juan.perez@gmail.com', 'sha256$jkl012', 'juanp', '1988-02-17', 'M', 'Argentina', 'C1001', 'Free'),
('sofia.gomez@hotmail.com', 'sha256$mno345', 'sofiag', '1995-09-30', 'F', 'Colombia', '110111', 'Premium'),
('carlos.mendez@gmail.com', 'sha256$pqr678', 'carlosm', '1992-04-05', 'M', 'Chile', '8320000', 'Free'),
('ana.torres@icloud.com', 'sha256$stu901', 'anatorres', '1997-12-21', 'F', 'Spain', '41001', 'Premium'),
('ricardo.diaz@gmail.com', 'sha256$vwx234', 'ricardod', '1983-06-14', 'M', 'Peru', '15001', 'Free'),
('valentina.ruiz@gmail.com', 'sha256$yz1234', 'valentinar', '1999-03-03', 'F', 'Spain', '46001', 'Premium'),
('miguel.santos@gmail.com', 'sha256$abc567', 'miguels', '1991-08-19', 'M', 'Spain', '50001', 'Free');

INSERT INTO spotify.subscriptions (user_id, starts_on, finishes_on, payment_method) VALUES
(1, '2025-01-01 10:00:00', '2026-01-01 10:00:00', 'Card'),
(3, '2025-02-15 12:00:00', '2026-02-15 12:00:00', 'Paypal'),
(5, '2025-03-10 09:30:00', '2026-03-10 09:30:00', 'Card'),
(7, '2025-04-20 14:45:00', '2026-04-20 14:45:00', 'Paypal'),
(9, '2025-05-05 08:00:00', '2026-05-05 08:00:00', 'Card');

INSERT INTO spotify.subscribed_by_card (user_id, subscription_id, card_number, card_expiry_month, card_expiry_year, card_cvv) VALUES
(1, 1, '4111111111111111', '12', '2026', '123'),
(5, 3, '5500000000000004', '06', '2025', '456'),
(9, 5, '340000000000009', '09', '2027', '789');

INSERT INTO spotify.subscribed_by_paypayl (user_id, subscription_id, paypal_username) VALUES
(3, 2, 'marial.paypal'),
(7, 4, 'anatorres.paypal');

INSERT INTO spotify.payment_details (subscription_id, date, total) VALUES
(1, '2025-01-01 10:00:00', 9.99),
(2, '2025-02-15 12:00:00', 9.99),
(3, '2025-03-10 09:30:00', 9.99),
(4, '2025-04-20 14:45:00', 9.99),
(5, '2025-05-05 08:00:00', 9.99);

INSERT INTO spotify.artists (name, image) VALUES
('Rosalía', '0xFFD8FFE000104A46494600010101006000600000'),
('Bad Bunny', '0xFFD8FFE000104A46494600010101006000600000'),
('Dua Lipa', '0xFFD8FFE000104A46494600010101006000600000'),
('Coldplay', '0xFFD8FFE000104A46494600010101006000600000'),
('Taylor Swift', '0xFFD8FFE000104A46494600010101006000600000'),
('Ed Sheeran', '0xFFD8FFE000104A46494600010101006000600000'),
('Shakira', '0xFFD8FFE000104A46494600010101006000600000'),
('The Weeknd', '0xFFD8FFE000104A46494600010101006000600000'),
('Imagine Dragons', '0xFFD8FFE000104A46494600010101006000600000'),
('Karol G', '0xFFD8FFE000104A46494600010101006000600000');

INSERT INTO spotify.albums (artist_id, title, released_in, cover) VALUES
(1, 'Motomami', '2022-03-18', '0xFFD8FFE000104A46494600010101006000600000'),
(2, 'Un Verano Sin Ti', '2022-05-06', '0xFFD8FFE000104A46494600010101006000600000'),
(3, 'Future Nostalgia', '2020-03-27', '0xFFD8FFE000104A46494600010101006000600000'),
(4, 'Music of the Spheres', '2021-10-15', '0xFFD8FFE000104A46494600010101006000600000'),
(5, 'Midnights', '2022-10-21', '0xFFD8FFE000104A46494600010101006000600000'),
(6, 'Equals', '2021-10-29', '0xFFD8FFE000104A46494600010101006000600000'),
(7, 'El Dorado', '2017-05-26', '0xFFD8FFE000104A46494600010101006000600000'),
(8, 'After Hours', '2020-03-20', '0xFFD8FFE000104A46494600010101006000600000'),
(9, 'Mercury – Act 1', '2021-09-03', '0xFFD8FFE000104A46494600010101006000600000'),
(10, 'Mañana Será Bonito', '2023-02-24', '0xFFD8FFE000104A46494600010101006000600000');

INSERT INTO spotify.songs (title, length, total_reproductions, album_id) VALUES
('Saoko', '00:03:06', 120000000, 1),
('Tití Me Preguntó', '00:04:02', 300000000, 2),
('Levitating', '00:03:23', 450000000, 3),
('My Universe', '00:03:46', 220000000, 4),
('Anti-Hero', '00:03:20', 500000000, 5),
('Shivers', '00:03:27', 350000000, 6),
('Me Gusta', '00:03:10', 180000000, 7),
('Blinding Lights', '00:03:20', 700000000, 8),
('Wrecked', '00:04:00', 150000000, 9),
('Provenza', '00:03:30', 400000000, 10),
('Candy', '00:03:15', 100000000, 1),
('Ojitos Lindos', '00:03:45', 380000000, 2),
('Physical', '00:03:13', 200000000, 3),
('Humankind', '00:04:00', 90000000, 4),
('Bejeweled', '00:03:14', 250000000, 5),
('Bad Habits', '00:03:50', 420000000, 6),
('Chantaje', '00:03:16', 300000000, 7),
('Save Your Tears', '00:03:35', 600000000, 8),
('Follow You', '00:02:55', 170000000, 9),
('X Si Volvemos', '00:03:40', 310000000, 10);

INSERT INTO spotify.playlists (user_id, name, total_songs, status) VALUES
(1, 'Workout Vibes', 0, 'Active'),
(3, 'Chill Hits', 0, 'Active'),
(5, 'Party Mix', 0, 'Active'),
(7, 'Romantic Songs', 0, 'Active'),
(9, 'Focus Mode', 0, 'Active');

INSERT INTO spotify.playlists_has_songs (playlist_id, song_id, user_id, song_position) VALUES
(1, 2, 1, 1),
(1, 3, 1, 2),
(1, 8, 1, 3),
(3, 1, 3, 1),
(3, 11, 3, 2),
(3, 13, 3, 3),
(3, 17, 3, 4),
(5, 2, 5, 1),
(5, 10, 5, 2),
(5, 20, 5, 3),
(5, 16, 5, 4),
(5, 7, 5, 5),
(2, 5, 7, 1),
(2, 15, 7, 2),
(4, 4, 9, 1),
(4, 9, 9, 2),
(4, 19, 9, 3);

INSERT INTO spotify.user_likes_song (user_id, song_id) VALUES
(1, 2),
(1, 8),
(3, 1),
(3, 13),
(5, 10),
(5, 20),
(7, 5),
(7, 15),
(9, 4),
(9, 19);

INSERT INTO spotify.user_likes_album (user_id, album_id) VALUES
(1, 2),
(3, 1),
(5, 10),
(7, 5),
(9, 4);

INSERT INTO spotify.playlist_is_shared (playlist_id, user_id) VALUES
(1, 3),
(1, 5),
(3, 1),
(3, 7),
(4, 9),
(4, 1),
(5, 5);

INSERT INTO spotify.user_follows_artist (user_id, artist_id) VALUES
(1, 2),
(1, 3),
(3, 1),
(3, 5),
(5, 10),
(5, 7),
(7, 4),
(7, 6),
(9, 8),
(9, 9);

INSERT INTO spotify.artist_like_artist (artists_id, artist_id1) VALUES
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 6),
(6, 7),
(7, 8),
(8, 9),
(9, 10),
(10, 1);