-- Lookup of log kinds. Category groups them (Personal / Command / Department);
-- DefaultClassification is what a new log of this type should normally be filed as.
CREATE TABLE dbo.LogType
(
    LogTypeId              INT IDENTITY(1, 1) NOT NULL,
    Name                   NVARCHAR(50)       NOT NULL,
    Category               VARCHAR(10)        NOT NULL,
    DefaultClassification  VARCHAR(12)        NOT NULL CONSTRAINT DF_LogType_DefaultClassification DEFAULT ('Public'),
    CreatedAt              DATETIME2(0)       NOT NULL CONSTRAINT DF_LogType_CreatedAt DEFAULT (SYSUTCDATETIME()),

    CONSTRAINT PK_LogType PRIMARY KEY CLUSTERED (LogTypeId),
    CONSTRAINT UQ_LogType_Name UNIQUE (Name),
    CONSTRAINT CK_LogType_Category CHECK (Category IN ('Personal', 'Command', 'Department')),
    CONSTRAINT CK_LogType_DefaultClassification CHECK (DefaultClassification IN ('Public', 'Classified', 'Confidential', 'Private'))
);
