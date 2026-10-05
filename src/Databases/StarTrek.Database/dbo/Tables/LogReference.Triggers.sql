-- Referenced logs must belong to the same series as the referencing log.
CREATE TRIGGER dbo.TR_LogReference_SameSeries
ON dbo.LogReference
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted AS i
        INNER JOIN dbo.[Log] AS a ON a.LogId = i.LogId
        INNER JOIN dbo.[Log] AS b ON b.LogId = i.ReferencedLogId
        WHERE a.SeriesId <> b.SeriesId)
        THROW 50053, N'A log can only reference logs in the same series.', 1;
END;
