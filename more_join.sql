/* 1 */
SELECT
    id,
    title
FROM
    movie
WHERE
    yr = 1962;

/* 2 */
SELECT
    yr
FROM
    movie
WHERE
    title = 'Citizen Kane';

/* 3 */
SELECT
    id,
    title,
    yr
FROM
    movie
WHERE
    title LIKE '%star trek%'
ORDER BY
    yr;

/* 4 */
SELECT
    id
FROM
    actor
WHERE
    name = 'Glenn Close';

/* 5 */
SELECT
    id
FROM
    movie
WHERE
    title = 'Casablanca';

/* 6 */
SELECT
    name
FROM
    actor
    JOIN casting ON id = actorid
WHERE
    movieid = 11768;

/* 7 */
SELECT
    name
FROM
    actor
    JOIN casting ON id = actorid
WHERE
    movieid = (
        SELECT
            id
        FROM
            movie
        WHERE
            title = 'Alien'
    );

/* 8 */
SELECT
    title
FROM
    movie
    JOIN casting ON id = movieid
WHERE
    actorid = (
        SELECT
            id
        FROM
            actor
        WHERE
            name = 'Harrison Ford'
    );

/* 9 */
SELECT
    title
FROM
    movie
    JOIN casting ON id = movieid
WHERE
    actorid = (
        SELECT
            id
        FROM
            actor
        WHERE
            name = 'Harrison Ford'
            AND ord != 1
    );

/* 10 */
SELECT
    title,
    name
FROM
    movie
    JOIN casting ON movie.id = movieid
    JOIN actor ON actor.id = actorid
WHERE
    yr = 1962
    AND ord = 1;

/* 14 */
SELECT
    title,
    COUNT(actorid)
FROM
    movie
    JOIN casting ON movie.id = movieid
WHERE
    yr = 1978
GROUP BY
    title
ORDER BY
    COUNT(actorid) DESC,
    title;

/* 15 */
SELECT
    name
FROM
    actor
    JOIN casting ON actor.id = actorid
WHERE
    movieid IN (
        SELECT
            id
        FROM
            movie
        WHERE
            title IN (
                SELECT
                    title
                FROM
                    movie
                    JOIN casting ON movie.id = movieid
                WHERE
                    actorid IN (
                        SELECT
                            id
                        FROM
                            actor
                        WHERE
                            name = 'Art Garfunkel'
                    )
            )
    )
    AND name != 'Art Garfunkel';