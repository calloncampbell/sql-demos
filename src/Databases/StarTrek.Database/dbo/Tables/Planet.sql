CREATE TABLE dbo.Planet
(
    PlanetId     INT IDENTITY(1, 1) NOT NULL,
    Name         NVARCHAR(100)      NOT NULL,
    Quadrant     VARCHAR(10)        NULL,
    PlanetClass  CHAR(1)            NULL,
    CreatedAt    DATETIME2(0)       NOT NULL CONSTRAINT DF_Planet_CreatedAt DEFAULT (SYSUTCDATETIME()),

    CONSTRAINT PK_Planet PRIMARY KEY CLUSTERED (PlanetId),
    CONSTRAINT UQ_Planet_Name UNIQUE (Name),
    CONSTRAINT CK_Planet_Quadrant CHECK (Quadrant IN ('Alpha', 'Beta', 'Gamma', 'Delta'))
);
