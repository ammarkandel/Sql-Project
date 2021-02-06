/* 1 */
SELECT
    COUNT(*)
FROM
    stops;

/* 2 */
SELECT
    id
FROM
    stops
WHERE
    name = 'Craiglockhart';

/* 3 */
SELECT
    id,
    name
FROM
    stops
    JOIN route ON id = stop
WHERE
    num = '4'
    AND company = 'LRT';

/* 4 */
SELECT
    company,
    num,
    COUNT(*)
FROM
    route
WHERE
    stop = 149
    OR stop = 53
GROUP BY
    company,
    num
HAVING
    COUNT(*) = 2;

/* 5 */
SELECT
    a.company,
    a.num,
    a.stop,
    b.stop
FROM
    route a
    JOIN route b ON (
        a.company = b.company
        AND a.num = b.num
    )
WHERE
    a.stop = 53
    AND b.stop = 149;

/* 6 */
SELECT
    a.company,
    a.num,
    stopa.name,
    stopb.name
FROM
    route a
    JOIN route b ON (
        a.company = b.company
        AND a.num = b.num
    )
    JOIN stops stopa ON (a.stop = stopa.id)
    JOIN stops stopb ON (b.stop = stopb.id)
WHERE
    stopa.name = 'Craiglockhart'
    AND stopb.name = 'London Road';

/* 7 */
SELECT
    a.company,
    a.num
FROM
    route a
    JOIN route b ON a.company = b.company
    AND a.num = b.num
WHERE
    a.stop = 115
    AND b.stop = 137
GROUP BY
    a.company,
    a.num;

/* 8 */
SELECT
    a.company,
    a.num
FROM
    route a
    JOIN route b ON a.company = b.company
    AND a.num = b.num
    JOIN stops stopa ON stopa.id = a.stop
    JOIN stops stopb ON stopb.id = b.stop
WHERE
    stopa.name = 'Craiglockhart'
    AND stopb.name = 'Tollcross'
GROUP BY
    a.company,
    a.num;

/* 9 */
SELECT
    stopb.name,
    a.company,
    a.num
FROM
    route a
    JOIN route b ON a.company = b.company
    AND a.num = b.num
    JOIN stops stopa ON a.stop = stopa.id
    JOIN stops stopb ON b.stop = stopb.id
WHERE
    a.company = 'LRT'
    AND stopa.name = 'Craiglockhart';