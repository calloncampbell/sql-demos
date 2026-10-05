-- Links a log to another log about the same incident or event.
CREATE TABLE dbo.LogReference
(
    LogId            INT          NOT NULL,
    ReferencedLogId  INT          NOT NULL,
    CreatedAt        DATETIME2(0) NOT NULL CONSTRAINT DF_LogReference_CreatedAt DEFAULT (SYSUTCDATETIME()),

    CONSTRAINT PK_LogReference PRIMARY KEY CLUSTERED (LogId, ReferencedLogId),
    CONSTRAINT CK_LogReference_NoSelfReference CHECK (LogId <> ReferencedLogId),
    CONSTRAINT FK_LogReference_Log FOREIGN KEY (LogId) REFERENCES dbo.[Log] (LogId) ON DELETE CASCADE,
    CONSTRAINT FK_LogReference_ReferencedLog FOREIGN KEY (ReferencedLogId) REFERENCES dbo.[Log] (LogId)
);
GO

CREATE NONCLUSTERED INDEX IX_LogReference_ReferencedLogId
    ON dbo.LogReference (ReferencedLogId);
