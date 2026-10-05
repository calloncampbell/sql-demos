-- Free-form tags on a log, e.g. 'first-contact', 'warp-core'. Stored lower-case by convention.
CREATE TABLE dbo.LogTag
(
    LogId      INT           NOT NULL,
    Tag        NVARCHAR(50)  NOT NULL,
    CreatedAt  DATETIME2(0)  NOT NULL CONSTRAINT DF_LogTag_CreatedAt DEFAULT (SYSUTCDATETIME()),

    CONSTRAINT PK_LogTag PRIMARY KEY CLUSTERED (LogId, Tag),
    CONSTRAINT CK_LogTag_Tag CHECK (LEN(LTRIM(RTRIM(Tag))) > 0),
    CONSTRAINT FK_LogTag_Log FOREIGN KEY (LogId) REFERENCES dbo.[Log] (LogId) ON DELETE CASCADE
);
GO

CREATE NONCLUSTERED INDEX IX_LogTag_Tag
    ON dbo.LogTag (Tag);
