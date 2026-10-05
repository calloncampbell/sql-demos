-- "My logs": every public non-personal log, plus every log (any classification) written by the
-- viewer. The viewer comes from SESSION_CONTEXT, not from a caller-supplied argument; a trusted
-- layer sets it once per session with @read_only = 1, e.g.
--   EXEC sp_set_session_context N'ViewerCharacterId', @id, @read_only = 1;
-- With no viewer set, only public non-personal logs are returned.
CREATE VIEW dbo.MyLog
AS
SELECT  l.LogId,
        lt.Name         AS LogType,
        lt.Category,
        sr.Abbreviation AS Series,
        v.Name          AS Vessel,
        l.AuthorCharacterId,
        c.Name          AS Author,
        l.Stardate,
        l.Title,
        l.Content,
        l.Classification
FROM dbo.[Log] AS l
INNER JOIN dbo.LogType     AS lt ON lt.LogTypeId = l.LogTypeId
INNER JOIN dbo.Series      AS sr ON sr.SeriesId = l.SeriesId
INNER JOIN dbo.Vessel      AS v  ON v.VesselId = l.VesselId
INNER JOIN dbo.[Character] AS c  ON c.CharacterId = l.AuthorCharacterId
WHERE l.AuthorCharacterId = TRY_CAST(SESSION_CONTEXT(N'ViewerCharacterId') AS INT)
   OR (l.Classification = 'Public' AND lt.Category <> 'Personal');
