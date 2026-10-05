CREATE TABLE dbo.Species
(
    SpeciesId          INT IDENTITY(1, 1) NOT NULL,
    Name               NVARCHAR(100)      NOT NULL,
    HomeworldPlanetId  INT                NULL,
    IsHumanoid         BIT                NOT NULL CONSTRAINT DF_Species_IsHumanoid DEFAULT (1),
    CreatedAt          DATETIME2(0)       NOT NULL CONSTRAINT DF_Species_CreatedAt DEFAULT (SYSUTCDATETIME()),

    CONSTRAINT PK_Species PRIMARY KEY CLUSTERED (SpeciesId),
    CONSTRAINT UQ_Species_Name UNIQUE (Name),
    CONSTRAINT FK_Species_Planet FOREIGN KEY (HomeworldPlanetId) REFERENCES dbo.Planet (PlanetId)
);
GO

CREATE NONCLUSTERED INDEX IX_Species_HomeworldPlanetId
    ON dbo.Species (HomeworldPlanetId);
