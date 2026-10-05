-- "My logs" pattern: everything public, plus every log (of any classification) the viewer wrote.
-- Other people's Classified, Confidential and Private logs are never returned.
CREATE FUNCTION dbo.LogsVisibleTo (@ViewerCharacterId INT)
RETURNS TABLE
AS
RETURN
(
    SELECT  l.LogId,
            lt.Name      AS LogType,
            lt.Category,
            v.Name       AS Vessel,
            l.AuthorCharacterId,
            c.Name       AS Author,
            l.Stardate,
            l.Title,
            l.Content,
            l.Classification
    FROM dbo.[Log] AS l
    INNER JOIN dbo.LogType     AS lt ON lt.LogTypeId = l.LogTypeId
    INNER JOIN dbo.Vessel      AS v  ON v.VesselId = l.VesselId
    INNER JOIN dbo.[Character] AS c  ON c.CharacterId = l.AuthorCharacterId
    WHERE l.AuthorCharacterId = @ViewerCharacterId
       OR (l.Classification = 'Public' AND lt.Category <> 'Personal')
);
