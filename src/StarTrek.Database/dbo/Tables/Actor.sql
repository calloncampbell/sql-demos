CREATE TABLE dbo.Actor
(
    ActorId    INT IDENTITY(1, 1) NOT NULL,
    FirstName  NVARCHAR(50)       NOT NULL,
    LastName   NVARCHAR(50)       NOT NULL,
    FullName   AS (CAST(FirstName + N' ' + LastName AS NVARCHAR(101))) PERSISTED NOT NULL,
    BirthDate  DATE               NULL,
    DeathDate  DATE               NULL,
    CreatedAt  DATETIME2(0)       NOT NULL CONSTRAINT DF_Actor_CreatedAt DEFAULT (SYSUTCDATETIME()),

    CONSTRAINT PK_Actor PRIMARY KEY CLUSTERED (ActorId),
    CONSTRAINT UQ_Actor_FullName UNIQUE (FullName),
    CONSTRAINT CK_Actor_DeathAfterBirth CHECK (DeathDate IS NULL OR BirthDate IS NULL OR DeathDate > BirthDate)
);
GO

CREATE NONCLUSTERED INDEX IX_Actor_LastName_FirstName
    ON dbo.Actor (LastName, FirstName);
