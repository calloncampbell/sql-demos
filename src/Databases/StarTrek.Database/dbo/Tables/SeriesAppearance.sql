CREATE TABLE dbo.SeriesAppearance
(
    ActorCharacterId  INT          NOT NULL,
    SeriesId          INT          NOT NULL,
    RoleType          VARCHAR(10)  NOT NULL,
    -- Seasons are NULL for films.
    FirstSeason       TINYINT      NULL,
    LastSeason        TINYINT      NULL,
    CreatedAt         DATETIME2(0) NOT NULL CONSTRAINT DF_SeriesAppearance_CreatedAt DEFAULT (SYSUTCDATETIME()),
    PerformanceType   VARCHAR(10)  NOT NULL CONSTRAINT DF_SeriesAppearance_PerformanceType DEFAULT ('On-screen'),
    -- Timeline of the character version portrayed (e.g. Nimoy's Spock Prime in the Kelvin films).
    TimelineId        TINYINT      NOT NULL CONSTRAINT DF_SeriesAppearance_TimelineId DEFAULT (1),

    CONSTRAINT PK_SeriesAppearance PRIMARY KEY CLUSTERED (ActorCharacterId, SeriesId),
    CONSTRAINT CK_SeriesAppearance_RoleType CHECK (RoleType IN ('Main', 'Recurring', 'Guest', 'Supporting', 'Cameo')),
    CONSTRAINT CK_SeriesAppearance_Seasons CHECK (
        (FirstSeason IS NULL AND LastSeason IS NULL)
        OR (FirstSeason >= 1 AND LastSeason >= FirstSeason)),
    CONSTRAINT CK_SeriesAppearance_PerformanceType CHECK (PerformanceType IN ('On-screen', 'Voice')),
    CONSTRAINT FK_SeriesAppearance_ActorCharacter FOREIGN KEY (ActorCharacterId) REFERENCES dbo.ActorCharacter (ActorCharacterId) ON DELETE CASCADE,
    CONSTRAINT FK_SeriesAppearance_Series FOREIGN KEY (SeriesId) REFERENCES dbo.Series (SeriesId),
    CONSTRAINT FK_SeriesAppearance_Timeline FOREIGN KEY (TimelineId) REFERENCES dbo.Timeline (TimelineId)
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
GO

CREATE NONCLUSTERED INDEX IX_SeriesAppearance_TimelineId
    ON dbo.SeriesAppearance (TimelineId);
