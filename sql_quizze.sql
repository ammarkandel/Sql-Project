/* 1-SELECT basics */
SELECT
    population
FROM
    world
WHERE
    name = 'Germany';

SELECT
    name,
    population
FROM
    world
WHERE
    name IN ('Sweden', 'Norway', 'Denmark');

SELECT
    name,
    area
FROM
    world
WHERE
    area BETWEEN 200000
    AND 250000;

/* 2-SELECT names */
/* Find the country that start with Y */
SELECT
    name
FROM
    world
WHERE
    name LIKE 'Y%';

/* Find the countries that end with y */
SELECT
    name
FROM
    world
WHERE
    name LIKE 'y%';

/* Find the countries that contain the letter x */
SELECT
    name
FROM
    world
WHERE
    name LIKE '%x%';

/* Find the countries that end with land */
SELECT
    name
FROM
    world
WHERE
    name LIKE '%land';

/* Find the countries that start with C and end with ia */
SELECT
    name
FROM
    world
WHERE
    name LIKE 'C%ia';

/* Find the country that has oo in the name */
SELECT
    name
FROM
    world
WHERE
    name LIKE '%oo%';

/* Find the countries that have three or more a in the name */
SELECT
    name
FROM
    world
WHERE
    name LIKE '%a%a%a%';

/* Find the countries that have "t" as the second character. */
SELECT
    name
FROM
    world
WHERE
    name LIKE '_t%'
ORDER BY
    name;

/* Find the countries that have two "o" characters separated by two others. */
SELECT
    name
FROM
    world
WHERE
    name LIKE '%o__o%';

/* Find the countries that have exactly four characters. */
SELECT
    name
FROM
    world
WHERE
    length(name) = 4;

/* Find the country where the name is the capital city. */
SELECT
    name
FROM
    world
WHERE
    name = capital;

/* Find the country where the capital is the country plus "City". */
SELECT
    name
FROM
    world
WHERE
    capital LIKE concat(name, ' ', 'City');

/* Find the capital and the name where the capital includes the name of the country. */
SELECT
    capital,
    name
FROM
    world
WHERE
    capital LIKE concat('%', name, '%');

/* Find the capital and the name where the capital is an extension of name of the country. */
SELECT
    capital,
    name
FROM
    world
WHERE
    capital LIKE concat('%', name, '%')
    AND capital > name;

/* Show the name and the extension where the capital is an extension of name of the country. */
SELECT
    name,
    REPLACE(capital, name, '') AS Extension
FROM
    world
WHERE
    capital LIKE concat('%', name, '%')
    AND capital > name;

/* SELECT from Nobel Tutorial */
/* Change the query shown so that it displays Nobel prizes for 1950. */
SELECT
    *
FROM
    nobel
WHERE
    yr = 1950;

/* Show who won the 1962 prize for Literature. */
SELECT
    winner
FROM
    nobel
WHERE
    yr = 1962
    AND subject = 'Literature';

/* Show the year and subject that won 'Albert Einstein' his prize. */
SELECT
    yr,
    subject
FROM
    nobel
WHERE
    winner = 'Albert Einstein';

/* Give the name of the 'Peace' winners since the year 2000, including 2000. */
SELECT
    winner
FROM
    nobel
WHERE
    yr >= 2000
    AND subject = 'Peace';

/* Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive. */
SELECT
    *
FROM
    nobel
WHERE
    subject = 'Literature'
    AND yr BETWEEN 1980
    AND 1989;

/*Show all details of the presidential winners: 
 Theodore Roosevelt,Woodrow Wilson,Jimmy Carter,Barack Obama*/
SELECT
    *
FROM
    nobel
WHERE
    winner IN (
        'Theodore Roosevelt',
        'Woodrow Wilson',
        'Jimmy Carter',
        'Barack Obama'
    );

/* Show the winners with first name John */
SELECT
    winner
FROM
    nobel
WHERE
    winner LIKE 'John%';

/* Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984. */
SELECT
    *
FROM
    nobel
WHERE
    (
        subject = 'Chemistry'
        AND yr = 1984
    )
    OR (
        subject = 'Physics'
        AND yr = 1980
    );

/* Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine */
SELECT
    *
FROM
    nobel
WHERE
    (yr = 1980)
    AND subject NOT IN ('Chemistry', 'Medicine');

/* Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004) */
SELECT
    *
FROM
    nobel
WHERE
    (
        subject = 'Medicine'
        AND yr < 1910
    )
    OR (
        subject = 'Literature'
        AND yr >= 2004
    );

/* Find all details of the prize won by PETER GRÜNBERG */
SELECT
    *
FROM
    nobel
WHERE
    winner = 'Peter Grünberg';

/* Find all details of the prize won by EUGENE O'NEILL */
SELECT
    *
FROM
    nobel
WHERE
    winner = 'Eugene O''Neill';

/* List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order. */
SELECT
    winner,
    yr,
    subject
FROM
    nobel
WHERE
    winner LIKE 'sir%'
ORDER BY
    yr DESC,
    winner;

/* Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last. */
SELECT
    winner,
    subject
FROM
    nobel
WHERE
    yr = 1984
ORDER BY
    subject IN ('Physics', 'Chemistry'),
    subject,
    winner;

/* SELECT within SELECT Tutorial */
/* Bigger than Russia */
SELECT
    name
FROM
    world
WHERE
    population > (
        SELECT
            population
        FROM
            world
        WHERE
            name = 'Russia'
    );

/* Show the countries in Europe with a per capita GDP greater than 'United Kingdom'. */
SELECT
    name
FROM
    world
WHERE
    gdp / population > (
        SELECT
            gdp / population
        FROM
            world
        WHERE
            name = 'United Kingdom'
    )
    AND continent = 'Europe';

/* List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country. */
SELECT
    name,
    continent
FROM
    world
WHERE
    continent IN (
        SELECT
            continent
        FROM
            world
        WHERE
            name IN ('Argentina', 'Australia')
    )
ORDER BY
    name;

/* Which country has a population that is more than Canada but less than Poland? Show the name and the population. */
SELECT
    name,
    population
FROM
    world
WHERE
    population > (
        SELECT
            population
        FROM
            world
        WHERE
            name = 'Canada'
    )
    AND population < (
        SELECT
            population
        FROM
            world
        WHERE
            name = 'Poland'
    );

/* Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany. */
SELECT
    name,
    CONCAT(
        ROUND(
            population /(
                SELECT
                    population
                FROM
                    world
                WHERE
                    name = 'Germany'
            ) * 100
        ),
        '%'
    ) AS 'percentage'
FROM
    world
WHERE
    continent = 'Europe';

/* Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values) */
SELECT
    name
FROM
    world
WHERE
    gdp > ALL(
        SELECT
            gdp
        FROM
            world
        WHERE
            gdp >= 0 & & continent = 'Europe'
    )
    AND continent != 'Europe';

/*
 Find the largest country (by area) in each continent, show the continent, the name and the area
 */
SELECT
    continent,
    name,
    area
FROM
    world x
WHERE
    area >= ALL (
        SELECT
            area
        FROM
            world y
        WHERE
            y.continent = x.continent
            AND area > 0
    );

/*
 List each continent and the name of the country that comes first alphabetically.
 */
SELECT
    continent,
    name
FROM
    world x
WHERE
    name <= ALL(
        SELECT
            name
        FROM
            world y
        WHERE
            y.continent = x.continent
    );

/*
 Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.
 */
SELECT
    name,
    continent,
    population
FROM
    world x
WHERE
    25000000 > ALL(
        SELECT
            population
        FROM
            world y
        WHERE
            x.continent = y.continent
            AND y.population > 0
    );

/*
 Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.
 */
SELECT
    name,
    continent
FROM
    world x
WHERE
    population > ALL(
        SELECT
            population * 3
        FROM
            world y
        WHERE
            x.continent = y.continent
            AND population > 0
            AND y.name != x.name
    );