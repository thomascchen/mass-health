-- WRITE YOUR QUERIES HERE

-- What 3 towns have the highest population of citizens that are 65 years and older?
SELECT town FROM town_health_records ORDER BY age_65_and_over DESC OFFSET 1 LIMIT 3;

-- What 3 towns have the highest population of citizens that are 19 years and younger?
SELECT town FROM town_health_records ORDER BY age_19_and_under DESC OFFSET 1 LIMIT 3;

-- What 5 towns have the lowest per capita income?
SELECT town FROM town_health_records ORDER BY income LIMIT 5;

-- Omitting Boston, Becket, and Beverly, what town has the highest percentage of teen births?
SELECT town FROM town_health_records WHERE percent_teen_births IS NOT NULL AND town != 'Boston' AND town != 'Beckett' AND town != 'Beverly' ORDER BY percent_teen_births DESC LIMIT 1;

-- Omitting Boston, what town has the highest number of infant mortalities?
SELECT town FROM town_health_records WHERE town != 'Boston' ORDER BY infant_deaths DESC OFFSET 1 LIMIT 1;
