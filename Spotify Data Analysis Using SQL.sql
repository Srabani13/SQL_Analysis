--  Spotify Data Analysis Using SQL 
-- create table

CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

SELECT * FROM spotify

--- EDA 
-- How many rows are there in dataset
SELECT COUNT(*) 
FROM spotify;
--- How many unique artist are there in dataset
SELECT COUNT(DISTINCT artist) 
FROM spotify;
--- How many album are there in dataset
SELECT COUNT(album) 
FROM spotify;
-- Rename the column 
ALTER TABLE spotify 
RENAME COLUMN EnergyLiveness TO energy_liveness;
-- Min, max & AVG duration of a sound track 
SELECT MAX(Duration_min),MIN(Duration_min),AVG(Duration_min)
FROM spotify;
-- How many songs have 0 duration ?
SELECT * FROM spotify
WHERE Duration_min = 0;
-- Removed songs with 0 duration (because it is impractical for audio files)
DELETE FROM spotify
WHERE Duration_min = 0;
SELECT * FROM spotify
WHERE Duration_min = 0;

--Most liked track 
SELECT  Track,  Likes
FROM spotify
ORDER BY Likes DESC
LIMIT 1;








-- Uncovering insights

/* 
---------------------------------------------------------------------------
1.Retrieve the names of all tracks that have more than 1 billion streams.
2.List all albums along with their respective artists.
3.Get the total number of comments for tracks where licensed = TRUE.
4.Find all tracks that belong to the album type single.
5.Count the total number of tracks by each artist.

*/
-- Q1.Retrieve the names of all tracks that have more than 1 billion streams.

SELECT Track,Stream
FROM spotify
WHERE Stream > 1000000000;


-- Q2.List all albums along with their respective artists.
SELECT DISTINCT album,artist
FROM spotify;

--Q3.Get the total number of comments for tracks where licensed = TRUE.
SELECT 
SUM(comments) AS Total_Comment
FROM spotify
WHERE licensed = 'true';

--Q4.Find all tracks that belong to the album type single.

SELECT track
FROM spotify
WHERE album_type ='single' ;


--Q5.Count the total number of tracks by each artist.

SELECT artist ,
COUNT(track) AS Total_Track
FROM spotify
GROUP BY artist 
ORDER BY 2 ASC ;

############################################################
/* 
---------------------------------------------------------------------------
Medium Level

6.Calculate the average danceability of tracks in each album.
7.Find the top 5 tracks with the highest energy values.
8.List all tracks along with their views and likes where official_video = TRUE.
9.For each album, calculate the total views of all associated tracks.
10.Retrieve the track names that have been streamed on Spotify more than YouTube.

*/

--- Q6.Calculate the average danceability of tracks in each album.

SELECT album,
AVG(danceability) AS danceability_avg
FROM spotify
GROUP BY album 

-- Q7.Find the top 5 tracks with the highest energy values.

SELECT track,
MAX(energy) AS Highest_energy
FROM spotify
GROUP BY track 
LIMIT 5;

--Q8.List all tracks along with their views and likes where official_video = TRUE.

SELECT track,
SUM(views) AS Total_views, 
SUM(likes) AS Total_likes 
FROM spotify 
WHERE official_video = 'true'
GROUP BY track 

--Q9.For each album, calculate the total views of all associated tracks.
SELECT album,
SUM(views) AS Total_views , 
track
FROM spotify 
GROUP BY album,track

-- Q10.Retrieve the track names that have been streamed on Spotify more than YouTube.
SELECT*

FROM
(SELECT 
track,
COALESCE( SUM(CASE WHEN most_played_on = 'Spotify' THEN Stream END ) ,0)AS most_played_on_Spotify,
COALESCE(SUM(CASE WHEN most_played_on = 'Youtube' THEN Stream END ),0) AS most_played_on_Youtube

FROM spotify
GROUP BY track) AS t1 
WHERE most_played_on_Spotify >  most_played_on_Youtube
AND most_played_on_Youtube <>0




############################################################
/* 
---------------------------------------------------------------------------
Advanced Level

11.Find the top 3 most-viewed tracks for each artist using window functions.
12.Write a query to find tracks where the liveness score is above the average.
13.Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.

*/

--Q11.Find the top 3 most-viewed tracks for each artist using window functions.










