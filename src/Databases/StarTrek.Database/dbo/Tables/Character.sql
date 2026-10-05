CREATE TABLE dbo.[Character]
(
    CharacterId    INT IDENTITY(1, 1) NOT NULL,
    Name           NVARCHAR(100)      NOT NULL,
    Gender         VARCHAR(10)        NOT NULL CONSTRAINT DF_Character_Gender DEFAULT ('Unknown'),
    HomePlanetId   INT                NULL,
    AffiliationId  INT                NULL,
    CreatedAt      DATETIME2(0)       NOT NULL CONSTRAINT DF_Character_CreatedAt DEFAULT (SYSUTCDATETIME()),

    CONSTRAINT PK_Character PRIMARY KEY CLUSTERED (CharacterId),
    CONSTRAINT UQ_Character_Name UNIQUE (Name),
    CONSTRAINT CK_Character_Gender CHECK (Gender IN ('Male', 'Female', 'Unknown')),
    CONSTRAINT FK_Character_Planet FOREIGN KEY (HomePlanetId) REFERENCES dbo.Planet (PlanetId),
    CONSTRAINT FK_Character_Affiliation FOREIGN KEY (AffiliationId) REFERENCES dbo.Affiliation (AffiliationId)
);
GO

CREATE NONCLUSTERED INDEX IX_Character_HomePlanetId
    ON dbo.[Character] (HomePlanetId);
GO

CREATE NONCLUSTERED INDEX IX_Character_AffiliationId
    ON dbo.[Character] (AffiliationId);
