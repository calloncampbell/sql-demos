/*
    DemoQueries.sql
    A tour of the StarTrek database for SQL demos. Run against a published copy.
*/

-------------------------------------------------------------------------------
-- 1. Basic joins: main cast of The Next Generation
-------------------------------------------------------------------------------
SELECT  a.FullName AS Actor,
        c.Name     AS [Character],
        sa.FirstSeason,
        sa.LastSeason
FROM dbo.SeriesAppearance AS sa
INNER JOIN dbo.Series         AS s  ON s.SeriesId = sa.SeriesId
INNER JOIN dbo.ActorCharacter AS ac ON ac.ActorCharacterId = sa.ActorCharacterId
INNER JOIN dbo.Actor          AS a  ON a.ActorId = ac.ActorId
INNER JOIN dbo.[Character]    AS c  ON c.CharacterId = ac.CharacterId
WHERE s.Abbreviation = 'TNG'
  AND sa.RoleType = 'Main'
ORDER BY a.LastName;

GO

-------------------------------------------------------------------------------
-- 2. Recasts: characters played by more than one actor
-------------------------------------------------------------------------------
SELECT  c.Name AS [Character],
        COUNT(*) AS ActorCount,
        STRING_AGG(a.FullName, N', ') WITHIN GROUP (ORDER BY a.BirthDate) AS Actors
FROM dbo.ActorCharacter AS ac
INNER JOIN dbo.[Character] AS c ON c.CharacterId = ac.CharacterId
INNER JOIN dbo.Actor       AS a ON a.ActorId = ac.ActorId
GROUP BY c.Name
HAVING COUNT(*) > 1
ORDER BY ActorCount DESC, [Character];

GO

-------------------------------------------------------------------------------
-- 3. Actors who played more than one character
-------------------------------------------------------------------------------
SELECT  a.FullName AS Actor,
        STRING_AGG(c.Name, N', ') WITHIN GROUP (ORDER BY c.Name) AS Characters
FROM dbo.ActorCharacter AS ac
INNER JOIN dbo.Actor       AS a ON a.ActorId = ac.ActorId
INNER JOIN dbo.[Character] AS c ON c.CharacterId = ac.CharacterId
GROUP BY a.FullName
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC, Actor;

GO

-------------------------------------------------------------------------------
-- 4. Actors who appeared in the most series (any role)
-------------------------------------------------------------------------------
WITH ActorSeries AS
(
    SELECT DISTINCT a.FullName, s.Abbreviation, s.PremiereDate
    FROM dbo.Actor AS a
    INNER JOIN dbo.ActorCharacter   AS ac ON ac.ActorId = a.ActorId
    INNER JOIN dbo.SeriesAppearance AS sa ON sa.ActorCharacterId = ac.ActorCharacterId
    INNER JOIN dbo.Series           AS s  ON s.SeriesId = sa.SeriesId
)
SELECT TOP (10)
        FullName AS Actor,
        COUNT(*) AS SeriesCount,
        STRING_AGG(CAST(Abbreviation AS NVARCHAR(10)), N', ') WITHIN GROUP (ORDER BY PremiereDate) AS Series
FROM ActorSeries
GROUP BY FullName
ORDER BY SeriesCount DESC, Actor;

GO

-------------------------------------------------------------------------------
-- 5. LEFT JOIN / anti-join: vessels with no crew assignments
-------------------------------------------------------------------------------
SELECT v.Name, v.Registry, v.VesselType
FROM dbo.Vessel AS v
LEFT JOIN dbo.CharacterAssignment AS ca ON ca.VesselId = v.VesselId
WHERE ca.CharacterAssignmentId IS NULL;

-- Same question with NOT EXISTS (compare the execution plans)
SELECT v.Name, v.Registry, v.VesselType
FROM dbo.Vessel AS v
WHERE NOT EXISTS (SELECT 1 FROM dbo.CharacterAssignment AS ca WHERE ca.VesselId = v.VesselId);

GO

-------------------------------------------------------------------------------
-- 6. Hybrid characters (more than one species)
-------------------------------------------------------------------------------
SELECT  c.Name AS [Character],
        MAX(CASE WHEN cs.IsPrimary = 1 THEN sp.Name END) AS PrimarySpecies,
        MAX(CASE WHEN cs.IsPrimary = 0 THEN sp.Name END) AS SecondarySpecies
FROM dbo.CharacterSpecies AS cs
INNER JOIN dbo.[Character] AS c  ON c.CharacterId = cs.CharacterId
INNER JOIN dbo.Species     AS sp ON sp.SpeciesId = cs.SpeciesId
GROUP BY c.Name
HAVING COUNT(*) > 1
ORDER BY [Character];

GO

-------------------------------------------------------------------------------
-- 7. Species head-count, with each species' homeworld
-------------------------------------------------------------------------------
SELECT  sp.Name AS Species,
        p.Name  AS Homeworld,
        COUNT(cs.CharacterId) AS CharacterCount
FROM dbo.Species AS sp
LEFT JOIN dbo.Planet           AS p  ON p.PlanetId = sp.HomeworldPlanetId
LEFT JOIN dbo.CharacterSpecies AS cs ON cs.SpeciesId = sp.SpeciesId
GROUP BY sp.Name, p.Name
ORDER BY CharacterCount DESC, Species;

GO

-------------------------------------------------------------------------------
-- 8. Window functions: rank actors within each series by length of tenure
-------------------------------------------------------------------------------
WITH Tenure AS
(
    SELECT  s.Abbreviation,
            a.FullName,
            c.Name AS [Character],
            sa.RoleType,
            sa.LastSeason - sa.FirstSeason + 1 AS SeasonsAppeared
    FROM dbo.SeriesAppearance AS sa
    INNER JOIN dbo.Series         AS s  ON s.SeriesId = sa.SeriesId
    INNER JOIN dbo.ActorCharacter AS ac ON ac.ActorCharacterId = sa.ActorCharacterId
    INNER JOIN dbo.Actor          AS a  ON a.ActorId = ac.ActorId
    INNER JOIN dbo.[Character]    AS c  ON c.CharacterId = ac.CharacterId
)
SELECT  Abbreviation,
        FullName,
        [Character],
        RoleType,
        SeasonsAppeared,
        DENSE_RANK() OVER (PARTITION BY Abbreviation ORDER BY SeasonsAppeared DESC) AS TenureRank,
        COUNT(*)     OVER (PARTITION BY Abbreviation) AS CastRowsInSeries
FROM Tenure
ORDER BY Abbreviation, TenureRank, FullName;

GO

-------------------------------------------------------------------------------
-- 9. Age of each actor at their series' premiere (DATEDIFF + NULL handling)
-------------------------------------------------------------------------------
SELECT  s.Abbreviation,
        a.FullName,
        a.BirthDate,
        DATEDIFF(YEAR, a.BirthDate, s.PremiereDate)
          - CASE WHEN DATEADD(YEAR, DATEDIFF(YEAR, a.BirthDate, s.PremiereDate), a.BirthDate) > s.PremiereDate THEN 1 ELSE 0 END
          AS AgeAtPremiere
FROM dbo.SeriesAppearance AS sa
INNER JOIN dbo.Series         AS s  ON s.SeriesId = sa.SeriesId
INNER JOIN dbo.ActorCharacter AS ac ON ac.ActorCharacterId = sa.ActorCharacterId
INNER JOIN dbo.Actor          AS a  ON a.ActorId = ac.ActorId
WHERE sa.RoleType = 'Main'
  AND a.BirthDate IS NOT NULL
ORDER BY s.PremiereDate, AgeAtPremiere;

GO

-------------------------------------------------------------------------------
-- 10. Crew manifest per ship/station with rank ordering (ORDER BY on a lookup)
-------------------------------------------------------------------------------
SELECT  v.Name AS Vessel,
        v.Registry,
        s.Abbreviation AS Series,
        c.Name AS [Character],
        r.Name AS [Rank],
        ca.Position
FROM dbo.CharacterAssignment AS ca
INNER JOIN dbo.Vessel      AS v ON v.VesselId = ca.VesselId
INNER JOIN dbo.Series      AS s ON s.SeriesId = ca.SeriesId
INNER JOIN dbo.[Character] AS c ON c.CharacterId = ca.CharacterId
LEFT  JOIN dbo.[Rank]      AS r ON r.RankId = ca.RankId
ORDER BY v.Name, v.Registry, s.PremiereDate, r.SortOrder DESC, c.Name;

GO

-------------------------------------------------------------------------------
-- 11. Characters who served on more than one vessel
-------------------------------------------------------------------------------
WITH CharacterVessel AS
(
    SELECT DISTINCT c.Name AS [Character], CONCAT(v.Name, N' (', v.VesselKey, N')') AS Vessel
    FROM dbo.CharacterAssignment AS ca
    INNER JOIN dbo.[Character] AS c ON c.CharacterId = ca.CharacterId
    INNER JOIN dbo.Vessel      AS v ON v.VesselId = ca.VesselId
)
SELECT  [Character],
        COUNT(*) AS VesselCount,
        STRING_AGG(Vessel, N', ') WITHIN GROUP (ORDER BY Vessel) AS Vessels
FROM CharacterVessel
GROUP BY [Character]
HAVING COUNT(*) > 1
ORDER BY VesselCount DESC, [Character];

GO

-------------------------------------------------------------------------------
-- 12. PIVOT: count of cast rows by series and role type
-------------------------------------------------------------------------------
SELECT Series, [Main], [Recurring], [Guest]
FROM
(
    SELECT s.Abbreviation AS Series, sa.RoleType
    FROM dbo.SeriesAppearance AS sa
    INNER JOIN dbo.Series AS s ON s.SeriesId = sa.SeriesId
) AS src
PIVOT (COUNT(RoleType) FOR RoleType IN ([Main], [Recurring], [Guest])) AS pvt
ORDER BY Series;

GO

-------------------------------------------------------------------------------
-- 13. Affiliation breakdown with ROLLUP
-------------------------------------------------------------------------------
SELECT  ISNULL(af.Name, N'(none)') AS Affiliation,
        c.Gender,
        COUNT(*) AS CharacterCount
FROM dbo.[Character] AS c
LEFT JOIN dbo.Affiliation AS af ON af.AffiliationId = c.AffiliationId
GROUP BY ROLLUP (af.Name, c.Gender)
ORDER BY GROUPING(af.Name), Affiliation, GROUPING(c.Gender), c.Gender;

GO

-------------------------------------------------------------------------------
-- 14. Index seek demo: the filtered index IX_SeriesAppearance_MainCast
--     (turn on "Include Actual Execution Plan")
-------------------------------------------------------------------------------
SELECT sa.ActorCharacterId
FROM dbo.SeriesAppearance AS sa
WHERE sa.SeriesId = (SELECT SeriesId FROM dbo.Series WHERE Abbreviation = 'DS9')
  AND sa.RoleType = 'Main';
GO

GO

-------------------------------------------------------------------------------
-- 15. Crew logs: public logs for a ship in stardate order (view hides
--     Classified, Confidential and Private entries, and all personal logs)
-------------------------------------------------------------------------------
SELECT  Stardate, LogType, Author, Title
FROM dbo.PublicLog
WHERE Registry = 'NCC-74656'
ORDER BY Stardate;

GO

-------------------------------------------------------------------------------
-- 16. "My logs": what Janeway can read (all public logs plus every log she wrote,
--     including her private ones). Swap in another name to see the difference.
-------------------------------------------------------------------------------
-- The viewer is taken from SESSION_CONTEXT (set by a trusted layer), not passed by the caller.
DECLARE @ViewerCharacterId INT = (SELECT CharacterId FROM dbo.[Character] WHERE Name = N'Kathryn Janeway');
EXEC sys.sp_set_session_context @key = N'ViewerCharacterId', @value = @ViewerCharacterId, @read_only = 1;

SELECT Stardate, LogType, Author, Classification, Title
FROM dbo.MyLog
ORDER BY Stardate;

GO

-------------------------------------------------------------------------------
-- 17. Logs about one incident: follow LogReference links (recursive CTE)
--     from the Captain's log of the Voyager route through uncharted space
-------------------------------------------------------------------------------
WITH Related AS
(
    SELECT l.LogId, l.Title, CAST(0 AS INT) AS Depth
    FROM dbo.[Log] AS l
    WHERE l.Title = N'Course through uncharted space'

    UNION ALL

    SELECT l.LogId, l.Title, r.Depth + 1
    FROM Related AS r
    INNER JOIN dbo.LogReference AS lr ON lr.ReferencedLogId = r.LogId
    INNER JOIN dbo.[Log]        AS l  ON l.LogId = lr.LogId
)
SELECT r.Depth, lt.Name AS LogType, c.Name AS Author, l.Stardate, r.Title, l.Classification
FROM Related AS r
INNER JOIN dbo.[Log]       AS l  ON l.LogId = r.LogId
INNER JOIN dbo.LogType     AS lt ON lt.LogTypeId = l.LogTypeId
INNER JOIN dbo.[Character] AS c  ON c.CharacterId = l.AuthorCharacterId
ORDER BY r.Depth, l.Stardate;

GO

-------------------------------------------------------------------------------
-- 18. Tag usage: log count and authors per tag
-------------------------------------------------------------------------------
SELECT t.Tag, COUNT(*) AS LogCount, STRING_AGG(c.Name, N', ') WITHIN GROUP (ORDER BY c.Name) AS Authors
FROM dbo.LogTag AS t
INNER JOIN dbo.[Log]       AS l ON l.LogId = t.LogId
INNER JOIN dbo.[Character] AS c ON c.CharacterId = l.AuthorCharacterId
GROUP BY t.Tag
ORDER BY LogCount DESC, t.Tag;

GO

-------------------------------------------------------------------------------
-- 19. Log volume by vessel and category (ROLLUP)
-------------------------------------------------------------------------------
SELECT  ISNULL(v.Name, N'(all vessels)')             AS Vessel,
        ISNULL(lt.Category, N'(all categories)')     AS Category,
        COUNT(*)                                     AS LogCount
FROM dbo.[Log] AS l
INNER JOIN dbo.LogType AS lt ON lt.LogTypeId = l.LogTypeId
INNER JOIN dbo.Vessel  AS v  ON v.VesselId = l.VesselId
GROUP BY ROLLUP (v.Name, lt.Category)
ORDER BY GROUPING(v.Name), Vessel, GROUPING(lt.Category), Category;
GO

GO

-------------------------------------------------------------------------------
-- 20. Same ship, different series: Enterprise NCC-1701 logs split by series
--     (Spock writes logs in both TOS and SNW; Log.SeriesId tells them apart)
-------------------------------------------------------------------------------
SELECT Series, Stardate, LogType, Author, Title
FROM dbo.PublicLog
WHERE Registry = 'NCC-1701'
ORDER BY Series DESC, Stardate;

GO

-------------------------------------------------------------------------------
-- 21. Logs and tags for one series only
-------------------------------------------------------------------------------
SELECT sr.Abbreviation AS Series, t.Tag, COUNT(*) AS LogCount
FROM dbo.LogTag AS t
INNER JOIN dbo.[Log]  AS l  ON l.LogId = t.LogId
INNER JOIN dbo.Series AS sr ON sr.SeriesId = l.SeriesId
GROUP BY sr.Abbreviation, t.Tag
ORDER BY sr.Abbreviation, LogCount DESC, t.Tag;
GO