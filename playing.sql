/*We want to reward our users who have been here the longest
Find the 5 oldest users
*/

SELECT * FROM users 
	ORDER BY created_at
	LIMIT 5;	

/* We want to know what day most users register on.
We want to figure out on which days should we do an ad campaign
*/

SELECT 
	DAYNAME(created_at) AS day,
	count(*) AS users_registered
FROM users
GROUP BY day
ORDER BY users_registered DESC
LIMIT 1;

/*Finding inactive users - who haven't posted a photo*/

/*SELECT username, 
	IFNULL(user_id,'INACTIVE USER') AS status
		
FROM users
	LEFT JOIN photos
		ON users.id = photos.user_id
WHERE user_id IS NULL;
*/

SELECT username AS INACTIVE_USERS
FROM users
	LEFT JOIN photos
		ON users.id = photos.user_id
WHERE photos.user_id IS NULL;	


/*WHo has the most likes*/

SELECT username, photos.id, likes.photo_id
FROM users
	LEFT JOIN photos
		ON users.id = photos.user_id
	LEFT JOIN likes
		ON users.id = likes.user_id
;

SELECT 	
		username,
		photos.user_id, 
		photos.image_url,
		count(*) as 'ph_likes'
FROM photos
	JOIN likes
		ON photos.id = likes.photo_id
	JOIN users
    ON photos.user_id = users.id	
	GROUP BY photos.id
	ORDER BY ph_likes DESC LIMIT 5;


SELECT 
    username,
    photos.id,
    photos.image_url, 
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;


/* How many times the average user post*/
/*total number of photos / total number of users*/

SELECT 
	(SELECT count(*) FROM photos) / (SELECT count(*) FROM users) AS "average photos/user";

/* 5 Most popular hastags*/


SELECT
	tag_name,
	COUNT(*) AS 'used_count'
FROM tags
JOIN photo_tags
	ON tags.id = photo_tags.tag_id
GROUP BY tag_id
ORDER BY used_count DESC LIMIT 5;



/*Finding the bots - the users who have liked every single photo*/



SELECT username, 
       Count(*) AS num_likes 
FROM   users 
       INNER JOIN likes 
               ON users.id = likes.user_id 
GROUP  BY likes.user_id 
HAVING num_likes = (SELECT Count(*) 
                    FROM   photos); 



