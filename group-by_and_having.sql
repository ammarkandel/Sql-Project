/*
 For each continent show the continent and number of countries.
 */
SELECT
    continent,
    COUNT(name)
FROM
    world
GROUP BY
    continent;

/* 
 For each continent show the continent and number of countries with populations of at least 10 million.
 */
SELECT
    continent,
    COUNT(name)
FROM
    world
WHERE
    population >= 10000000
GROUP BY
    continent;

/* List the continents that have a total population of at least 100 million. */
SELECT
    continent
FROM
    world
GROUP BY
    continent
HAVING
    SUM(population) > 100000000;