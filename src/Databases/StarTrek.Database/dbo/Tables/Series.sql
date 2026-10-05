CREATE TABLE dbo.Series
(
    SeriesId          INT IDENTITY(1, 1) NOT NULL,
    Abbreviation      VARCHAR(5)         NOT NULL,
    Name              NVARCHAR(100)      NOT NULL,
    PremiereDate      DATE               NOT NULL,
    FinaleDate        DATE               NULL,
    SeasonCount       TINYINT            NOT NULL,
    EpisodeCount      SMALLINT           NULL,
    OriginalNetwork   NVARCHAR(50)       NOT NULL,
    SettingStartYear  SMALLINT           NULL,
    SettingEndYear    SMALLINT           NULL,
    CreatedAt         DATETIME2(0)       NOT NULL CONSTRAINT DF_Series_CreatedAt DEFAULT (SYSUTCDATETIME()),

    CONSTRAINT PK_Series PRIMARY KEY CLUSTERED (SeriesId),
    CONSTRAINT UQ_Series_Abbreviation UNIQUE (Abbreviation),
    CONSTRAINT UQ_Series_Name UNIQUE (Name),
    CONSTRAINT CK_Series_FinaleAfterPremiere CHECK (FinaleDate IS NULL OR FinaleDate >= PremiereDate),
    CONSTRAINT CK_Series_SeasonCount CHECK (SeasonCount > 0),
    CONSTRAINT CK_Series_EpisodeCount CHECK (EpisodeCount IS NULL OR EpisodeCount > 0),
    CONSTRAINT CK_Series_SettingYears CHECK (SettingEndYear IS NULL OR SettingStartYear IS NULL OR SettingEndYear >= SettingStartYear)
);
