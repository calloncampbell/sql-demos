-- Integrity rules that a CHECK or FK cannot express across tables.
-- 1. Personal logs must be Confidential or Private.
-- 2. The author must have been posted to the vessel in that series (CharacterAssignment).
-- 3. A log's references must stay in the same series as the log.
CREATE TRIGGER dbo.TR_Log_Integrity
ON dbo.[Log]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted AS i
        INNER JOIN dbo.LogType AS lt ON lt.LogTypeId = i.LogTypeId
        WHERE lt.Category = 'Personal' AND i.Classification NOT IN ('Confidential', 'Private'))
        THROW 50050, N'Personal logs must be Confidential or Private.', 1;

    IF EXISTS (
        SELECT 1
        FROM inserted AS i
        WHERE NOT EXISTS (
            SELECT 1
            FROM dbo.CharacterAssignment AS ca
            WHERE ca.CharacterId = i.AuthorCharacterId
              AND ca.VesselId = i.VesselId
              AND ca.SeriesId = i.SeriesId))
        THROW 50051, N'The log author has no assignment on that vessel in that series.', 1;

    IF UPDATE(SeriesId) AND EXISTS (
        SELECT 1
        FROM inserted AS i
        INNER JOIN dbo.LogReference AS lr ON lr.LogId = i.LogId OR lr.ReferencedLogId = i.LogId
        INNER JOIN dbo.[Log] AS a ON a.LogId = lr.LogId
        INNER JOIN dbo.[Log] AS b ON b.LogId = lr.ReferencedLogId
        WHERE a.SeriesId <> b.SeriesId)
        THROW 50052, N'Changing the series would leave a log reference across series.', 1;
END;
