-- Logs that are safe to show to anyone: Confidential and Private (including all personal logs)
-- and Classified entries are excluded.
CREATE VIEW dbo.PublicLog
AS
SELECT  l.LogId,
        lt.Name      AS LogType,
        lt.Category,
        v.Name       AS Vessel,
        v.Registry,
        l.AuthorCharacterId,
        c.Name       AS Author,
        l.Stardate,
        l.LoggedAt,
        l.Title,
        l.Content
FROM dbo.[Log] AS l
INNER JOIN dbo.LogType    AS lt ON lt.LogTypeId = l.LogTypeId
INNER JOIN dbo.Vessel     AS v  ON v.VesselId = l.VesselId
INNER JOIN dbo.[Character] AS c ON c.CharacterId = l.AuthorCharacterId
WHERE l.Classification = 'Public'
  AND lt.Category <> 'Personal';
