CREATE TABLE dbo.Timeline
(
    TimelineId   TINYINT        NOT NULL,
    Name         NVARCHAR(50)   NOT NULL,
    [Description] NVARCHAR(400) NULL,
    CreatedAt    DATETIME2(0)   NOT NULL CONSTRAINT DF_Timeline_CreatedAt DEFAULT (SYSUTCDATETIME()),

    CONSTRAINT PK_Timeline PRIMARY KEY CLUSTERED (TimelineId),
    CONSTRAINT UQ_Timeline_Name UNIQUE (Name)
);
