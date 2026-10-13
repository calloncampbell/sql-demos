CREATE TABLE dbo.Series
(
    SeriesId          INT IDENTITY(1, 1) NOT NULL,
    Abbreviation      VARCHAR(5)         NOT NULL,
    Name              NVARCHAR(100)      NOT NULL,
    PremiereDate      DATE               NOT NULL,
    FinaleDate        DATE               NULL,
    SeasonCount       TINYINT            NULL,
    EpisodeCount      SMALLINT           NULL,
    OriginalNetwork   NVARCHAR(50)       NULL,
    SettingStartYear  SMALLINT           NULL,
    SettingEndYear    SMALLINT           NULL,
    CreatedAt         DATETIME2(0)       NOT NULL CONSTRAINT DF_Series_CreatedAt DEFAULT (SYSUTCDATETIME()),
    -- A "series" row is any production: a TV series or a feature film (PremiereDate = release date).
    ProductionType    VARCHAR(10)        NOT NULL CONSTRAINT DF_Series_ProductionType DEFAULT ('Series'),
    [Format]          VARCHAR(12)        NOT NULL CONSTRAINT DF_Series_Format DEFAULT ('Live-action'),
    TimelineId        TINYINT            NOT NULL CONSTRAINT DF_Series_TimelineId DEFAULT (1),

    CONSTRAINT PK_Series PRIMARY KEY CLUSTERED (SeriesId),
    CONSTRAINT UQ_Series_Abbreviation UNIQUE (Abbreviation),
    CONSTRAINT UQ_Series_Name UNIQUE (Name),
    CONSTRAINT CK_Series_FinaleAfterPremiere CHECK (FinaleDate IS NULL OR FinaleDate >= PremiereDate),
    CONSTRAINT CK_Series_SeasonCount CHECK (SeasonCount IS NULL OR SeasonCount > 0),
    CONSTRAINT CK_Series_EpisodeCount CHECK (EpisodeCount IS NULL OR EpisodeCount > 0),
    CONSTRAINT CK_Series_SettingYears CHECK (SettingEndYear IS NULL OR SettingStartYear IS NULL OR SettingEndYear >= SettingStartYear),
    CONSTRAINT CK_Series_ProductionType CHECK (ProductionType IN ('Series', 'Film')),
    CONSTRAINT CK_Series_Format CHECK ([Format] IN ('Live-action', 'Animated')),
    CONSTRAINT CK_Series_ProductionShape CHECK (
        (ProductionType = 'Series' AND SeasonCount IS NOT NULL AND OriginalNetwork IS NOT NULL)
        OR (ProductionType = 'Film' AND SeasonCount IS NULL AND EpisodeCount IS NULL AND OriginalNetwork IS NULL AND FinaleDate IS NULL)),
    CONSTRAINT FK_Series_Timeline FOREIGN KEY (TimelineId) REFERENCES dbo.Timeline (TimelineId)
);
GO

CREATE NONCLUSTERED INDEX IX_Series_TimelineId
    ON dbo.Series (TimelineId);
