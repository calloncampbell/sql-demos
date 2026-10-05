CREATE TABLE dbo.CharacterSpecies
(
    CharacterId  INT          NOT NULL,
    SpeciesId    INT          NOT NULL,
    IsPrimary    BIT          NOT NULL CONSTRAINT DF_CharacterSpecies_IsPrimary DEFAULT (1),
    CreatedAt    DATETIME2(0) NOT NULL CONSTRAINT DF_CharacterSpecies_CreatedAt DEFAULT (SYSUTCDATETIME()),

    CONSTRAINT PK_CharacterSpecies PRIMARY KEY CLUSTERED (CharacterId, SpeciesId),
    CONSTRAINT FK_CharacterSpecies_Character FOREIGN KEY (CharacterId) REFERENCES dbo.[Character] (CharacterId) ON DELETE CASCADE,
    CONSTRAINT FK_CharacterSpecies_Species FOREIGN KEY (SpeciesId) REFERENCES dbo.Species (SpeciesId)
);
GO

CREATE NONCLUSTERED INDEX IX_CharacterSpecies_SpeciesId
    ON dbo.CharacterSpecies (SpeciesId)
    INCLUDE (IsPrimary);
GO

-- A character can have only one primary species (hybrids such as Spock list a secondary species).
CREATE UNIQUE NONCLUSTERED INDEX UX_CharacterSpecies_OnePrimary
    ON dbo.CharacterSpecies (CharacterId)
    WHERE IsPrimary = 1;
