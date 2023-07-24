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
    AVG(LENGTH(Message)) AS AvgMessageLength
FROM main
GROUP BY IsCyberbullying;

-- Identify the most common words in cyberbullying messages:
SELECT SUBSTRING_INDEX(
        SUBSTRING_INDEX(Message, ' ', n.digit + 1),
        ' ',
        -1
    ) AS word,
    COUNT(*) AS frequency
FROM cyberbullying_data
    JOIN (
        SELECT 0 AS digit
        UNION ALL
        SELECT 1
        UNION ALL
        SELECT 2
        UNION ALL
        SELECT 3
    ) n ON LENGTH(Message) - LENGTH(REPLACE(Message, ' ', '')) >= n.digit
WHERE IsCyberbullying = 1
GROUP BY word
ORDER BY frequency DESC
LIMIT 10;

-- You can adjust the limit to get more or fewer common words
SenderFollowings, SenderFollowers, SenderStatues, SenderLocation
FROM main
WHERE IsCyberbullying = TRUE;

-- Find the top cyberbullying users (those with the highest number of identified cyberbullying incidents)
SELECT User,
    COUNT(*) AS NumOfCyberbullyingIncidents
FROM cyberbullying_data
WHERE IsCyberbullying = 1
GROUP BY User
ORDER BY NumOfCyberbullyingIncidents DESC
LIMIT 10; --  adjusting the limit to get more or fewer top users