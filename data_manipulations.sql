USE datacleaning;
-- Create a table with cyberbullier acount informations 
CREATE TABLE cyberbullies_acount_profil AS
SELECT SenderId,
    SenderAccountYears,
    SenderFavorites,
    SenderFollowings,
    SenderFollowers,
    SenderStatues,
    SenderLocation
FROM main
WHERE IsCyberbullying = TRUE;
-- Create a table with regulare user acount informations 
CREATE TABLE no_cyberbullies_acount_profil AS
SELECT SenderId,
    SenderAccountYears,
    SenderFavorites,
    SenderFollowings,
    SenderFollowers,
    SenderStatues,
    SenderLocation
FROM main
WHERE IsCyberbullying = FALSE;
-- Calculate the average message length for cyberbullying and non-cyberbullying incidents:
SELECT IsCyberbullying,
    AVG(LENGTH(Text)) AS AvgMessageLength
FROM main
GROUP BY IsCyberbullying;
-- Identify the most common words in cyberbullying messages:
SELECT SUBSTRING_INDEX(
        SUBSTRING_INDEX(Text, ' ', n.digit + 1),
        ' ',
        -1
    ) AS word,
    COUNT(*) AS frequency
FROM main
    JOIN (
        SELECT 0 AS digit
        UNION ALL
        SELECT 1
        UNION ALL
        SELECT 2
        UNION ALL
        SELECT 3
    ) n ON LENGTH(Text) - LENGTH(REPLACE(Text, ' ', '')) >= n.digit
WHERE IsCyberbullying = 1
GROUP BY word
ORDER BY frequency DESC
LIMIT 10;
-- You can adjust the limit to get more or fewer common words
SELECT SenderFollowings,
    SenderFollowers,
    SenderStatues,
    SenderLocation
FROM main
WHERE IsCyberbullying = TRUE;
-- Find the top cyberbullying users (those with the highest number of identified cyberbullying incidents)
SELECT Id,
    COUNT(*) AS NumOfCyberbullyingIncidents
FROM main
WHERE IsCyberbullying = 1
GROUP BY Id
ORDER BY NumOfCyberbullyingIncidents DESC
LIMIT 10; --  adjusting the limit to get more or fewer top users