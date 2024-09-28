SELECT * FROM public.spotify
-- ############################################################
/* 
---------------------------------------------------------------------------
Advanced Level

11.Find the top 3 most-viewed tracks for each artist using window functions.
12.Write a query to find tracks where the liveness score is above the average.
13.Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.

*/

--Q11.Find the top 3 most-viewed tracks for each artist using window functions.

--- each artist and total views for each track
--- track with hightest views for each artist(We need top 3)
--- dense rank 
--- store in CTE 
WITH Ranking_artist AS(
SELECT artist,
       track,
       SUM(views) AS Total_views ,
	   DENSE_RANK() OVER(PARTITION BY artist ORDER BY SUM(views) DESC) AS Rank
FROM public.spotify
GROUP BY artist, track
ORDER BY 1,3 DESC)
SELECT* 
FROM Ranking_artist
WHERE rank<=3;

---Q12.Write a query to find tracks where the liveness score is above the average.


SELECT track,artist,liveness
FROM public.spotify

WHERE liveness>(SELECT AVG(liveness) FROM public.spotify)


--Q13.Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.

WITH Energy_diff AS 
(
    SELECT 
        MAX(energy) AS max_energy, 
        MIN(energy) AS min_energy, 
        MAX(energy) - MIN(energy) AS energy_diff
    FROM public.spotify
) 
SELECT track, album 
FROM public.spotify
WHERE energy IN (SELECT max_energy FROM Energy_diff) OR energy IN (SELECT min_energy FROM Energy_diff);













