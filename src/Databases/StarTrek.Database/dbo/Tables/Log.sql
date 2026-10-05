-- A crew log entry: written by a character, aboard a vessel, at a stardate, in a series.
-- SeriesId disambiguates vessels and characters that span series (e.g. Enterprise NCC-1701 in TOS and SNW).
-- Personal logs are Confidential/Private; read logs through dbo.PublicLog or dbo.LogsVisibleTo.
CREATE TABLE dbo.[Log]
(
    LogId              INT IDENTITY(1, 1) NOT NULL,
    LogTypeId          INT                NOT NULL,
    VesselId           INT                NOT NULL,
    SeriesId           INT                NOT NULL,
    AuthorCharacterId  INT                NOT NULL,
    Stardate           DECIMAL(10, 2)     NOT NULL,
    LoggedAt           DATETIME2(0)       NULL,
    Title              NVARCHAR(200)      NOT NULL,
    Content            NVARCHAR(MAX)      NOT NULL,
    Classification     VARCHAR(12)        NOT NULL CONSTRAINT DF_Log_Classification DEFAULT ('Public'),
    CreatedAt          DATETIME2(0)       NOT NULL CONSTRAINT DF_Log_CreatedAt DEFAULT (SYSUTCDATETIME()),

    CONSTRAINT PK_Log PRIMARY KEY CLUSTERED (LogId),
    -- Natural key used by seed scripts.
    CONSTRAINT UQ_Log_Author_Series_Stardate_Title UNIQUE (AuthorCharacterId, SeriesId, Stardate, Title),
    CONSTRAINT CK_Log_Classification CHECK (Classification IN ('Public', 'Classified', 'Confidential', 'Private')),
    CONSTRAINT FK_Log_LogType FOREIGN KEY (LogTypeId) REFERENCES dbo.LogType (LogTypeId),
    CONSTRAINT FK_Log_Vessel FOREIGN KEY (VesselId) REFERENCES dbo.Vessel (VesselId),
    CONSTRAINT FK_Log_Series FOREIGN KEY (SeriesId) REFERENCES dbo.Series (SeriesId),
    CONSTRAINT FK_Log_Author FOREIGN KEY (AuthorCharacterId) REFERENCES dbo.[Character] (CharacterId)
);
GO

CREATE NONCLUSTERED INDEX IX_Log_VesselId_Stardate
    ON dbo.[Log] (VesselId, Stardate)
    INCLUDE (SeriesId, LogTypeId, AuthorCharacterId, Classification);
GO

CREATE NONCLUSTERED INDEX IX_Log_AuthorCharacterId
    ON dbo.[Log] (AuthorCharacterId)
    INCLUDE (Stardate, Classification);
GO

CREATE NONCLUSTERED INDEX IX_Log_SeriesId_Stardate
    ON dbo.[Log] (SeriesId, Stardate);
GO

CREATE NONCLUSTERED INDEX IX_Log_LogTypeId
    ON dbo.[Log] (LogTypeId);
