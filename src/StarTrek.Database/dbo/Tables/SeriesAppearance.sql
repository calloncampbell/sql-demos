CREATE TABLE dbo.SeriesAppearance
(
    ActorCharacterId  INT          NOT NULL,
    SeriesId          INT          NOT NULL,
    RoleType          VARCHAR(10)  NOT NULL,
    FirstSeason       TINYINT      NOT NULL,
    LastSeason        TINYINT      NOT NULL,
    CreatedAt         DATETIME2(0) NOT NULL CONSTRAINT DF_SeriesAppearance_CreatedAt DEFAULT (SYSUTCDATETIME()),

    CONSTRAINT PK_SeriesAppearance PRIMARY KEY CLUSTERED (ActorCharacterId, SeriesId),
    CONSTRAINT CK_SeriesAppearance_RoleType CHECK (RoleType IN ('Main', 'Recurring', 'Guest')),
    CONSTRAINT CK_SeriesAppearance_Seasons CHECK (FirstSeason >= 1 AND LastSeason >= FirstSeason),
    CONSTRAINT FK_SeriesAppearance_ActorCharacter FOREIGN KEY (ActorCharacterId) REFERENCES dbo.ActorCharacter (ActorCharacterId) ON DELETE CASCADE,
    CONSTRAINT FK_SeriesAppearance_Series FOREIGN KEY (SeriesId) REFERENCES dbo.Series (SeriesId)
);
GO

CREATE NONCLUSTERED INDEX IX_SeriesAppearance_SeriesId
    ON dbo.SeriesAppearance (SeriesId)
    INCLUDE (RoleType, FirstSeason, LastSeason);
GO

-- Filtered index supporting the very common "main cast" queries.
CREATE NONCLUSTERED INDEX IX_SeriesAppearance_MainCast
    ON dbo.SeriesAppearance (SeriesId, ActorCharacterId)
    WHERE RoleType = 'Main';
